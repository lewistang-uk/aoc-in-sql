-- part one

-- parse the lines
WITH RECURSIVE space_split (val, rest, ln_id, j) AS (
    SELECT 
        '',
        ln || ' ',
        id,
        0
    FROM day10

    UNION ALL

    SELECT
        substr(rest, 1, instr(rest, ' ')-1),
        substr(rest, instr(rest, ' ')+1),
        ln_id, 
        j+1
    FROM space_split
    WHERE rest <> ''
),

-- find the lights
lights (ln_id, light) AS (
    SELECT 
        ln_id,
        substr(val, 2, LENGTH(val)-2)
    FROM space_split
    WHERE j = 1 -- only the first item
),

find_light_vals (ln_id, light, num, j) AS (
    SELECT
        ln_id,
        light,
        0, 
        0
    FROM lights

    UNION ALL

    SELECT
        ln_id,
        light, 
        CASE WHEN substr(light, LENGTH(light)-j, 1) = '#' THEN num + POWER(2, j)
        ELSE num END,
        j+1
    FROM find_light_vals
    WHERE j < LENGTH(light)
),

-- find the base-10 integer representation of the binary lights
light_vals (ln_id, val) AS (
    SELECT DISTINCT
        ln_id,
        CAST(MAX(num) AS INTEGER) -- can only add to number, so max gives the final total
    FROM find_light_vals
    GROUP BY ln_id
),

-- find the buttons
buttons (ln_id, button, button_id) AS (
    SELECT 
        ln_id,
        substr(val, 2, LENGTH(val)-2), 
        j
    FROM space_split
    WHERE j > 1 -- ignore light config
    AND rest <> '' -- ignore the item in curly brackets
),

find_button_vals (ln_id, button, button_id, num, j) AS (
    SELECT
        ln_id,
        REPLACE(button, ',', ''), -- max 10 buttons numbered 0-9 so this works
        button_id,
        0,
        0
    FROM buttons

    UNION ALL

    SELECT 
        b.ln_id,
        b.button,
        b.button_id,
        CASE WHEN instr(b.button, CAST((LENGTH(l.light)-1-b.j) AS TEXT)) <> 0 THEN b.num + POWER(2, b.j)
        ELSE b.num END,        
        b.j+1
    FROM find_button_vals b
    JOIN lights l
    ON b.ln_id = l.ln_id
    WHERE b.j < LENGTH(l.light) -- buttons are 0-indexed
),

-- find the base-10 representation of the binary buttons
button_vals (ln_id, button_id, val) AS (
    SELECT DISTINCT
        ln_id,
        button_id,
        CAST(MAX(num) AS INTEGER) -- can only add to number, so max gives the final total
    FROM find_button_vals
    GROUP BY ln_id, button_id
),

-- xor over all button combinations since two presses is the same as no press
find_xor (ln_id, button_id, num_buttons, val) AS (
    SELECT DISTINCT
        ln_id,
        1,
        0, 
        0
    FROM button_vals
    
    UNION ALL

    -- case where we select the next button
    SELECT
        x.ln_id,
        x.button_id + 1,
        x.num_buttons + 1,
        (x.val | b.val) - (x.val & b.val)
    FROM find_xor x
    JOIN button_vals b
    ON x.ln_id = b.ln_id 
    AND x.button_id + 1 = b.button_id -- when no valid buttons left to choose, this will terminate by itself

    UNION ALL 

    -- case where we don't select the next button
    SELECT
        x.ln_id,
        x.button_id + 1,
        x.num_buttons,
        x.val
    FROM find_xor x
    WHERE x.button_id < (SELECT MAX(b.button_id) FROM button_vals b WHERE b.ln_id = x.ln_id GROUP BY b.ln_id)
),

-- find the least number of buttons per line that matches the lights (the buttons that turn the lights on are the buttons that turn them off)
minima (mn) AS (
    SELECT MIN(x.num_buttons)
    FROM find_xor x
    JOIN light_vals l
    ON l.ln_id = x.ln_id
    AND l.val = x.val
    GROUP BY x.ln_id
)

-- sum these for the answer
SELECT SUM(mn)
FROM minima
;