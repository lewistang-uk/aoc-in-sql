-- part two

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

-- hard-code cases for all length possibilities up to 10 (limit)
cases AS (
    SELECT 11*0.5*(end_num/11)*(end_num/11 + 1) AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 1
    AND end_num_length = 2

    UNION ALL

    SELECT 11*0.5*(end_num/11)*(end_num/11 + 1) - 11*0.5*((start_num - 1)/11)*((start_num - 1)/11 + 1) AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 2
    AND end_num_length = 2

    UNION ALL

    SELECT 111*0.5*(end_num/111)*(end_num/111 + 1) -- 100 to end_num
        + 11*9*5 - 11*0.5*((start_num - 1)/11)*((start_num - 1)/11 + 1) -- start_num to 100
        AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 2
    AND end_num_length = 3

    UNION ALL

    SELECT 111*0.5*(end_num/111)*(end_num/111 + 1) - 111*0.5*((start_num - 1)/111)*((start_num - 1)/111 + 1) AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 3
    AND end_num_length = 3

    UNION ALL

    SELECT 101*0.5*(end_num/101)*(end_num/101 + 1) - 101*9*5 -- 1000 to end_num
        + 111*9*5 - 111*0.5*((start_num - 1)/111)*((start_num - 1)/111 + 1) -- start_num to 1000
        AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 3
    AND end_num_length = 4  

    UNION ALL

    SELECT 101*0.5*(end_num/101)*(end_num/101 + 1) 
        - 101*0.5*((start_num-1)/101)*((start_num-1)/101 + 1)
        AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 4
    AND end_num_length = 4

    UNION ALL

    SELECT 11111*0.5*(end_num/11111)*(end_num/11111 + 1)
        + 101*99*50 - 101*0.5*((start_num-1)/101)*((start_num-1)/101 + 1)
        AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 4
    AND end_num_length = 5

    UNION ALL

    SELECT 11111*0.5*(end_num/11111)*(end_num/11111 + 1) - 11111*0.5*((start_num - 1)/11111)*((start_num - 1)/11111 + 1) AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 5
    AND end_num_length = 5 

    UNION ALL

    SELECT
        10101*0.5*(end_num/10101)*(end_num/10101 + 1) + 1001*0.5*(end_num/1001)*(end_num/1001 + 1) - 111111*0.5*(end_num/111111)*(end_num/111111 + 1)
        - (10101*9*5 + 1001*99*50) -- 100000 to end_num
        + 11111*9*5 - 11111*0.5*((start_num-1)/11111)*((start_num-1)/11111 + 1) --- start_num to 100000
        AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 5
    AND end_num_length = 6

    UNION ALL

    SELECT
        10101*0.5*(end_num/10101)*(end_num/10101 + 1) + 1001*0.5*(end_num/1001)*(end_num/1001 + 1) - 111111*0.5*(end_num/111111)*(end_num/111111 + 1)
        - (10101*0.5*((start_num-1)/10101)*((start_num-1)/10101 + 1) + 1001*0.5*((start_num-1)/1001)*((start_num-1)/1001 + 1) - 111111*0.5*((start_num-1)/111111)*((start_num-1)/111111 + 1))
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 6
    AND end_num_length = 6

    UNION ALL

    SELECT
        1111111*0.5*(end_num/1111111)*(end_num/1111111 + 1)
        + 10101*99*50 + 1001*999*500 - 111111*9*5 -- inc-exc
        - (10101*0.5*((start_num-1)/10101)*((start_num-1)/10101 + 1) + 1001*0.5*((start_num-1)/1001)*((start_num-1)/1001 + 1) - 111111*0.5*((start_num-1)/111111)*((start_num-1)/111111 + 1))
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 6
    AND end_num_length = 7    

    UNION ALL

    SELECT
        1111111*0.5*(end_num/1111111)*(end_num/1111111 + 1) - 1111111*0.5*((start_num-1)/1111111)*((start_num-1)/1111111 + 1)
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 7
    AND end_num_length = 7    

    UNION ALL

    SELECT
        10001*0.5*(end_num/10001)*(end_num/10001 + 1) - 10001*999*500
        + 1111111*9*5 - 1111111*0.5*((start_num-1)/1111111)*((start_num-1)/1111111 + 1)
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 7
    AND end_num_length = 8

    UNION ALL

    SELECT
        10001*0.5*(end_num/10001)*(end_num/10001 + 1)
        - 10001*0.5*((start_num-1)/10001)*((start_num-1)/10001 + 1)
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 8
    AND end_num_length = 8

    UNION ALL

    SELECT
        1001001*0.5*(end_num/1001001)*(end_num/1001001 + 1) - 1001001*99*50
        + 10001*999*500 - 10001*0.5*((start_num-1)/10001)*((start_num-1)/10001 + 1)
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 8
    AND end_num_length = 9

    UNION ALL

    SELECT
        1001001*0.5*(end_num/1001001)*(end_num/1001001 + 1)
        - 1001001*0.5*((start_num-1)/1001001)*((start_num-1)/1001001 + 1)
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 9
    AND end_num_length = 9

    UNION ALL

    SELECT
        100001*0.5*(end_num/100001)*(end_num/100001 + 1) + 101010101*0.5*(end_num/101010101)*(end_num/101010101 + 1) - 1111111111*0.5*(end_num/1111111111)*(end_num/1111111111 + 1)
        - 100001*9999*5000 - 101010101*9*5
        + 1001001*99*50 - 1001001*0.5*((start_num-1)/1001001)*((start_num-1)/1001001 + 1)
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 9
    AND end_num_length = 10    

    UNION ALL

    SELECT
        100001*0.5*(end_num/100001)*(end_num/100001 + 1) + 101010101*0.5*(end_num/101010101)*(end_num/101010101 + 1) - 1111111111*0.5*(end_num/1111111111)*(end_num/1111111111 + 1)
        - (100001*0.5*((start_num-1)/100001)*((start_num-1)/100001 + 1) + 101010101*0.5*((start_num-1)/101010101)*((start_num-1)/101010101 + 1) - 1111111111*0.5*((start_num-1)/1111111111)*((start_num-1)/1111111111 + 1))
    AS invalid_num_sum
    FROM start_end_table
    WHERE start_num_length = 10
    AND end_num_length = 10    
)
SELECT SUM(invalid_num_sum)
FROM cases
;