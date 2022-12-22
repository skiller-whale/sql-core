/* -----------------------------------------------------------------------------
|   0. Database Diagram
|
|   A copy of the database diagram from the slides can be found at:
|
|       * exercises/album_sales.png
|
*/ -----------------------------------------------------------------------------

/* -----------------------------------------------------------------------------
|   1. Querying Using Results
|
|   The following query gets some album ids that satisfy some complex criteria
|   we do not want to break by modifying the query.
|
|       * Uncomment and run the query.
|       * Using this as a subquery, write a query to select all columns from the
|        `albums` table for these album ids.
|       * Do you think you can also select the `COUNT(s.*)` and `AVG(s.amount)`
|         from the subquery? What might you try instead? **You don't need to
|         actually write this query.**
|
*/ -----------------------------------------------------------------------------

-- SELECT album_id
-- FROM sales s
-- LEFT JOIN vendors v ON s.vendor_id = v.id
-- WHERE v.vendor_name LIKE '%Clam%'
-- GROUP BY album_id
-- HAVING
--     COUNT(s.*) > 5
--     AND AVG(s.amount) > 15;
-- -- Row Count: 5

/* -----------------------------------------------------------------------------
|   2. Single-Row, Single-Column Subquery
|
|       * Write a query to get all the sales that are more than twice the amount
|         of the lowest sale (you can use `MIN()` for this).
|       * Now modify the query to also restrict to the sales that are less than
|         three times the amount of the lowest sale.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE
-- Expected Row Count: 2654

-- YOUR CODE GOES HERE
-- Expected Row Count: 2648

/* -----------------------------------------------------------------------------
|   3. Multi-Column Subqueries
|
|   The following query gets the best-selling genres and record labels.
|
|       * Uncomment and run the query.
|       * Write a query to select all albums for these combinations of genres and
|         record labels.
|
*/ -----------------------------------------------------------------------------

-- SELECT genre, record_label
-- FROM albums a
-- JOIN sales s ON s.album_id = a.id
-- GROUP BY genre, record_label
-- HAVING COUNT(s.*) > 800;
-- -- Row Count: 3

-- YOUR CODE GOES HERE
-- Expected Row Count: 11

/* -----------------------------------------------------------------------------
|   4. Derived Table Subquery
|
|   The following query gets the best-selling genres and record labels, AND some
|   statistics about them.
|
|       * Uncomment and run the query.
|       * Use a derived table subquery and a JOIN to select all albums for these
|         combinations of genres and record labels, AND include the statistics.
|       * Optional - Explain why you can't use a row constructor to answer this question.
|
*/ -----------------------------------------------------------------------------

-- SELECT
--     genre,
--     record_label,
--     COUNT(s.*) AS total_sales,
--     SUM(s.amount) AS total_revenue,
--     COUNT(s.*)/COUNT(DISTINCT album_id) AS sales_per_album
-- FROM albums a
-- JOIN sales s ON s.album_id = a.id
-- GROUP BY genre, record_label
-- HAVING COUNT(s.*) > 800;
-- -- Row Count: 3

-- YOUR CODE GOES HERE
-- Expected Row Count: 11

/* -----------------------------------------------------------------------------
|   5. Correlated Subqueries
|
|   Below are two queries with subqueries - one is a correlated subquery.
|
|       * Which is the correlated subquery?
|       * These queries might be more readable or performant using a JOIN.
|         Rewrite both queries to use a JOIN.
|
*/ -----------------------------------------------------------------------------

-- Query 1 - Get all sales of albums with more than 10 tracks.
-- SELECT *
-- FROM sales
-- WHERE album_id IN (
--     SELECT id
--     FROM albums
--     WHERE n_tracks > 10
-- );
-- -- Row Count 1200

-- Query 2 -  Get all sales of albums with more tracks than their sale price.
-- SELECT *
-- FROM sales
-- WHERE album_id IN (
--     SELECT id
--     FROM albums
--     WHERE n_tracks > amount
-- );
-- -- Row Count 524

/* -----------------------------------------------------------------------------
|   6. EXISTS
|
|   Rewrite the following two queries, as follows:
|
|       * Rewrite the first query to use the EXISTS keyword.
|       * Rewrite the second query to NOT use the EXISTS keyword.
|
*/ -----------------------------------------------------------------------------

-- Rewrite to use EXISTS:
-- SELECT albums.title
-- FROM albums
-- LEFT JOIN sales
--   ON albums.id = sales.album_id
-- WHERE sales.id IS NULL;
-- -- Row Count 1

-- Rewrite NOT to use EXISTS:
-- SELECT albums.title
-- FROM albums
-- WHERE EXISTS (
--     SELECT 1
--     FROM sales
--     WHERE albums.id = sales.album_id
-- );
-- -- Row Count 19
