-- part one

-- parse coordinates
WITH coords AS (
    SELECT
        CAST(substr(ln, 1, instr(ln, ',') - 1) AS INTEGER) AS x,
        CAST(substr(ln, instr(ln, ',') + 1) AS INTEGER) AS y
    FROM day9    
),

-- find areas for each rectangle
areas AS (
    SELECT
        (c2.x - c1.x + 1) * (ABS(c2.y - c1.y) + 1) AS area
    FROM coords c1
    JOIN coords c2
    ON c1.x <= c2.x
)

SELECT MAX(area)
FROM areas;