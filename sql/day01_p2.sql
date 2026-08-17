-- part two
WITH rotations AS (
    SELECT
        id,
        CASE 
            WHEN substr(ln, 1, 1) = 'L' THEN -1 * CAST(substr(ln, 2) AS INT)
            ELSE CAST(substr(ln, 2) AS INT)
        END AS rotation
    FROM day01
),

adj_start AS (
    SELECT
        id,
        CASE WHEN id = 1 THEN rotation + 50 ELSE rotation END AS rotation
    FROM rotations
),

cumsum AS (
    SELECT
        id,
        rotation,
        SUM(rotation) OVER (ORDER BY id) AS dial_position
    FROM adj_start
),

lagged AS (
    SELECT
        id,
        rotation,
        dial_position,
        LAG(dial_position) OVER (ORDER BY id) AS prev_dial_position
    FROM cumsum
)

SELECT
    SUM(
        CASE
            WHEN rotation > 0 
            THEN FLOOR(dial_position / 100.0) - FLOOR(prev_dial_position / 100.0)
            ELSE CEILING(prev_dial_position / 100.0) - CEILING(dial_position / 100.0)
        END
    ) AS result
FROM lagged;