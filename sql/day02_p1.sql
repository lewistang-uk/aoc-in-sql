-- part one

-- parse comma separated string into individual entries
WITH RECURSIVE split(val, rest) AS (
    SELECT
        '',
        ln || ','
    FROM day2
    UNION ALL
    SELECT
        substr(rest, 1, instr(rest, ',') - 1),
        substr(rest, instr(rest, ',') + 1)
    FROM split
    WHERE rest != ''
),

value_table AS (
    SELECT val AS ln
    FROM split
    WHERE val != ''
),

-- get start and end
start_end_table AS (
    SELECT
        CAST(substr(ln, 1, instr(ln, '-') - 1) AS INTEGER) AS start_num,
        CAST(substr(ln, instr(ln, '-') + 1) AS INTEGER) AS end_num,
        LENGTH(substr(ln, 1, instr(ln, '-') - 1)) AS start_num_length,
        LENGTH(substr(ln, instr(ln, '-') + 1)) AS end_num_length
    FROM value_table
),

-- find the number of zeros in  10...01 for each row
zero_counts AS (
    SELECT
        *,
        CASE WHEN start_num_length % 2 = 0 THEN start_num_length/2 - 1
            WHEN end_num_length = 1 THEN 0
            ELSE end_num_length/2 - 1 END AS zeroes
    FROM start_end_table
),

-- find the number k:= 10...01
ks AS (
    SELECT
        *,
        CAST('1' || substr('000000000000000000000', 1, zeroes) || '1' AS INTEGER) AS k
    FROM zero_counts
)

-- final sum, assuming the lengths can differ by a maximum of one
SELECT
    SUM(
        CASE WHEN start_num_length % 2 = 1 AND end_num_length % 2 = 1 THEN 0
            WHEN start_num_length % 2 = 1 AND end_num_length % 2 = 0 THEN 
                k*0.5*((end_num/k)*(end_num/k + 1)) 
                - k*0.5*(CAST(POWER(10, start_num_length) AS INTEGER)/k) * ((CAST(POWER(10, start_num_length) AS INTEGER))/k + 1)
            WHEN start_num_length % 2 = 0 AND end_num_length % 2 = 1 THEN 
                k*0.5*(CAST(POWER(10, start_num_length) AS INTEGER)/k) * ((CAST(POWER(10, start_num_length) AS INTEGER))/k + 1)
                - k*0.5*((start_num-1)/k)*((start_num-1)/k + 1)
            ELSE k*0.5*((end_num/k)*(end_num/k + 1)) - k*0.5*(((start_num-1)/k)*((start_num-1)/k + 1))
        END
    ) AS result
FROM ks
;