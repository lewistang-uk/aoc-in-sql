## 📆 Day 11

**[❓ Problem](https://adventofcode.com/2025/day/11)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day11_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day11_p2.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Query Optimisation` `BFS`

## 1️⃣ Part 1

The task is to find the total number of routes between two nodes, given a set of edges.

After parsing the input into a table containing the edges, a BFS-style approach was implemented with a recursive CTE, enumerating all possible paths.
Counting the number of paths to the required node gave the solution.

This solution was initally slow, so the query plan was analysed.
I found that the edges were generated only when required.
Choosing to materialise the edges led to a solution running over 500 times faster, despite only using O(n) extra space.

## 2️⃣ Part 2

The task is to find the total number of routes between a different set of nodes which pass through two given nodes.

An approach similar to part 1 would work: enumerating paths and counting only the paths which meet all of the requirements.
However, the input is constructed such that this would be highly inefficient.
The input also forms a directed acyclic grpah, so the better solution would be to implement a dynamic programming approach.