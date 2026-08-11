## 📆 Day 2

**[❓ Problem](https://adventofcode.com/2025/day/2)**

**[1️⃣ Part 1 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day02_p1.sql)**

**[2️⃣ Part 2 Solution](https://github.com/lewistang-uk/aoc-in-sql/blob/main/sql/day02_p2.sql)**

## ⛏️ Techniques Used

`Mathematics` `Recursive CTEs`

## ✂️ Parsing

A recursive CTE was used to split the string on each comma. The first and last number in each range was isolated using substring methods and string indexing.

## 1️⃣ Part 1

The task is to sum the invalid IDs in the ranges given. An invalid ID is a number formed of a number repeated exactly twice, eg. 123123.

Note that numbers of this form are multiples of 10...01 := k, for some non-negative number of zeroes. 
They must also have an even number of digits.

In the input, the number of digits in the first number in the range can differ from the number of digits of the last number by a maximum of one. This allows four cases to be considered, based on the parity of the number of digits in the first and last number in the range.

Let the number of digits in the first and last numbers be a and b respectively.

- If a odd, b odd: there can be no invalid IDs in the range.
- If a odd, b even: this is equivalent to the case when a is equal to the smallest b-digit number, ie. 10...00.
- If a even, b odd: this is equivalent to the case when b is equal to the greatest a-digit number, ie. 99..9.
- If a even, b even: the sum of invalid IDs is the sum of multiples of k in the range, which can be deduced from the summation formulae.

Summing the individual sums gives the result.

## 2️⃣ Part 2

The task is to sum the invalid IDs in the ranges given. 
However, an invalid ID is now any number formed of two or more repetitions of a number, eg. 676767, 1919, 33333.

A possible approach is to enumerate all numbers in the range and check if they match an invalid ID sequence using regular expressions. 
Since SQLite does not have a regex engine, a different approach had to be chosen.

The approach chosen was to hard-code all possibilities from 1 digit to 10 digits. 
This is easy for prime numbers since there can only be one type of invalid ID: k*11...1 for k in [1, 9]. 
Also, for numbers n with only one factor f apart from 1 and itself (4, 8, 9), all invalid IDs can be made from an f-digit number repeated n/f times.

6 and 10 are the harder cases. For 6 digits, invalid IDs are multiples of 1001 and 10101. However, this leads to overcounting, as the multiples of 111111 are counted in both cases. The adjustment is to subtract the sum of multiples of 111111.

The cases where a and b are different can be handled by summing the results for ranges [a, 99...9] and [10...00, b].

The sum of the results for each range gives the solution.