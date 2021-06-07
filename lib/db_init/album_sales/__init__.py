#!/bin/python

import csv
import os

from ..utils import TableDefinition


THIS_DIR = os.path.dirname(__file__)


TABLES = [
    TableDefinition(
        "artists",
        "(id SERIAL PRIMARY KEY, name VARCHAR(255))",
        os.path.join(THIS_DIR, "artists.csv")),
    TableDefinition(
        "albums",
        "(id SERIAL PRIMARY KEY, title VARCHAR(255), genre VARCHAR(255), release_date DATE, n_tracks INTEGER, minutes INTEGER, record_label VARCHAR(255), artist_id INTEGER REFERENCES artists(id))",
        os.path.join(THIS_DIR, "albums.csv")),
    TableDefinition(
        "sales",
        "(id SERIAL PRIMARY KEY, album_id INTEGER REFERENCES albums(id), amount DECIMAL, date DATE)",
        os.path.join(THIS_DIR, "sales.csv")),
]
