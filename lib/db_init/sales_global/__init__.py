#!/bin/python

import csv
import os

from ..utils import TableDefinition


THIS_DIR = os.path.dirname(__file__)


TABLES = [

    TableDefinition(
        "sales_usa",
        "(id SERIAL PRIMARY KEY, product_name VARCHAR(255), amount DECIMAL, sale_date DATE)",
        os.path.join(THIS_DIR, "sales_usa.csv")),
    TableDefinition(
        "sales_europe",
        "(id SERIAL PRIMARY KEY, product_name VARCHAR(255), amount DECIMAL, currency_code CHAR(3), sale_date DATE)",
        os.path.join(THIS_DIR, "sales_europe.csv")),

]
