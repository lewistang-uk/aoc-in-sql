-- part one

-- remove leading spaces and normalise spacing for ease
WITH RECURSIVE cleaned AS (
    SELECT
        id,
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        RTRIM(LTRIM(ln)),
                        '     ', -- five spaces
                        ' '
                    ),
                    '    ', -- four spaces
                    ' '
                ),
                '   ', -- three spaces
                ' '
            ),
            '  ', -- two spaces
            ' '
        ) AS ln
    FROM day06
),

-- find all the numbers and their ijs
numbers (i, j, indx, num, ln) AS (
    SELECT
        id,
        1,
        instr(ln, ' ') + 1,
        substr(ln, 1, instr(ln, ' ') - 1),
        ln || ' '
    FROM cleaned
    WHERE ln NOT LIKE '%*%'
    AND ln NOT LIKE '%+%'

    UNION ALL

    SELECT
        i,
        j + 1,
        indx + instr(substr(ln, indx), ' '),
        substr(ln, indx, instr(substr(ln, indx), ' ') - 1),
        ln
    FROM numbers
    WHERE indx <= LENGTH(ln)
),

-- find the operations and the column it matches
operations (j, indx, op, ln) AS (
    SELECT
        1,
        instr(ln, ' ') + 1,
        substr(ln, 1, instr(ln, ' ') - 1),
        ln || ' '
    FROM cleaned
    WHERE id = (SELECT MAX(id) FROM cleaned) -- last row

    UNION ALL

    SELECT
        j + 1,
        indx + instr(substr(ln, indx), ' '),
        substr(ln, indx, instr(substr(ln, indx), ' ') - 1),
        ln
    FROM operations
    WHERE indx <= LENGTH(ln)    
),

-- find the sum and product of each column
aggregated AS (
    SELECT
        j,
        SUM(CAST(num AS INTEGER)) AS plus,
        ROUND(EXP(SUM(LN(CAST(num AS INTEGER)))), 0) AS star -- multiplication is addition in log space
    FROM numbers
    GROUP BY j
)

-- add either the sum or product depending on sign
SELECT
    SUM(
        CASE WHEN j IN (SELECT j FROM operations WHERE op = '*') THEN star
        WHEN j IN (SELECT j FROM operations WHERE op = '+') THEN plus
        ELSE 0 END
    ) AS result
FROM aggregated
;