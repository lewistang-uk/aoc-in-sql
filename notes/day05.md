## 📆 Day 5

**[❓ Problem](https://adventofcode.com/2025/day/5)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day05_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day05_p2.sql)**

## ⛏️ Techniques Used

`Complex Joins` `Window Functions` `Subqueries`

## 1️⃣ Part 1

The task is to count the given numbers which appear in any of the given ranges. 

After parsing the ranges into a CTE with columns range_start and range_end, a cross join can be used to check if a number is in any of the ranges. To avoid overcounting if a number lies in more than one range, this was done in a subquery.

Counting the distinct numbers with rows in the cross join gives the required result.

## 2️⃣ Part 2

The task is to count how many integers are in the union of the ranges. 

An implementation of Klee's algorithm was used. 
The ranges were converted from the form [a, b] to the form [a, b+1) to be compatible with integers.
Start and stop events were defined as (num, event_type) pairs (a, 1) and (b, -1) and sorted by both columns ascending.

Using the LEAD() and SUM() window functions, the events could be filtered such that the cumulative sum of event_type was positive, and the differences between valid adjacent events were summed to give the required result.