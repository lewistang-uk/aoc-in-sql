-- part one

-- find all chars and their ijs
WITH RECURSIVE find_chars (i, j, obj, ln) AS (
    SELECT
        id,
        1,
        substr(ln, 1, 1),
        ln
    FROM day7

    UNION ALL

    SELECT
        i,
        j+1,
        substr(ln, j+1, 1),
        ln
    FROM find_chars
    WHERE j < LENGTH(ln)
),

-- find location of arrows
arrows AS (
    SELECT
        i,
        j
    FROM find_chars
    WHERE obj = '^'
),

-- simulate beam
beam (i, j) AS (
    SELECT
        i,
        j
    FROM find_chars
    WHERE obj = 'S'

    UNION 

    -- straight down if no arrow below
    SELECT
        i+1,
        j
    FROM beam
    WHERE (i+1, j) NOT IN (SELECT i, j FROM arrows)
    AND i+1 <= (SELECT MAX(id) FROM day7)

    UNION

    -- otherwise split left and right
    SELECT
        i+1,
        j-1
    FROM beam
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)

    UNION

    SELECT
        i+1,
        j+1
    FROM beam
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
)

-- count all arrows where a split occurred
SELECT COUNT(*)
FROM arrows
WHERE (i-1, j) IN (SELECT i, j FROM beam)
;