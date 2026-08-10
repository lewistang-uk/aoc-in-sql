# aoc-in-sql

Solutions to some of the Advent of Code 2025 problems using SQL.

---

## Structure 

```bash
aoc-in-sql/
├── .gitignore
├── README.md
├── inputs.example/        # example input folder
├── run.py                 # runner to execute SQL solutions
└── sql/                   # contains all SQL queries used
```

Inputs can be obtained from https://adventofcode.com/2025 after creating an account. These should be saved into text documents in an inputs/ folder. An example is in the repository.

---

## Instructions

Clone the repository, add input files, run the run.py script.

```bash
git clone https://github.com/lewistang-uk/aoc-in-sql.git
cd aoc-in-sql
# add input text documents as inputs/dayXX.txt
python run.py
```

---

## Challenges

Each puzzle input is read from a text file by the run.py script and saved line-by-line into a table. 
The query is then read and executed, with the output printed to stdout.

All other processing was done in a single SQL query using SQLite. 
Note that SQLite does not have a splitting function or regular expressions by default, so other string methods were used.

---

## Table Schema

| Column | Description |
|:------:|:-----------:|
| id (PK) | The line number of the input, 1-indexed |
| ln | The lines of the puzzle input |
