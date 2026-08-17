# aoc-in-sql

Solutions to some of the Advent of Code 2025 problems using SQLite.

---

## Techniques

`Recursive CTEs` `Subqueries` `Window Functions` `Mathematics` `String Manipulation` `Complex Joins` `Query Optimisation` `Gaps and Islands` `Aggregation`

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
No Python helper functions were used other than the above.

Each solution runs in a single SQL query using SQLite version 3.50.4. 
No CREATE, DELETE or INSERT statements were used.

Note that SQLite does not have a splitting function or regular expressions by default, so other string methods were used.

Recursive CTEs are the only way to implement recursion or iteration. 
However, these are very restrictive - aggregation is not permitted, and other CTEs cannot be defined within a recursive CTE.
This forces creative use of strings for data structures, for example, a queue in [Day 4 Part 2](./sql/day04_p2.sql) and a union-find in [Day 8 Part 2](./sql/day08_p2.sql).

---

## Solutions

Key: 

- ✅ - solved
- ☑️ - solved but rework needed
- 🟠 - unsolved

<<<<<<< Updated upstream
| Day | Part 1 | Part 2 | Notes |
|:---:|:------:|:------:|:----:|
| 01 | ✅ | ✅ | [Notes](./notes/day01.md) |
| 02 | ✅ | ✅ | [Notes](./notes/day02.md) |
| 03 | ✅ | ✅ | [Notes](./notes/day03.md) |
| 04 | ✅ | ✅ | [Notes](./notes/day04.md) |
| 05 | ✅ | ✅ | [Notes](./notes/day05.md) |
| 06 | ✅ | ✅ | [Notes](./notes/day06.md) |
| 07 | ✅ | ✅ | [Notes](./notes/day07.md) |
| 08 | ✅ | ✅ | [Notes](./notes/day08.md) |
| 09 | ✅ | ✅ | [Notes](./notes/day09.md) |
| 10 | 🟠 | 🟠 | TBC |
| 11 | ✅ | ☑️ | [Notes](./notes/day11.md) |
| 12 | ✅ | ✅\* | [Notes](./notes/day12.md) |
=======
| Day | Part 1 | Part 2 | Notes | Main Techniques |
|:---:|:------:|:------:|:-----:|:----------:|
| 01 | ✅ | ✅ | [Notes](./notes/day01.md) | `Window Functions` `Mathematics` `Aggregation` |
| 02 | ✅ | ✅ | [Notes](./notes/day02.md) | `Mathematics` `Recursive CTEs` |
| 03 | ✅ | ✅ | [Notes](./notes/day03.md) | `String Manipulation` `Recursive CTEs` |
| 04 | ✅ | ✅ | [Notes](./notes/day04.md) | `Recursive CTEs` `String Manipulation` |
| 05 | ✅ | ✅ | [Notes](./notes/day05.md) | `Joins` `Window Functions` `Subqueries` |
| 06 | ✅ | ✅ | [Notes](./notes/day06.md) | `Gaps and Islands` `Recursive CTEs` `Mathematics` |
| 07 | ✅ | ✅ | [Notes](./notes/day07.md) | `Recursive CTEs` `Subqueries` | 
| 08 | ✅ | ✅ | [Notes](./notes/day08.md) | `String Manipulation` `Recursive CTEs` `Joins` |
| 09 | ✅ | ✅ | [Notes](./notes/day09.md) | `Query Optimisation` `Subqueries` `Joins` |
| 10 | ✅ | 🟠 | [Notes](./notes/day10.md) | `Recursive CTEs` `String Manipulation` `Mathematics` |
| 11 | ✅ | ☑️ | [Notes](./notes/day11.md) | `Recursive CTEs` `Query Optimisation` |
| 12 | ✅ | ✅\* | [Notes](./notes/day12.md) | `String Manipulation` `Gaps and Islands` `Recursive CTEs` |
>>>>>>> Stashed changes

\* The final day of Advent of Code does not have a part 2.

---

## Table Schema

| Column | Type | Description |
|:------:|:----:|:-----------:|
| id (PK) | INTEGER | The line numbers of the input, 1-indexed |
| ln | TEXT | The lines of the puzzle input |
