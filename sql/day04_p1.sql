-- part one

-- find characters and their indices (i, j)
WITH RECURSIVE cte(i, j, ch, ln) AS (
    SELECT 
        id, 
        1, 
        substr(ln, 1, 1),
        ln
    FROM day04

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

-- binary flag if neighbours are '@'
check_neighbours AS (
    SELECT
        i, 
        j,
        CASE WHEN (i-1, j-1) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS TL,
        CASE WHEN (i-1, j) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS TM,
        CASE WHEN (i-1, j+1) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS TR,
        CASE WHEN (i, j-1) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS ML,
        CASE WHEN (i, j+1) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS MR,
        CASE WHEN (i+1, j-1) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS BL,
        CASE WHEN (i+1, j) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS BM,
        CASE WHEN (i+1, j+1) IN (SELECT i, j FROM at_positions) THEN 1 ELSE 0 END AS BR
    FROM at_positions
)

-- count all valid occurrences
SELECT COUNT(*) 
FROM check_neighbours 
WHERE TL + TM + TR + ML + MR + BL + BM + BR < 4
;