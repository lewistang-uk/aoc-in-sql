-- day one

-- get ranges
WITH parsed_ranges AS (
    SELECT
        CAST(substr(ln, 1, instr(ln, '-')-1) AS INTEGER) AS range_start,
        CAST(substr(ln, instr(ln, '-')+1) AS INTEGER) AS range_end
    FROM day05
    WHERE ln LIKE '%-%'
),

-- get numbers
parsed_numbers AS (
    SELECT CAST(ln AS INTEGER) AS num
    FROM day05
    WHERE ln NOT LIKE '%-%'
    AND ln <> ''
)

-- check if number appears in any range
SELECT COUNT(*)
FROM parsed_numbers
WHERE num IN (
    SELECT n.num
    FROM parsed_numbers n
    CROSS JOIN parsed_ranges r
    ON r.range_start <= n.num
    AND n.num <= r.range_end
);