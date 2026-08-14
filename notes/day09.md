## 📆 Day 9

**[❓ Problem](https://adventofcode.com/2025/day/9)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day09_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day09_p2.sql)**

## ⛏️ Techniques Used

`Query Optimisation` `Subqueries` `Joins`

## 1️⃣ Part 1

The task is to find the largest rectangle, using any pair of the coordinates as opposite corners. 

After parsing the coordinates using string methods, the areas of all possible rectangles can be found using a self-join.
Selecting the maximum of these gives the solution.

## 2️⃣ Part 2

The task is similar to part 1, however, the rectangle must be inside the polygon with vertices as the input coordinates.

The areas of all possible rectangles were found again, along with the x-coordinates of the vertical sides and the y-coordinates of the horizontal sides.
Checking the rectangle boundary against all edges to find edges inside the rectangle filtered out all invalid rectangles.
After this, the remaining areas could be sorted and choosing the largest area gives the result.

This query was optimised, since my initial solution took just under 4 minutes to run, despite only being O(n^3). 
Using EXPLAIN QUERY PLAN, I could analyse the steps that the SQLite engine would take to solve the problem.

The engine initially chose to only generate the edges and coordinates when needed in the main query, which is more memory-efficient.
However, this was not time-efficient, as the edges and coordinates were generated for every possible rectangle.
By explicitly making SQLite materialise both of these tables, the time taken to run dropped significantly while not using much more memory (O(n) extra).
Note that the time complexity of the algorithm remains O(n^3). 
The drop in time to run comes from the engine not having to create these two tables more than once.

### Time/Space Tradeoff

| Approach | Time to run (s) | Extra space needed |
|:--------:|:-----------:|:------------:|
| SQLite default | 224.4 | None |
| Materialise coordinates | 62.2 | O(n) |
| Materialise coordinates and edges | 1.7 | O(n) |