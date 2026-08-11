## 📆 Day 3

**[❓ Problem](https://adventofcode.com/2025/day/3)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day03_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day03_p2.sql)**

## ⛏️ Techniques Used

`String Manipulation` `Recursive CTEs`

## 1️⃣ Part 1

The task is to select two digits in order which give the largest number for each line, and calculate the sum.

The approach used was to select the largest digit in the string excluding the final digit as the first digit.
The last digit is selected from the remaining portion of the string after exclusing digits up to and including the first digit.

To find the largest digit in a substring, a recursive CTE could have been used, which would require only one pass.
However, I decided to hard-code the search using a CASE statement, starting from '9' and searching in a descending order.

Concatenating the digits and summing gives the required result.

## 2️⃣ Part 2

The task is to select 12 digits in order to find the largest number in each line.

Similar to part 1, the largest digit in a substring can be selected, adjusting the substring for each digit.

This is easiest in a recursive CTE, stopping when the number of digits selected was equal to 12. 
Unlike part 1, there is no option to find the largest digit in each substring via recursive CTE due to limitations with SQLite. 
The hard-coded search was implemented, tracking the index of the last digit and the current selections within the CTE.

Summing the 12-digit numbers gives the required result.
