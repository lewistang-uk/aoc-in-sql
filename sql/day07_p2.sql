-- part two

-- find all chars and their ijs
WITH RECURSIVE find_chars (i, j, obj, ln) AS (
    SELECT
        id,
        1,
        substr(ln, 1, 1),
        ln
    FROM day07

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

-- simulate the first quarter of paths
beam_1 (i, j) AS (
    SELECT
        i,
        j
    FROM find_chars
    WHERE obj = 'S'

    UNION ALL

    -- straight down if no arrow below
    SELECT
        i+1,
        j
    FROM beam_1
    WHERE (i+1, j) NOT IN (SELECT i, j FROM arrows)
    AND i+1 <= 38

    UNION ALL

    -- otherwise split left and right
    SELECT
        i+1,
        j-1
    FROM beam_1
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= 38

    UNION ALL

    SELECT
        i+1,
        j+1
    FROM beam_1
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= 38
),

-- aggregate
first_total AS (
    SELECT 
        i, 
        j, 
        COUNT(*) AS ct
    FROM beam_1
    WHERE i = 38
    GROUP BY i, j
),

-- simulate the next quarter of beams, noting its parent beam
beam_2 (i, j, start_j) AS (
    SELECT
        i,
        j,
        j
    FROM first_total

    UNION ALL

    -- straight down if no arrow below
    SELECT
        i+1,
        j,
        start_j
    FROM beam_2
    WHERE (i+1, j) NOT IN (SELECT i, j FROM arrows)
    AND i+1 <= 74

    UNION ALL

    -- otherwise split left and right
    SELECT
        i+1,
        j-1,
        start_j
    FROM beam_2
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= 74

    UNION ALL

    SELECT
        i+1,
        j+1,
        start_j
    FROM beam_2
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= 74
),

-- aggregate
second_total AS (
    SELECT
        i,
        j,
        SUM((SELECT ft.ct FROM first_total ft WHERE ft.j = beam_2.start_j)) AS ct
    FROM beam_2
    WHERE i = 74
    GROUP BY i, j
),

-- simulate the next quarter of beams, noting its parent beam
beam_3 (i, j, start_j) AS (
    SELECT
        i,
        j,
        j
    FROM second_total

    UNION ALL

    -- straight down if no arrow below
    SELECT
        i+1,
        j,
        start_j
    FROM beam_3
    WHERE (i+1, j) NOT IN (SELECT i, j FROM arrows)
    AND i+1 <= 112

    UNION ALL

    -- otherwise split left and right
    SELECT
        i+1,
        j-1,
        start_j
    FROM beam_3
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= 112

    UNION ALL

    SELECT
        i+1,
        j+1,
        start_j
    FROM beam_3
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= 112
),

-- aggregate
third_total AS (
    SELECT
        i,
        j,
        SUM((SELECT st.ct FROM second_total st WHERE st.j = beam_3.start_j)) AS ct
    FROM beam_3
    WHERE i = 112
    GROUP BY i, j
),

-- simulate the last quarter of beams, noting its parent beam
beam_4 (i, j, start_j) AS (
    SELECT
        i,
        j,
        j
    FROM third_total

    UNION ALL

    -- straight down if no arrow below
    SELECT
        i+1,
        j,
        start_j
    FROM beam_4
    WHERE (i+1, j) NOT IN (SELECT i, j FROM arrows)
    AND i+1 <= (SELECT MAX(id) FROM day07)

    UNION ALL

    -- otherwise split left and right
    SELECT
        i+1,
        j-1,
        start_j
    FROM beam_4
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= (SELECT MAX(id) FROM day07)

    UNION ALL

    SELECT
        i+1,
        j+1,
        start_j
    FROM beam_4
    WHERE (i+1, j) IN (SELECT i, j FROM arrows)
    AND i+1 <= (SELECT MAX(id) FROM day07)
),

-- aggregate
last_total AS (
    SELECT
        i,
        j,
        SUM((SELECT tt.ct FROM third_total tt WHERE tt.j = beam_4.start_j)) AS ct
    FROM beam_4
    WHERE i = (SELECT MAX(id) FROM day07)
    GROUP BY i, j
)

-- count how many paths at the end
SELECT SUM(ct)
FROM last_total
;