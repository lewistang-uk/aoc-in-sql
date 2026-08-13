## 📆 Day 4

**[❓ Problem](https://adventofcode.com/2025/day/4)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day04_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day04_p2.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Subqueries` `Joins`

## 1️⃣ Part 1

The task is to count the number of rolls (@) where there are no more than 4 other rolls in the 8 surrounding positions.

Using a recursive CTE, the grid-like input was parsed into a CTE containing the index i, j and the corresponding character.
By selecting only the entries where the character was @, the surrounding indices could be checked via subqueries.

Counting the number of rolls where the surrounding roll count was less than 4 gives the required result.

## 2️⃣ Part 2

The task is to recursively remove rolls until no more can be removed, with the same criteria as Part 1.

This is simple in most programming languages and even other dialects of SQL, by iterating the process from part 1.
However, within a recursive CTE, SQLite does not support aggregation, references to itself, or tables as arguments.
This makes many approaches very difficult/impossible to implement.

The approach chosen was to recursively remove one roll at a time, with a delimited string as the "visited" set modified between recursions.
Counting the total number of removals after this gives the required result.

Running this code would take days to complete due to the inefficiency of finding a roll to remove.
The run.py script skips this part.