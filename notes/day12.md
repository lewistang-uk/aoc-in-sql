## 📆 Day 12

**[❓ Problem](https://adventofcode.com/2025/day/12)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day12_p1.sql)**

## ⛏️ Techniques Used

`String Manipulation` `Recursive CTEs`

## 1️⃣ Part 1

The task is to find valid packing arrangements for presents with different shapes.

This problem is generally NP-hard. 
However, it has been noted online that the puzzle input allows for only an area check, by verifying that the area of presents does not exceed the area of the region.
The hardest part of this problem becomes parsing the input.

A gaps and islands approach was used to separate the input on blank lines. 
The area of the shapes can be found by flattening them into strings and counting how many characters remain after removing dots.
The area of the regions can be found by extracting the dimensions (using substr and instr) and multiplying.
The counts of each shape per region were found using a recursive CTE to split on spaces.

Multiplying the counts by the area of shapes using joins gives the total areas, which can be compared to the areas of regions with another join.
Counting the number of rows with shape area less than packing area gives the required result/