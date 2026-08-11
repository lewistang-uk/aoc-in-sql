# aoc-in-sql

Solutions to some of the Advent of Code 2025 problems using SQLite.

---

## Techniques

`Recursive CTEs` `Subqueries` `Window Functions` `Mathematics` `String Manipulation` `Complex Joins` `Gaps and Islands` `Aggregation`

---

## Structure 

```bash
aoc-in-sql/
├── .gitignore
├── README.md
├── run.py                 # runner to execute SQL solutions
├── inputs.example/        # example input folder
├── notes/                 # description of solutions
└── sql/                   # contains all SQL queries used
```

Inputs can be obtained from https://adventofcode.com/2025 after creating an account. These should be saved into text documents in an inputs/ folder. An example is in the repository.

---

## Instructions

Clone the repository, add input files, run the run.py script. Python version used is 3.14.2.

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

All other processing was done in a single SQL query using SQLite version 3.50.4. 
Note that SQLite does not have a splitting function or regular expressions by default, so other string methods were used.

---

## Solutions

| Day | Notes |
|:---:|:-----:|
| 01  | [Notes](./notes/day01.md) |
| 02  | [Notes](./notes/day02.md) |
| 03  | [Notes](./notes/day03.md) |
| 04  | [Notes](./notes/day04.md) |
| 05  | [Notes](./notes/day05.md) |
| 06  | [Notes](./notes/day06.md) |
| 07  | [Notes](./notes/day07.md) |

---

## Table Schema

| Column | Type | Description |
|:------:|:----:|:-----------:|
| id (PK) | INTEGER | The line numbers of the input, 1-indexed |
| ln | TEXT | The lines of the puzzle input |
