
/* -----------------------------------------------------------------------------
|   1. UNION
|
|   Imagine a global company, with databases in each region managed separately.
|   These each have a sales table, but they're slightly different.
|   You've imported these into one database with the names `sales_usa` and `sales_europe`.
|
|   Uncomment the below queries to see the contents of the `sales_usa` and
|   `sales_europe` table.
|
|   Then write a query that returns the combined sales from both tables
|   The results should include the currency of each sale.
|
|   Note: the currency code for all USA sales should be 'USD'
*/ -----------------------------------------------------------------------------

--SELECT id, product_name, sale_date, amount, currency_code FROM sales_europe;
--SELECT id, product_name, amount, sale_date FROM sales_usa;

-- YOUR CODE GOES HERE
-- Expected Row Count: 4303


/* -----------------------------------------------------------------------------
|   2. EXCEPT
|
|   The sales_usa and sales_europe tables include product names - there isn't a separate products table.
|
|   Write 3 queries to get the following information about the products.
|   Find all the `product_name`s that have been sold:
|       * in either the USA OR Europe
|       * in the USA but NOT Europe
|       * in both the USA AND Europe - you will need to use EXCEPT for this query
|
*/ -----------------------------------------------------------------------------

-- Find all the products sold - either in the usa or europe
-- YOUR CODE GOES HERE
-- Expected Row Count: 13

-- Find all the products sold in just the USA, i.e. USA but not Europe
-- YOUR CODE GOES HERE
-- Expected Row Count: 2

-- Find all the products with sales in both the usa AND europe
-- YOUR CODE GOES HERE
-- Expected Row Count: 11

/* -----------------------------------------------------------------------------
|   3. INTERSECT
|
|   Write a query to find all the products with sales in both the usa AND europe.
|   This should return the same results as the last query from exercise 2.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE
-- Expected Row Count: 11

/* -----------------------------------------------------------------------------
|   4. UNION ALL
|
|   Look at the query below. Do you think the results will change if you
|   change UNION to UNION ALL? Write down why you think this might be.
|
|   Now try changing the query to UNION ALL - were you correct?
|
|   Remove the `id` column, and try the query again with both UNION and UNION ALL, to see the difference.
|
|   Note: A possible reason to remove the `id` is so you can insert all rows
|         into a new combined `sales` table.
|
*/ -----------------------------------------------------------------------------

-- SELECT
--     id,
--     product_name, sale_date, amount, currency_code
-- FROM sales_europe
-- UNION
-- SELECT
--     id,
--     product_name, sale_date, amount, 'USD'
-- FROM sales_usa;

-- UNION     Row count: ADD_HERE
-- UNION ALL Row count: ADD_HERE

-- UNION     (No id) Row count: ADD_HERE
-- UNION ALL (No id) Row count: ADD_HERE

/* -----------------------------------------------------------------------------
|   5. Comparing Queries with EXCEPT
|
|   You will recognise the queries below from the previous exercise.
|
|   How might you find out which rows are different?
|
|   Try this out, and see if it works. Why do you think this is?
|
*/ -----------------------------------------------------------------------------

-- SELECT product_name, sale_date, amount, currency_code
-- FROM sales_europe
-- UNION ALL
-- SELECT product_name, sale_date, amount, 'USD'
-- FROM sales_usa

-- SELECT product_name, sale_date, amount, currency_code
-- FROM sales_europe
-- UNION
-- SELECT product_name, sale_date, amount, 'USD'
-- FROM sales_usa

/* -----------------------------------------------------------------------------
|   6. EXCEPT ALL
|
|   The following two queries try to find "Impressive" sales from the `sales_usa`
|   table - a sale is "Impressive" if the `product_name` has 'Advanced' in the title
|   **OR** has sold for more than $50.
|
|   Unfortunately they return different row counts.
|
|   Write queries to find the rows which are different, and decide if query A or B is correct.
|
*/ -----------------------------------------------------------------------------

-- Query A
-- SELECT product_name, sale_date, amount
-- FROM sales_usa
-- WHERE amount > 100
-- OR product_name LIKE 'Advanced%';
-- Row Count: 1789

-- Query B
-- SELECT product_name, sale_date, amount
-- FROM sales_usa
-- WHERE amount > 50
-- UNION ALL
-- SELECT product_name, sale_date, amount
-- FROM sales_usa
-- WHERE product_name LIKE 'Advanced%';
-- Row Count: 1805

-- YOUR CODE GOES HERE
