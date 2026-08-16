## 📆 Day 8

**[❓ Problem](https://adventofcode.com/2025/day/8)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day08_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day08_p2.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Complex Joins` `String Manipulation`

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
The minimum root can then be found for each node in one aggregation.

The main advantage is that the path from the root to each node does not matter in this approach, so individual paths do not have to be stored. 
In a complex graph, there can be many paths that go from the root to a given node.
In addition, there was no risk of overcounting with this approach, since the minimum node ID uniquely identifies each disjoint graph.

Finding the top three counts of minimum node ID and multiplying using the workaround in [Day 6](day06.md) gives the answer in roughly 1 second.

## 2️⃣ Part 2

The task is to find the product of the x-values of the final edge connecting all nodes.

Since the edges have to be considered in order of distance (weight), this implied an application of Kruskal's algorithm.
Kruskal's algorithm needs a way to determine if two nodes are already connected.
This had to be done within a recursive CTE due to adding an edge every iteration, so any workaround would require string manipulation.
Specifically, the string must allow lookups to determine the current group a node belongs to, and replacements to combine groups.

I considered a string of the form "(nodeId,minNodeId)(nodeId,minNodeId)...", which allows lookups as instr(string, "(nodeId,") and replacements as REPLACE(string, ",oldId)", ",newId)"). 
However, this string is around two times longer than the chosen option.

I chose a string of the form "(minNodeId)(minNodeId)" with ids of a fixed length (3). 
Lookups are implemented as substr(string, 5 x id - 3, 3) to find the three digit id.
Replacements use the above replace method with (oldId) and (newId).

After implementing Kruskal's algorithm and stopping the recursive CTE after the required number of group merges, the x-coordinates could be found using joins.
Multiplying these gives the result in roughly 2 seconds.