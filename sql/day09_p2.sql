-- part two

-- parse coordinates
WITH coords AS MATERIALIZED (
    SELECT
        id,
        CAST(substr(ln, 1, instr(ln, ',') - 1) AS INTEGER) AS x,
        CAST(substr(ln, instr(ln, ',') + 1) AS INTEGER) AS y
    FROM day9    
),

edges_with_null AS (
    SELECT
        x,
        y,
        LAG(x) OVER (ORDER BY id) AS prev_x,
        LAG(y) OVER (ORDER BY id) AS prev_y
    FROM coords

    UNION

    -- lag will return null for the first coord
    SELECT
        c1.x,
        c1.y,
        c2.x AS prev_x,
        c2.y AS prev_y
    FROM coords c1
    JOIN coords c2
    ON c1.id = 1
    AND c2.id = (SELECT MAX(id) FROM coords)    
),

-- filter out the one null from lag
edges AS MATERIALIZED (
    SELECT *
    FROM edges_with_null
    WHERE prev_x IS NOT NULL -- also covers prev_y
),

-- find areas for each candidate rectangle
candidates AS (
    SELECT
        MIN(c1.x, c2.x) AS left_side,
        MAX(c1.x, c2.x) AS right_side,
        MIN(c1.y, c2.y) AS bottom_side,
        MAX(c1.y, c2.y) AS top_side,        
        (c2.x - c1.x + 1) * (ABS(c2.y - c1.y) + 1) AS area
    FROM coords c1
    JOIN coords c2
    ON c1.x <= c2.x
)

SELECT
    c.area
FROM candidates c
WHERE NOT EXISTS (
    SELECT 1
    FROM edges e
    WHERE 
        -- check for horizontal edges that pass vertical rectangle sides
        (e.y = e.prev_y AND e.y > c.bottom_side AND e.y < c.top_side AND MIN(e.prev_x, e.x) < c.right_side AND MAX(e.prev_x, e.x) > c.left_side)
    OR 
        -- check for vertical edges that pass horizontal rectangle sides
        (e.x = e.prev_x AND e.x > c.left_side AND e.x < c.right_side AND MIN(e.prev_y, e.y) < c.top_side AND MAX(e.prev_y, e.y) > c.bottom_side)
)
ORDER BY c.area DESC
LIMIT 1