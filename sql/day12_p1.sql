-- part one

-- gaps and islands parsing approach since blank-line separated
WITH RECURSIVE grouped AS (
    SELECT
        id,
        ln,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM day12
    WHERE ln <> ''
),

-- find shapes and how much space they occupy
shapes AS (
    SELECT
        grp,
        GROUP_CONCAT(ln, '') AS flat_present
    FROM grouped
    WHERE ln NOT LIKE '%:%'
    GROUP BY grp
),

pres_space AS (
    SELECT
        grp,
        LENGTH(REPLACE(flat_present, '.', '')) AS pres_size
    FROM shapes
),

-- parse regions
split AS (
    SELECT
        id,
        substr(ln, 1, instr(ln, ':')-1) AS bounds,
        LTRIM(substr(ln, instr(ln, ':')+1)) AS val_counts
    FROM grouped
    WHERE grp = (SELECT MAX(grp) FROM grouped)
),

regions AS (
    SELECT
        id,
        CAST(substr(bounds, 1, instr(bounds, 'x')-1) AS INTEGER)
        *
        CAST(substr(bounds, instr(bounds, 'x')+1) AS INTEGER) 
        AS area
    FROM split
),

-- parse required present counts
counts_split (ln_id, shape_id, val, rest) AS (
    SELECT
        id,
        -1, -- the shapes should be 0-indexed, so base case -1
        '',
        val_counts || ' '
    FROM split

    UNION 

    SELECT
        ln_id,
        shape_id + 1,
        substr(rest, 1, instr(rest, ' ')-1),
        substr(rest, instr(rest, ' ')+1)
    FROM counts_split
    WHERE rest <> ''
),

counts AS (
    SELECT
        c.ln_id,
        CAST(c.val AS INTEGER) * p.pres_size AS space_taken
    FROM counts_split c
    JOIN pres_space p
    ON c.shape_id = p.grp
    WHERE c.shape_id <> -1
),

-- find the number of valid rows
num_valid AS (
    SELECT 1
    FROM counts c
    JOIN regions r
    ON c.ln_id = r.id
    GROUP BY r.id
    HAVING SUM(c.space_taken) <= r.area
)

SELECT COUNT(*) 
FROM num_valid
;