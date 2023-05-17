

/* -----------------------------------------------------------------------------
|   1. CASE
|
|   The following query returns a list of albums and their total sales.
|
|   Uncomment the query, and save the file to run it.
|
|   Change the query to also return a `sales_volume` column that contains one of 'High', 'Medium' or 'Low':
|       * An album is 'Low' sales if it's had less than 100 total sales.
|       * An album is 'Medium' sales if it's had between 100 and 400 total sales.
|       * An album is 'High' sales if it's had more than 400 total sales.
|
*/ -----------------------------------------------------------------------------

-- SELECT
--     a.title,
--     COUNT(s) AS total_sales --,
--     --YOUR CODE GOES HERE
-- FROM
--     albums a
--     LEFT JOIN sales s ON s.album_id = a.id
-- GROUP BY a.id
-- ORDER BY total_sales;
-- -- Expected Row Count: 20
-- -- Expected 'Low' sales_volume: 3
-- -- Expected 'Medium' sales_volume: 11
-- -- Expected 'High' sales_volume: 6

/* -----------------------------------------------------------------------------
|   2. COALESCE
|
|   The following query joins the albums table to the artists table twice,
|   to get the artist and collaborator ids and names for each album.
|
|   Uncomment the query, and save the file to run it.
|
|   Some albums do not have a collaborator, so return NULL for collaborator name.
|
|   * Change the query so that the string 'None' is returned instead of NULL when
|     there is no collaborator.
|
*/ -----------------------------------------------------------------------------

-- SELECT
--     al.title AS album_title,
--     ar.name AS artist_name,
--     c.name AS collaborator_name
-- FROM
--     albums al
--     JOIN artists ar ON al.artist_id = ar.id
--     LEFT JOIN artists c ON al.collaborator_id = c.id;
-- Expected Row Count: 20
-- Expected NULL collaborator_name: 0

/* -----------------------------------------------------------------------------
|   3. Concatenating strings
|
|   The following query is similar to the previous one.
|   It joins the albums table to the artists table twice,
|   to get the artist and collaborator ids and names.
|
|   Uncomment the query, and save the file to run it.
|
|   Change the query to return a new `artists_description` column that will
|   display the artist and collaborator names in a single string:
|       * If `collaborator_name` is not NULL: "Artist: <artist_name> - Collaborator: <collaborator_name>"
|       * If `collaborator_name` is NULL: "Artist: <artist_name> - Collaborator: None"
|
|   Optional: Now change the NULL behaviour to:
|       * If `collaborator_name` is NULL: "Artist: <artist_name>"
|
|   Do you think SQL is the best place to perform this logic?
|
*/ -----------------------------------------------------------------------------

-- SELECT
--     al.title AS album_title,
--     ar.name AS artist_name,
--     c.name AS collaborator_name --,
--     -- YOUR CODE GOES HERE
-- FROM
--     albums al
--     JOIN artists ar ON al.artist_id = ar.id
--     LEFT JOIN artists c ON al.collaborator_id = c.id;
-- -- Expected Row Count: 20
-- -- Expected NULL artists_description: 0

/* -----------------------------------------------------------------------------
|   4. Comparing Strings - LIKE
|
|   Write two queries that find albums where:
|       1. the title contains "Sea" (case sensitive)
|       2. the title starts with "Sea" (case sensitive)
*/ -----------------------------------------------------------------------------

-- QUERY_1_GOES_HERE
-- Row Count: 3

-- QUERY_2_GOES_HERE
-- Row Count: 1

/* -----------------------------------------------------------------------------
|   5. Comparing Strings - Case Sensitivity
|
|   Write a query to find albums where the title or genre
|   contains "sea" (case insensitive this time)
*/ -----------------------------------------------------------------------------

-- YOUR_CODE_GOES_HERE
-- Row Count: 5

/* -----------------------------------------------------------------------------
|   6. Dates
|
|   The following query selects album titles together with their earliest and
|   latest recorded sale dates.
|
|   Part 1:
|
|       * Uncomment the query, and save the file to run it.
|       * Change the query to return a new `sale_range_desc` column that will display the
|         range of sale dates as a single string, for example: '27/02/2017 - 31/08/2020'
|
|   Part 2 (you can do these steps in any order):
|
|       * Change your query so `sale_range_desc` returns 'UNSOLD' for albums with 0 sales.
|       * Add a `sale_duration_category` column to categorise the albums by how long they've sold for:
|            More than 5 years:      'Long'
|            Between 2 and 5 years:  'Medium'
|            Less than 2 years:      'Short'
|         Assume for this exercise that a year is exactly 365 days long.

*/ -----------------------------------------------------------------------------

-- SELECT
--     a.title,
--     MIN(s.date) AS earliest_sale,
--     MAX(s.date) AS latest_sale --,
--     -- YOUR CODE HERE - AS sale_range_desc
-- FROM albums a
-- LEFT JOIN sales s ON s.album_id = a.id
-- GROUP BY a.id
-- HAVING MAX(s.date) - MIN(s.date) < 365 * 7; --Filter to albums with a sale range of less than 7 years.
-- --NB: In Postgres, subtracting a DATE from a DATE gives the number of days between as an integer.
-- Expected Row Count: 19
-- Expected Row Count if including 'UNSOLD' albums: 20
