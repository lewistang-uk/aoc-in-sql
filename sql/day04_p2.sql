-- part two

-- make it easier to find the line length
WITH RECURSIVE lengths AS (
    SELECT LENGTH(ln) AS line_length
    FROM day04
    WHERE id = 1 -- all lines same length
),

-- pad the grid once with blanks
padded_lines (ln, id) AS (
    SELECT 
        REPLACE(printf('%' || (line_length + 2) || 's', ''), ' ', '.'), 
        0
    FROM lengths
    
    UNION ALL

    SELECT 
        '.' || ln || '.',
        id
    FROM day04

    UNION ALL

    SELECT 
        REPLACE(printf('%' || (line_length + 2) || 's', ''), ' ', '.'), 
        line_length + 1
    FROM lengths

    ORDER BY id 
),

-- flatten grid into line for rCTE
str_input AS (
    SELECT 
        GROUP_CONCAT(ln, '') AS str,
        LENGTH(GROUP_CONCAT(ln, '')) AS len_str
    FROM padded_lines
),

-- initialise a queue with every index checked
generate_queue (k) AS (
    SELECT 1
    FROM lengths

    UNION ALL

    SELECT g.k+1
    FROM generate_queue g, str_input s
    WHERE k < s.len_str
),

-- flatten queue into a comma-separated string for rCTE
pivoted_queue AS (
    SELECT GROUP_CONCAT(k) AS q
    FROM generate_queue
),

-- iterate through the queue to check for removable @s
iter (j, q, ln, removed) AS (
    SELECT
        0,
        p.q || ',' ,
        s.str,
        0
    FROM str_input s, pivoted_queue p

    UNION ALL

    SELECT
        CAST(substr(i.q, 1, instr(i.q, ',') - 1) AS INTEGER),

        CASE WHEN substr(i.ln, i.j, 1) = '@' 
        AND LENGTH(
                REPLACE(
                    substr(i.ln, i.j - (l.line_length+2) - 1, 3) ||
                    substr(i.ln, i.j - 1, 3) ||
                    substr(i.ln, i.j + (l.line_length+2) - 1, 3) 
                , '.', ''
            )) < 5
        -- if an @ is removed, the surrounding eight indices may become removable, so add to queue
        THEN substr(i.q, instr(i.q, ',') + 1) || ',' ||
            (i.j - (l.line_length+2) - 1) || ',' ||
            (i.j - (l.line_length+2)) || ',' ||
            (i.j - (l.line_length+2) + 1) || ',' ||
            (i.j - 1) || ',' ||
            (i.j + 1) || ',' ||
            (i.j + (l.line_length+2) - 1) || ',' ||
            (i.j + (l.line_length+2)) || ',' ||
            (i.j + (l.line_length+2) + 1) || ',' 
        ELSE substr(i.q, instr(i.q, ',') + 1) END,

        CASE WHEN substr(i.ln, i.j, 1) = '@' 
        AND LENGTH(
                REPLACE(
                    substr(i.ln, i.j - (l.line_length+2) - 1, 3) ||
                    substr(i.ln, i.j - 1, 3) ||
                    substr(i.ln, i.j + (l.line_length+2) - 1, 3) 
                , '.', ''
            )) < 5
        THEN substr(i.ln, 1, j-1) || '.' || substr(i.ln, j+1) ELSE i.ln END,

        CASE WHEN substr(i.ln, i.j, 1) = '@' 
        AND LENGTH(
                REPLACE(
                    substr(i.ln, i.j - (l.line_length+2) - 1, 3) ||
                    substr(i.ln, i.j - 1, 3) ||
                    substr(i.ln, i.j + (l.line_length+2) - 1, 3)
                , '.', ''
            )) < 5
        THEN i.removed + 1 ELSE i.removed END

    FROM lengths l, iter i
    WHERE i.q <> '' -- stop on empty queue
)

SELECT MAX(removed)
FROM iter
;