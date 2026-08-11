## 📆 Day 7

**[❓ Problem](https://adventofcode.com/2025/day/7)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day07_p1.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Subqueries`

## 1️⃣ Part 1

The task is to simulate a downwards beam of light which splits when it hits an arrow, and find how many arrow collisions occur.

The arrow positions (i, j) were found using a recursive CTE. 
The beam was simulated with a recursive CTE, finding the indices of the path of the beam. 
UNION was used instead of UNION ALL for efficiency, since the beam path does not change based on how many beam paths pass a given index.

Finally, the number of arrows with a beam directly above it are counted, giving the required solution.

Note that using UNION ALL would allow counting of the individual beam paths. This would theoretically solve part 2.
However, the number of paths grows exponentially, making this solution impossible for over 140 rows of input.