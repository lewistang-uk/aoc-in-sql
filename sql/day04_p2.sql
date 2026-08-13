-- part two

-- Example input runtime: 0.01 seconds
-- Puzzle input runtime: est. 3 days

-- find characters and their indices (i, j)
WITH RECURSIVE cte(i, j, ch, ln) AS (
    SELECT 
        id, 
        1, 
        substr(ln, 1, 1),
        ln
    FROM day4

    UNION ALL

    SELECT 
        i,
        j+1,
        substr(ln, j+1, 1),
        ln
    FROM cte
    WHERE j < length(ln)
),

-- filter characters for '@'
at_positions AS (
    SELECT 
        i,
        j
    FROM cte
    WHERE ch = '@'
),

-- remove one @ at a time
recursive_check_neighbours (removed_i, removed_j, removed, ct) AS (
    SELECT
        0,
        0,
        '/',
        0

    UNION ALL

    SELECT
        a.i,
        a.j,
        r.removed || a.i || ',' || a.j || '/',
        r.ct + 1
    FROM at_positions a
    CROSS JOIN recursive_check_neighbours r
    WHERE instr(r.removed, '/' || a.i || ',' || a.j || '/') = 0 -- not yet removed
    AND (
        CASE WHEN (a.i-1, a.j-1) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i-1) || ',' || (a.j-1) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i-1, a.j) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i-1) || ',' || (a.j) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i-1, a.j+1) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i-1) || ',' || (a.j+1) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i, a.j-1) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i) || ',' || (a.j-1) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i, a.j+1) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i) || ',' || (a.j+1) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i+1, a.j-1) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i+1) || ',' || (a.j-1) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i+1, a.j) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i+1) || ',' || (a.j) || '/') = 0 THEN 1 ELSE 0 END +
        CASE WHEN (a.i+1, a.j+1) IN (SELECT i, j FROM at_positions)
             AND instr(r.removed, '/' || (a.i+1) || ',' || (a.j+1) || '/') = 0 THEN 1 ELSE 0 END
    ) < 4

    -- pick the smallest valid ij from all @s
    AND (a.i*1000 + a.j) = (
        SELECT MIN(a2.i*1000 + a2.j)
        FROM at_positions a2
        WHERE instr(r.removed, '/' || a2.i || ',' || a2.j || '/') = 0
        AND (
            CASE WHEN (a2.i-1, a2.j-1) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i-1) || ',' || (a2.j-1) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i-1, a2.j) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i-1) || ',' || (a2.j) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i-1, a2.j+1) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i-1) || ',' || (a2.j+1) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i, a2.j-1) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i) || ',' || (a2.j-1) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i, a2.j+1) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i) || ',' || (a2.j+1) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i+1, a2.j-1) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i+1) || ',' || (a2.j-1) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i+1, a2.j) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i+1) || ',' || (a2.j) || '/') = 0 THEN 1 ELSE 0 END +
            CASE WHEN (a2.i+1, a2.j+1) IN (SELECT i, j FROM at_positions)
                 AND instr(r.removed, '/' || (a2.i+1) || ',' || (a2.j+1) || '/') = 0 THEN 1 ELSE 0 END
        ) < 4
    )
)

-- count all valid occurrences
SELECT MAX(ct)
FROM recursive_check_neighbours
;