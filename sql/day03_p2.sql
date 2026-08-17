-- part two

WITH RECURSIVE cte AS (
    SELECT
        ln,
        11 AS remaining,
        CASE WHEN instr(substr(ln, 1, length(ln) - 11), '9') > 0 THEN '9'
            WHEN instr(substr(ln, 1, length(ln) - 11), '8') > 0 THEN '8'
            WHEN instr(substr(ln, 1, length(ln) - 11), '7') > 0 THEN '7'
            WHEN instr(substr(ln, 1, length(ln) - 11), '6') > 0 THEN '6'
            WHEN instr(substr(ln, 1, length(ln) - 11), '5') > 0 THEN '5'
            WHEN instr(substr(ln, 1, length(ln) - 11), '4') > 0 THEN '4'
            WHEN instr(substr(ln, 1, length(ln) - 11), '3') > 0 THEN '3'
            WHEN instr(substr(ln, 1, length(ln) - 11), '2') > 0 THEN '2'
            ELSE '1'
        END AS digit,
        CASE WHEN instr(substr(ln, 1, length(ln) - 11), '9') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '9')
            WHEN instr(substr(ln, 1, length(ln) - 11), '8') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '8')
            WHEN instr(substr(ln, 1, length(ln) - 11), '7') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '7')
            WHEN instr(substr(ln, 1, length(ln) - 11), '6') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '6')
            WHEN instr(substr(ln, 1, length(ln) - 11), '5') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '5')
            WHEN instr(substr(ln, 1, length(ln) - 11), '4') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '4')
            WHEN instr(substr(ln, 1, length(ln) - 11), '3') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '3')
            WHEN instr(substr(ln, 1, length(ln) - 11), '2') > 0 THEN instr(substr(ln, 1, length(ln) - 11), '2')
            ELSE instr(substr(ln, 1, length(ln) - 11), '1')
        END AS pos,
        CASE WHEN instr(substr(ln, 1, length(ln) - 11), '9') > 0 THEN '9'
            WHEN instr(substr(ln, 1, length(ln) - 11), '8') > 0 THEN '8'
            WHEN instr(substr(ln, 1, length(ln) - 11), '7') > 0 THEN '7'
            WHEN instr(substr(ln, 1, length(ln) - 11), '6') > 0 THEN '6'
            WHEN instr(substr(ln, 1, length(ln) - 11), '5') > 0 THEN '5'
            WHEN instr(substr(ln, 1, length(ln) - 11), '4') > 0 THEN '4'
            WHEN instr(substr(ln, 1, length(ln) - 11), '3') > 0 THEN '3'
            WHEN instr(substr(ln, 1, length(ln) - 11), '2') > 0 THEN '2'
            ELSE '1' 
        END AS n

    FROM day03

    UNION ALL

    SELECT
        ln,
        remaining - 1,
        CASE WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '9') > 0 THEN '9'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '8') > 0 THEN '8'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '7') > 0 THEN '7'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '6') > 0 THEN '6'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '5') > 0 THEN '5'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '4') > 0 THEN '4'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '3') > 0 THEN '3'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '2') > 0 THEN '2'
            ELSE '1' 
        END,
        -- required index is current index + index from substring
        pos + (
            CASE WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '9') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '9')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '8') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '8')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '7') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '7')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '6') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '6')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '5') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '5')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '4') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '4')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '3') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '3')
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '2') > 0
                THEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '2')
            ELSE instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '1')
        END),

        -- create current number by adding current digit to existing number
        n ||
        CASE WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '9') > 0 THEN '9'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '8') > 0 THEN '8'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '7') > 0 THEN '7'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '6') > 0 THEN '6'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '5') > 0 THEN '5'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '4') > 0 THEN '4'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '3') > 0 THEN '3'
            WHEN instr(substr(ln, pos + 1, length(ln) - pos - remaining + 1), '2') > 0 THEN '2'
            ELSE '1'
        END

    FROM cte
    WHERE remaining > 0
)

SELECT
    SUM(CAST(n AS INTEGER))
FROM cte
WHERE remaining = 0
;