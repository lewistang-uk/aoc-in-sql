-- part two

-- parse coordinates
WITH RECURSIVE coords AS (
    SELECT
        id,
        CAST(substr(ln, 1, instr(ln, ',')-1) AS INTEGER) AS x, 
        CAST(substr(substr(ln, instr(ln, ',')+1), 1, instr(substr(ln, instr(ln, ',')+1), ',')-1) AS INTEGER) AS y,
        CAST(substr(ln, instr(ln, ',') + instr(substr(ln, instr(ln, ',')+1), ',')+1) AS INTEGER) AS z
    FROM day8
),

-- find pairs
coord_pairs AS (
    SELECT
        c1.id AS c1id,
        c2.id AS c2id,
        (c1.x - c2.x) * (c1.x - c2.x) + (c1.y - c2.y) * (c1.y - c2.y) + (c1.z - c2.z) * (c1.z - c2.z) AS dist
    FROM coords c1
    CROSS JOIN coords c2
    ON c1.x <> c2.x 
    OR c1.y <> c2.y
    OR c1.z <> c2.z
    WHERE c1.id < c2.id
),

-- find ordered edges, direction irrelevant
edges AS (
    SELECT
        c1id,
        c2id,
        ROW_NUMBER() OVER (ORDER BY dist) AS id
    FROM coord_pairs
),

-- give each coordinate a distinct initial group number 000-999
group_nos (k) AS (
    SELECT '000'
    
    UNION

    SELECT printf('%03d', CAST(k AS INTEGER)+1)
    FROM group_nos
    WHERE CAST(k AS INTEGER) < (SELECT MAX(id) FROM day8)-1 -- day8 is 1-indexed, this is 0-indexed
),


-- Kruskal's algorithm, taking the minimum group number as the new id when merging
iterate (groups, distinct_groups, ln) AS (
    SELECT
        GROUP_CONCAT('<' || g.k || '>' , ''),
        (SELECT MAX(id) FROM day8) - 1,
        1
    FROM group_nos g

    UNION ALL

    SELECT
        CASE WHEN substr(i.groups, 5*e.c1id - 3, 3) <> substr(i.groups, 5*e.c2id - 3, 3) 
        THEN REPLACE(
                REPLACE(
                    groups, 
                    '<' || substr(i.groups, 5*e.c1id - 3, 3) || '>', 
                    '<' || printf('%03d', MIN(CAST(substr(i.groups, 5*e.c1id - 3, 3) AS INTEGER), CAST(substr(i.groups, 5*e.c2id - 3, 3) AS INTEGER))) || '>'
                ), 
                '<' || substr(i.groups, 5*e.c2id - 3, 3) || '>', 
                '<' || printf('%03d', MIN(CAST(substr(i.groups, 5*e.c1id - 3, 3) AS INTEGER), CAST(substr(i.groups, 5*e.c2id - 3, 3) AS INTEGER))) || '>'
                )
        ELSE groups END,

        CASE WHEN substr(i.groups, 5*e.c1id - 3, 3) <> substr(i.groups, 5*e.c2id - 3, 3) THEN distinct_groups-1 ELSE distinct_groups END,

        ln + 1
    FROM edges e
    JOIN iterate i
    WHERE e.id = i.ln
    AND distinct_groups > 0
),

-- use joins to find the x-values corresponding to the last iteration
x_values AS (
    SELECT c.x
    FROM edges e
    JOIN coords c
    ON c.id = e.c1id OR c.id = e.c2id
    WHERE e.id = (SELECT MAX(ln) FROM iterate) - 1
)

-- multiplication trick to find answer
SELECT ROUND(EXP(SUM(LN(x))), 0)
FROM x_values
;