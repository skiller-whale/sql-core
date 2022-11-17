import os
import re
import threading

import psycopg2
import tabulate

from . import db_init


# This is useful for, e.g., displaying EXPLAIN output where indentation should be preserved.
tabulate.PRESERVE_WHITESPACE = True


class PgExec:
    DATABASE_NAME_FILE = '.db_name'
    # Matches any integer, surrounded by '.' just before the file extension
    # (e.g. the 11 in my_file.11.sql) using lookbehind and lookahead groups
    # Note: Because of the $ at the end, this can match at most one group.
    FILE_NUMBER_REGEX = re.compile(r'(?<=\.)\d+(?=\.[^\.]+$)')

    # This is an extra safety measure to ensure that db dumps, and restores
    # never clash with each other, or with user queries.
    DATABASE_LOCK = threading.Lock()

    def __init__(self, database_names, output_lock=threading.Lock()):
        self.output_lock = output_lock
        print("Initialising databases")
        db_init.init(database_names)
        print("Initialisation complete")

    def execute_sql(self, connection, sql):
        # The first execute statement within this context block starts a new
        # transaction. On exiting the context block, all changes are committed,
        # unless there is a postgres error, in which case they are rolled back.
        with connection:
            with connection.cursor() as cursor:
                cursor.execute(sql)

                if not cursor.description:  # If no columns are returned
                    return [], []

                column_names = [column.name for column in cursor.description]
                return column_names, cursor.fetchall()

    @classmethod
    def get_db_name_from_path(cls, path):
        """Returns the content of a .db_name file in the directory"""
        dir_name, _ = os.path.split(path)
        db_file = os.path.join(dir_name, cls.DATABASE_NAME_FILE)

        if os.path.exists(db_file):
            with open(db_file) as file:
                db_name = file.read().strip()
                if db_name:
                    return db_name

        print(f"\nNo associated database found at {db_file}\n")
        return None

    def run_query(self, path, database_name, identifier=None, modify_connection=None):
        # Only display an identifier if one has been passed into the functino
        identifier_str = f"<{identifier}> | " if identifier else ""

        with self.output_lock:
            print(f'{identifier_str}Running File {path}')

        with open(path, "r") as f:
            contents = f.read()

        with self.output_lock:
            print(f"{identifier_str}Querying the database: {database_name}")

        # Do not retry - an invalid db name would get stuck in an infinite loop
        connection = db_init.get_connection(database_name, retry_time=None)
        if not connection:
            return  # Database error logging dealt with in get_connection

        if modify_connection:
            modify_connection(connection)

        try:
            query_columns, query_rows = self.execute_sql(connection, contents)
        except psycopg2.Error as err:
            connection.rollback()
            if repr(err) == 'ProgrammingError("can\'t execute an empty query")':
                message = "No query in file"
            else:
                message = f"POSTGRES ERROR: {err}"
            with self.output_lock:
                print(f'{identifier_str}{message}')
        else:
            with self.output_lock:
                if identifier:
                    print(f'{identifier_str}Query Complete. Results:')
                print(tabulate.tabulate(query_rows,
                                        headers=query_columns,
                                        tablefmt="psql",
                                        missingval="NULL"))
                print(f'Row Count: {len(query_rows)}')
                print()

    @classmethod
    def _get_related_file_regex(cls, path):
        """Returns a regex for matching 'peer' files of path

        If path were file_name.1.sql, then this regex would match any file with
        the structure file_name.X.sql where X is any integer.

        If FILE_NUMBER_REGEX is not matched, then return None
        """
        if not cls.FILE_NUMBER_REGEX.search(path):
            return None

        file_components = map(re.escape, cls.FILE_NUMBER_REGEX.split(path))
        return re.compile(r'(\d+)'.join(file_components))

    @classmethod
    def _get_files_and_identifiers_to_run(cls, path):
        """Identifies which other files should be run, when path is edited"""
        related_regex = cls._get_related_file_regex(path)
        if not related_regex:
            return { path: None }

        dir_name, _ = os.path.split(path)
        matches = [
            related_regex.fullmatch(os.path.join(dir_name, file))
            for file in os.listdir(dir_name)
            if os.path.isfile(os.path.join(dir_name, file))  # Not directories
        ]
        # Return dictionary of { full_path : number_identifier }
        return { match.group(0): match.group(1) for match in matches if match}

    @classmethod
    def _get_pre_file(cls, path):
        dirname, filename = os.path.split(path)

        if cls.FILE_NUMBER_REGEX.search(filename):
            # E.g. remove the .1 from my_file.1.sql to give my_file.sql
            start, end = cls.FILE_NUMBER_REGEX.split(filename)
            filename = start[:-1] + end

        pre_filename = '.pre.' + filename

        pre_path = os.path.join(dirname, pre_filename)

        if os.path.isfile(pre_path):
            return pre_path

        return None

    def run_threaded_queries(self, path, database_name):
        paths_to_run = self._get_files_and_identifiers_to_run(path)
        # Create one thread per related path to run.
        threads = [
            threading.Thread(
                target=self.run_query,
                args=(path, database_name, identifier)
            )
            for path, identifier in paths_to_run.items()
        ]
        for thread in threads:
            thread.start()
        # Ensure that all threads have completed before allowing the
        # main thread to start executing any new queries.
        for thread in threads:
            thread.join()

    def prepare_database(self, path, database_name):
        # run pre file
        pre_file = self._get_pre_file(path)
        if pre_file:
            with self.output_lock:
                print(f"Running pre file: {pre_file}")

            enable_autocommit = lambda connection: connection.set_session(autocommit=True)
            self.run_query(pre_file, database_name, modify_connection=enable_autocommit)

    def file_changed(self, path):
        # Will run a query against the database named according to the path
        database_name = self.get_db_name_from_path(path)
        if not database_name:
            return

        try:
            with self.DATABASE_LOCK:
                self.prepare_database(path, database_name)
                self.run_threaded_queries(path, database_name)
        except Exception as err:
            with self.output_lock:
                print("Unexpected error running query:", err)
        finally:
            with self.output_lock:
                print(f"Resetting database: {database_name}...")

            # Reset the database to its original state
            with self.DATABASE_LOCK:
                db_init.rebuild_database(database_name)

            with self.output_lock:
                print("Done")
                print()
