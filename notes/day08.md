## 📆 Day 8

**[❓ Problem](https://adventofcode.com/2025/day/8)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day08_p1.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Complex Joins`

## 1️⃣ Part 1

The task is to find the product of the cardinalities of the three largest circuits after connecting the 1000 closest coordinate pairs.

A list of edges was created by parsing the coordinates and calculating all pairwise distances with a CROSS JOIN.
The edges with the 1000 shortest distances were also reversed to make a list of undirected edges.

Initially, I tried using a BFS approach to find the visitable nodes from each node. 
After adjusting for overcounting, the product could be found, which would be a solution.
However, this approach did not scale well.

### BFS approach

| Number of edges | Run Time (s) |
|:---------------:|:------------:|
| 10 (example) | 0.003 |
| 100 | 0.972 |
| 200 | 0.958 |
| 500 | 1.20 |
| 700 | 6.83 |
| 800 | 63.6 |

I changed to a different approach: find the minimum node ID that each node is connected to.

By traversing the graph using a recursive CTE and joins, the "root" for each path through the graph could be stored in a table.
There was no risk of overcounting with this approach since the minimum node ID uniquely identifies each disjoint graph.
Finding the top three counts of minimum node ID and multiplying using the workaround in [Day 6](day06.md) gives the answer in roughly 1 second.