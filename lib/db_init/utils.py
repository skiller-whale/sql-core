import csv

from psycopg2 import sql


class TableDefinition:
    def __init__(self, name, definition, data_csv=None):
        self.name = name
        self.definition = definition
        self.data_csv = data_csv

    def create_table(self, connection):
        with connection.cursor() as cursor:
            cursor.execute(
                sql.SQL("CREATE TABLE {name} {definition};").format(
                    name=sql.Identifier(self.name),
                    definition=sql.SQL(self.definition),
                )
            )
        connection.commit()

    def seed_table(self, connection):
        if not self.data_csv:
            return

        with connection.cursor() as cursor, \
             open(self.data_csv) as csv_file:

            # Read the first row of the csv file with the csv reader module to
            # get the headers. This advances the file pointer to first data row
            reader = csv.reader(csv_file)
            headers = next(reader)

            # Use the SQL COPY function to read CSV in from the file stream.
            # This will start at the second line of the file, and use the
            # Postgres CSV mode to deal with the format (e.g. quoted commas).
            cursor.copy_expert(
                sql.SQL("""
                    COPY {table} ({columns})
                    FROM STDIN
                    WITH (FORMAT CSV);
                """).format(
                    table=sql.Identifier(self.name),
                    columns=sql.SQL(', ').join(map(sql.Identifier, headers)),
                ),
                csv_file
            )
        connection.commit()


class IndexDefinition:
    def __init__(self, name, table, columns, predicate=None, index_type=None):
        self.name = name
        self.table = table
        self.columns = columns
        self.predicate = predicate
        self.index_type = index_type

    def create_index(self, connection):
        query = sql.SQL("CREATE INDEX {name} ON {table}").format(
            name=sql.Identifier(self.name),
            table=sql.Identifier(self.table),
        )
        if self.index_type:
            query = sql.SQL("{query} USING {index_type}").format(
                query=query,
                index_type=sql.SQL(self.index_type)
            )
        query = sql.SQL("{query} ({columns})").format(
            query=query,
            columns=sql.SQL(self.columns)
        )
        if self.predicate:
            query = sql.SQL("{query} WHERE {predicate}").format(
                query=query,
                predicate=sql.SQL(self.predicate)
            )
        query = sql.SQL("{query};").format(query=query)

        with connection.cursor() as cursor:
            cursor.execute(query)
        connection.commit()
