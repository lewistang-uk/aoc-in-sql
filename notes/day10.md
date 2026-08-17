## 📆 Day 10

**[❓ Problem](https://adventofcode.com/2025/day/10)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day10_p1.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `String Manipulation` `Mathematics`

## 1️⃣ Part 1

The task is to switch on a set of lights according to a given pattern, using buttons which switch on/off combinations of lights.

The approach used was to convert the light patterns and button combinations into binary, then to the base-10 representation.
This allowed XOR to be used in combining combinations of buttons.

For each light pattern, I searched through all 2^n combinations of buttons, which was possible since n was always small.
These were enumerated using a recursive CTE.
I used the fact that in a combination, a button is either selected or not selected.
Splitting each branch into two branches at every button allowed this enumeration, maintaining the number of buttons pressed and the combined XOR value.

Finding the lowest number of buttons pressed to reach the required pattern and summing over all patterns gave the result.