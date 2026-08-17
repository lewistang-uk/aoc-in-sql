-- part one
WITH rotations AS (
    SELECT
        id,
        CASE 
            WHEN substr(ln, 1, 1) = "L" THEN -1*CAST(substr(ln, 2) AS INT)
            ELSE CAST(substr(ln, 2) AS INT)
        END AS rotation
    FROM day01
    ORDER BY id
),
cumsum AS (
    SELECT
        id,
        rotation,
        SUM(rotation) OVER (ORDER BY id) AS dial_position
    FROM rotations
)
SELECT
    COUNT(*) AS result
FROM cumsum
WHERE ABS(dial_position + 50) % 100 = 0;