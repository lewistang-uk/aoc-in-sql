-- part two

-- find operations
WITH RECURSIVE operations (j, indx, op, ln) AS (
    SELECT
        1,
        instr(ln, ' ') + 1,
        substr(ln, 1, instr(ln, ' ') - 1),
        ln
    FROM day6
    WHERE id = (SELECT MAX(id) FROM day6) -- last row

    UNION ALL

    SELECT
        j + 1,
        indx + instr(substr(ln, indx), ' '),
        substr(ln, indx, instr(substr(ln, indx), ' ') - 1),
        ln
    FROM operations
    WHERE indx <= LENGTH(ln)    
),

-- assign each operation a group number
ops AS (
    SELECT
        op,
        ROW_NUMBER() OVER (ORDER BY j) AS grp
    FROM operations
    WHERE op <> ''
),

-- find numbers
numbers (i, j, num, ln) AS (
    SELECT
        id,
        1,
        substr(ln, 1, 1),
        ln
    FROM day6
    WHERE ln NOT LIKE '%*%'
    AND ln NOT LIKE '%+%'

    UNION ALL
    SELECT
        i,
        j+1,
        substr(ln, j+1, 1),
        ln    
    FROM numbers
    WHERE j <= LENGTH(ln)    
),

-- concatenate downwards (by j)
new_nums AS (
    SELECT
        j,
        CAST(LTRIM(GROUP_CONCAT(num, '')) AS INTEGER) AS num
    FROM numbers
    GROUP BY j
),

-- filter empty columns
non_zero AS (
    SELECT *
    FROM new_nums
    WHERE num <> 0
),

-- gaps and islands after removing empty columns
find_groups AS (
    SELECT
        j,
        num,
        j - ROW_NUMBER() OVER (ORDER BY j) AS grp
    FROM non_zero
),

-- find sum and prod as in part one
aggregated AS (
    SELECT
        grp + 1 AS grp, -- grouping invariant, operations are 1-indexed
        SUM(CAST(num AS INTEGER)) AS plus,
        ROUND(EXP(SUM(LN(CAST(num AS INTEGER)))), 0) AS star -- multiplication is addition in log space
    FROM find_groups
    GROUP BY grp
)

-- add either the sum or product depending on sign
SELECT
    SUM(
        CASE WHEN grp IN (SELECT grp FROM ops WHERE op = '*') THEN star
        WHEN grp IN (SELECT grp FROM ops WHERE op = '+') THEN plus
        ELSE 0 END
    ) AS result
FROM aggregated
;