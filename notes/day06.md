## 📆 Day 6

**[❓ Problem](https://adventofcode.com/2025/day/6)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day06_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day06_p2.sql)**

## ⛏️ Techniques Used

`Gaps and Islands` `String Manipulation` `Mathematics` `Recursive CTEs` `Subqueries`

## 1️⃣ Part 1

The task is to sum or multiply numbers downwards, with calculations separated by blank columns. The required operation is given on the final line.

By normalising all of the spaces, each number and its column can be found. The aggregated sums and products were calculated after grouping by column.

Since SQLite does not have an aggregation for multiplication, a mathematical workaround was used. Taking the exponentiated sum of logarithms is equivalent to multiplication, rounding the result to mitigate floating point errors after logarithms.

The appropriate result can be selected using a subquery to find the columns of each sign, and the sum of these results gives the solution.

## 2️⃣ Part 2

The task is to read numbers downwards by column, before summing or multiplying based on the operation on the final line. 

Instead of normalising the spaces, the characters at each index were found. 
After concatenation by j, the blank columns could be filtered, turning the problem into a gaps and islands problem.

The usual gaps and islands implementation using j - ROW_NUMBER() was used, so that each island had a unique identifier. To normalise this with the operation indices, a constant 1 was added. 

The sum and product for each group then follows the implementation in part 1, grouping by the island identifier.
The solution can be found with a similar final query.