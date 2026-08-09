-- part one

WITH fst AS (
    SELECT
        ln, 
        CASE WHEN instr(substr(ln, 1, LENGTH(ln)-1), "9") > 0 THEN "9"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "8") > 0 THEN "8"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "7") > 0 THEN "7"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "6") > 0 THEN "6"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "5") > 0 THEN "5"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "4") > 0 THEN "4"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "3") > 0 THEN "3"
        WHEN instr(substr(ln, 1, LENGTH(ln)-1), "2") > 0 THEN "2"
        ELSE "1" END AS first_digit
    FROM day3
),

indx AS (
    SELECT ln, first_digit, instr(ln, first_digit) + 1 AS search_start FROM fst
),

lst AS (
    SELECT
        first_digit, 
        CASE WHEN instr(substr(ln, search_start), "9") > 0 THEN "9"
        WHEN instr(substr(ln, search_start), "8") > 0 THEN "8"
        WHEN instr(substr(ln, search_start), "7") > 0 THEN "7"
        WHEN instr(substr(ln, search_start), "6") > 0 THEN "6"
        WHEN instr(substr(ln, search_start), "5") > 0 THEN "5"
        WHEN instr(substr(ln, search_start), "4") > 0 THEN "4"
        WHEN instr(substr(ln, search_start), "3") > 0 THEN "3"
        WHEN instr(substr(ln, search_start), "2") > 0 THEN "2"
        ELSE "1" END AS last_digit
    FROM indx
)

SELECT
    SUM(CAST(first_digit || last_digit AS INTEGER))
FROM lst
;