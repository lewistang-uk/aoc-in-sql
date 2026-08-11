## 📆 Day 7

**[❓ Problem](https://adventofcode.com/2025/day/7)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day07_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day07_p2.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Subqueries`

## 1️⃣ Part 1

The task is to simulate a downwards beam of light which splits when it hits an arrow, and find how many arrow collisions occur.

The arrow positions (i, j) were found using a recursive CTE. 
The beam was simulated with a recursive CTE, finding the indices of the path of the beam. 
UNION was used instead of UNION ALL for efficiency, since the beam path does not change based on how many beam paths pass a given index.

Finally, the number of arrows with a beam directly above it are counted, giving the required solution.

## 2️⃣ Part 2

The task is to find the total number of beam paths.

The main restriction is with recursive CTEs in SQLite.
Aggregation and self-referencing is not permitted within a recursive CTE, making dynamic programming approaches basically impossible.

One approach is to enumerate all paths and count.
Note that using UNION ALL in the solution to part 1 would allow counting of the individual beam paths. This would theoretically solve part 2.
However, the number of paths grows exponentially, making this solution impossible for over 140 rows of input.

I chose to split the main recursion into four parts to significantly reduce the total number of paths enumerated. 
Between each mini-recursion, the indices and counts are aggregated to find the number of individual beams at each index.
Each future recursion records the current index and the index of the parent beam, of which the beam count is known.

After four rounds of recursions, the final aggregated counts can be summed to give the result, with a runtime under 1 minute.
