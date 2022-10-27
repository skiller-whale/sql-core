/* -----------------------------------------------------------------------------
|   1. Data Stored Across Multiple Tables
|
|   In the space given below, write the following queries:
|
|   * SELECT all the columns of artists table
|   * SELECT all the columns of albums table
|
|   Remember to include a semicolon ; after each query.
|   Save the file after each query you write to get the results.
|   If you write both before saving only the last query will run.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   2. Using JOIN to Combine Tables
|
|   In the space below, write a single query that will select the album title,
|   and the corresponding artist's name for each album in the database.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   3. Filtering Results After Joining
|
|   In the space below, write a query that will return:
|     * The album title
|     * The sale date
|
|   for all sales of albums with more than 11 tracks.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE

/* -----------------------------------------------------------------------------
|   4. Filtering vs Joins
|
|   Edit the following queries using appropriate JOIN and WHERE conditions
|
*/ -----------------------------------------------------------------------------

-- This query finds any sales recorded on '2019-11-16', and their album details.

-- SELECT *
-- FROM albums a, sales s
-- WHERE s.date = '2019-11-16'
-- AND s.album_id = a.id;

-- This query finds all `Salmon and Garfunkel` sales recorded in 2020.

-- SELECT sales.*, artists.name
-- FROM sales, albums, artists
-- WHERE artists.name = 'Salmon and Garfunkel'
-- AND albums.artist_id = artists.id
-- AND sales.date >= '2020-01-01'
-- AND sales.date < '2021-01-01'
-- AND sales.album_id = albums.id;

/* -----------------------------------------------------------------------------
|   5. Joining on multiple columns
|
|   This question uses a new industry_revenue_history table with global information
|   about the percentages of revenue for different music formats.
|
|   You can uncomment the query below to see this table.
|   Note that the period_end date is NOT inclusive
|   (a period goes from the period_start date until the day before the period_end)
|
|   Then, write a query that will return the following 3 things for all albums
|   released in periods when streaming accounted for more than 50% of revenue:
|     * The album title
|     * The release date
|     * What % of music industry revenue came from streaming in the period it was released in.
|
*/ -----------------------------------------------------------------------------

-- SELECT *
-- FROM industry_revenue_history;

-- YOUR CODE GOES HERE
