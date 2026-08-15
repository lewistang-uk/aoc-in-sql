## 📆 Day 4

**[❓ Problem](https://adventofcode.com/2025/day/4)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day04_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day04_p2.sql)**

## ⛏️ Techniques Used

`Recursive CTEs` `Subqueries` `Joins`

## 1️⃣ Part 1

The task is to count the number of rolls (@) where there are no more than 4 other rolls in the 8 surrounding positions.

Using a recursive CTE, the grid-like input was parsed into a CTE containing the index i, j and the corresponding character.
By selecting only the entries where the character was @, the surrounding indices could be checked via subqueries.

Counting the number of rolls where the surrounding roll count was less than 4 gives the required result.

## 2️⃣ Part 2

The task is to recursively remove rolls until no more can be removed, with the same criteria as Part 1.

This is simple in most programming languages and even other dialects of SQL, by iterating the process from part 1.
However, within a recursive CTE, SQLite does not support aggregation, references to itself, or tables as arguments.
This makes approaches involving multiple removals in the same pass very difficult/impossible to implement.

I also considered recursively removing one roll at a time, with a delimited string as the "removed" set modified between recursions.
The choice of roll would be the lowest-indexed roll such that the eight surrounding rolls were either visited or not in the set of rolls.
Counting the total number of removals after this gives the required result.
Upon analysis, I discovered that this would take days to complete due to the inefficiency of finding a roll to remove.

I chose to implement a queue-based approach.
The input was padded once and flattened into a single line, allowing it to be passed into the recursive CTE and modified during iterations.
The queue was implemented as a comma-delimited string, with a pop method (use "instr" to split on the first comma) and an append method (concatenate queue with a value and a trailing comma).

The queue was initialised with every checkable index in the input.
Every iteration popped an index from the queue.
If the item at the index was removable, then a counter was increased, the string was modified to remove the roll and the eight neighbours were added to the queue.
Otherwise, the next index in the queue was considered.
Once the queue was empty, then the highest count gave the required result.

This solution is still less efficient than iterating part 1 until convergence (O(n^2) vs O(n)), but manages a reasonable 7-second runtime.