## 📆 Day 1

**[❓ Problem](https://adventofcode.com/2025/day/1)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day01_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day01_p2.sql)**

## ⛏️ Techniques Used

`Window Functions` `Mathematics` `Aggregation`

## 1️⃣ Part 1

The task is to count the number of times a dial numbered 0-99 stops at zero, with a list of turns made. The dial starts at 50.

After parsing the input into signed integers, a cumulative sum can be used to track the position of the dial after each turn. 
Counting the number of positions equal to 50 (mod 100) gives the solution.

## 2️⃣ Part 2

The task is to count the number of times the dial _passes_ zero. 

The cumulative sum is calculated as before.
The number of crossings can be deduced from the previous position and the current position, rounding each up or down to the next boundary depending on the direction of turn.
The sum of these numbers gives the solution.