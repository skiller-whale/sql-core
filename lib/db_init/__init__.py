import importlib
import os
import time

import psycopg2
from psycopg2 import sql
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


user = os.getenv('POSTGRES_USER')
password = os.getenv('POSTGRES_PASSWORD')
host = os.getenv('POSTGRES_HOST')


def get_connection_string(database):
    return f"user={user} password={password} dbname={database} host={host}"


def get_connection(database=None, retry_time=None):
    while True:
        try:
            connection = psycopg2.connect(
                database=database,
                user=user,
                password=password,
                host=host)
            return connection
        except psycopg2.OperationalError:
            db_name = "postgres" if database is None else f'database: {database}'
            if retry_time is None:
                print(f"Couldn't connect to {db_name}")
                break  # Exit the while True loop
            print(f"Couldn't connect to {db_name}, retrying in {retry_time}s")
            time.sleep(retry_time)


def get_existing_databases(connection):
    with connection.cursor() as cursor:
        cursor.execute(sql.SQL('SELECT datname FROM pg_database'))
        return {result[0] for result in cursor.fetchall()}


def create_database(connection, database, print_logs=False):
    with connection.cursor() as cursor:
        if print_logs:
            print(f"Creating database {database}")
        command = sql.SQL('CREATE DATABASE {}').format(sql.Identifier(database))
        cursor.execute(command)


def build_and_seed_database(database, print_logs=False):
    connection = get_connection(database, retry_time=2)
    # Import the module at db_init/<database> and use its TABLE definitions
    module = importlib.import_module(f'.{database}', __name__)

    if print_logs:
        print(f"Building database: {database}")
    for table in module.TABLES:
        table.create_table(connection)

    if print_logs:
        print(f"Seeding database: {database}")
    for table in module.TABLES:
        table.seed_table(connection)

    if hasattr(module, "INDEXES"):
        if print_logs:
            print(f"Creating indexes for: {database}")
        for index in module.INDEXES:
            index.create_index(connection)


def drop_database(connection, database):
    with connection:
        with connection.cursor() as cursor:
            cursor.execute(sql.SQL('DROP DATABASE IF EXISTS {name};').format(
                name=sql.Identifier(database)
            ))


def rebuild_database(database, print_logs=False):
    start_time = time.time()
    connection = get_connection(retry_time=2)
    connection.autocommit = True
    drop_database(connection, database)
    create_database(connection, database, print_logs=print_logs)
    build_and_seed_database(database, print_logs=print_logs)
    if print_logs:
        print(f"\tDatabase built in {time.time() - start_time:.2f}s")


def init(database_names):
    connection = get_connection(retry_time=2)
    connection.autocommit = True

    # Only run initialization for databases that don't already exist.
    missing_databases = set(database_names) - get_existing_databases(connection)
    for database in missing_databases:
        rebuild_database(database, print_logs=True)
