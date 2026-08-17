-- day one

-- parse coordinates
WITH RECURSIVE coords AS (
    SELECT
        id,
        CAST(substr(ln, 1, instr(ln, ',')-1) AS INTEGER) AS x, 
        CAST(substr(substr(ln, instr(ln, ',')+1), 1, instr(substr(ln, instr(ln, ',')+1), ',')-1) AS INTEGER) AS y,
        CAST(substr(ln, instr(ln, ',') + instr(substr(ln, instr(ln, ',')+1), ',')+1) AS INTEGER) AS z
    FROM day08
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

-- filter for the closest 1000 pairs
edges_1d AS (
    SELECT *
    FROM coord_pairs
    ORDER BY dist
    LIMIT 1000
),

-- create undirected edges by including the reverse
edges AS (
    SELECT
        c1id AS edge_start,
        c2id AS edge_end
    FROM edges_1d

    UNION
    
    SELECT
        c2id AS edge_start,
        c1id AS edge_end
    FROM edges_1d
),

-- find nodes that each node can get to
traverse_graph (node, rt) AS (
    SELECT
        edge_start,
        edge_start
    FROM edges

    UNION

    SELECT
        e.edge_end,
        t.rt
    FROM traverse_graph t
    JOIN edges e
    ON t.node = e.edge_start
),

-- uniquely identify each disjoint graph
find_min_root AS (
    SELECT
        node,
        MIN(rt) AS min_root
    FROM traverse_graph
    GROUP BY node
),

-- find the cardinality of the graphs
counts AS (
    SELECT 
        min_root,
        COUNT(*) AS ct
    FROM find_min_root
    GROUP BY min_root
    ORDER BY ct DESC
    LIMIT 3
)

-- multiplication trick from day 6
SELECT ROUND(EXP(SUM(LN(ct))), 0)
FROM counts
;