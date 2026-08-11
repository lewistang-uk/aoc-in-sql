## 📆 Day 4

**[❓ Problem](https://adventofcode.com/2025/day/4)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day04_p1.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Subqueries`

## 1️⃣ Part 1

The task is to count the number of rolls (@) where there are no more than 4 other rolls in the 8 surrounding positions.

Using a recursive CTE, the grid-like input was parsed into a CTE containing the index i, j and the corresponding character.
By selecting only the entries where the character was @, the surrounding indices could be checked via subqueries.

Counting the number of rolls where the surrounding roll count was less than 4 gives the required result.