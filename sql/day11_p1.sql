-- part one

-- split the lines on :
WITH RECURSIVE colon_split AS (
    SELECT
        id,
        substr(ln, 1, instr(ln, ':')-1) AS edge_start,
        LTRIM(substr(ln, instr(ln, ':')+1)) AS edge_ends
    FROM day11
),

-- split the ends of edges
split_ends (id, edge_end, rest) AS (
    SELECT
        id,
        '',
        edge_ends || ' '
    FROM colon_split

    UNION

    SELECT
        id,
        substr(rest, 1, instr(rest, ' ')-1),
        substr(rest, instr(rest, ' ')+1)
    FROM split_ends
    WHERE rest <> ''
),

-- join edge ends with edge starts on row id
edges AS MATERIALIZED (
    SELECT
        c.edge_start,
        s.edge_end
    FROM split_ends s
    JOIN colon_split c
    ON s.id = c.id
    WHERE edge_end <> ''
),

-- bfs to find all paths
bfs (last_node, next_node, visited) AS (
    SELECT
        '',
        'you',
        '/' || 'you' || '/'
    
    UNION

    SELECT
        b.next_node,
        e.edge_end,
        visited || e.edge_end || '/'
    FROM bfs b
    JOIN edges e
    ON b.next_node = e.edge_start
    WHERE instr(visited, '/' || e.edge_end || '/') = 0
)

-- filter for paths which end with 'out'
SELECT COUNT(*) 
FROM bfs
WHERE next_node = 'out'
;