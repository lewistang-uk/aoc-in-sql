import sqlite3
from pathlib import Path

# initialise db with inputs
conn = sqlite3.connect("aoc.db")
cursor = conn.cursor()

folder = Path("inputs")
files = [file.name for file in folder.iterdir() if file.is_file()]

for file in files:
    pth, _ = file.split(".") # returns ["dayXX", "txt"]

    with open(Path("inputs") / file) as f:
        cursor.execute(f"DROP TABLE IF EXISTS {pth}")
        cursor.execute(
            f"""
            CREATE TABLE {pth} (
                id INTEGER PRIMARY KEY,
                ln TEXT
            )
            """)
        cursor.executemany(
            f"INSERT INTO {pth} (ln) VALUES (?)",
            ((line.rstrip("\n"),) for line in f)
        )

conn.commit()

# run sql queries
folder = Path("sql")
files = [file.name for file in folder.iterdir() if file.is_file()]

for file in sorted(files):
    if file in ["day07_p2.sql", "day11_p2.sql"]:
        print(f"Solution to {file.split('.')[0]}: Not shown due to timeout")
        continue
    with open(Path("sql") / file) as f:
        query = f.read()

    pth, _ = file.split(".") # returns ["dayXX_pN", "sql"]
    rows = cursor.execute(query).fetchall()

    for row in rows:
        print(f"Solution to {pth}: {row}")

conn.close()
