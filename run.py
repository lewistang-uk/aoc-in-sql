import sqlite3

conn = sqlite3.connect("aoc.db")
cursor = conn.cursor()

cursor.execute("DROP TABLE IF EXISTS day1")
cursor.execute(
"""
CREATE TABLE day1 (
    id INTEGER PRIMARY KEY,
    ln TEXT
)
"""
)

with open("inputs/day01.txt") as f:
    cursor.executemany(
        "INSERT INTO day1 (ln) VALUES (?)",
        ((line.rstrip("\n"),) for line in f)
    )

conn.commit()

# part one
with open("sql/day01_p1.sql") as f:
    query = f.read()

rows = cursor.execute(query).fetchall()

for row in rows:
    print(row)

# part two
with open("sql/day01_p2.sql") as f:
    query = f.read()

rows = cursor.execute(query).fetchall()

for row in rows:
    print(row)

conn.close()
