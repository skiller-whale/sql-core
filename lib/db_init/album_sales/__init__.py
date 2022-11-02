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
        """(id SERIAL PRIMARY KEY,
            title VARCHAR(255),
            genre VARCHAR(255),
            release_date DATE,
            n_tracks INTEGER,
            minutes INTEGER,
            record_label VARCHAR(255),
            artist_id INTEGER REFERENCES artists(id),
            collaborator_id INTEGER REFERENCES artists(id))""",
        os.path.join(THIS_DIR, "albums.csv")),
    TableDefinition(
        "vendors",
        "(id SERIAL PRIMARY KEY, vendor_name VARCHAR(255))",
        os.path.join(THIS_DIR, "vendors.csv")),
    TableDefinition(
        "sales",
        "(id SERIAL PRIMARY KEY, album_id INTEGER REFERENCES albums(id), amount DECIMAL, date DATE, vendor_id INTEGER REFERENCES vendors(id))",
        os.path.join(THIS_DIR, "sales.csv")),
    TableDefinition(
        "industry_revenue_history",
        "(download_revenue_percent INTEGER, cd_revenue_percent INTEGER, streaming_revenue_percent INTEGER, period_start DATE, period_end DATE)",
        os.path.join(THIS_DIR, "industry_revenue_history.csv")),

]
