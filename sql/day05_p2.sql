-- day two

-- find ranges
WITH parsed_ranges AS (
    SELECT
        CAST(substr(ln, 1, instr(ln, '-')-1) AS INTEGER) AS range_start,
        CAST(substr(ln, instr(ln, '-')+1) AS INTEGER) AS range_end
    FROM day05
    WHERE ln LIKE '%-%'
),

-- implement Klee's algorithm

-- define start and stop events
events AS (
    SELECT
        range_start AS ts,
        1 AS flag
    FROM parsed_ranges

    UNION ALL

    SELECT
        range_end + 1 AS ts, -- integer problem so a range [a, b] converted to [a, b+1)
        -1 AS flag
    FROM parsed_ranges
),

-- find the sum of flags
cumsum AS (
    SELECT
        ts,
        LEAD(ts) OVER (ORDER BY ts, flag) AS lead_ts,
        SUM(flag) OVER (ORDER BY ts, flag) AS active
        FROM events
)

-- sum the differences between events when valid
SELECT SUM(lead_ts - ts) 
FROM cumsum
WHERE active > 0
;