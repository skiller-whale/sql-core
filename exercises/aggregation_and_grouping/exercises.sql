/* -----------------------------------------------------------------------------
|   1. MAX and MIN
|
|   Write a single query that will SELECT from the sales table:
|
|   * The largest sale price (amount)
|   * The smallest sale price
|   * The earliest sale date (date)
|   * The latest sale date
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   2. Aggregates with JOIN and WHERE
|
|   Write a single query that will SELECT:
|
|    * The cheapest sale amount  (sales.amount)
|    * The largest number of tracks on an album  (albums.n_tracks)
|    * The alphabetically first album title  (albums.title)
|
|   across all albums and sales for the artist named 'Lenny Crabitz'
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   3. COUNT, SUM and AVG
|
|   Write a single query that will SELECT:
|
|    * The total number of sales
|    * The total amount made from sales
|    * The average sales price
|    * The average album length  (albums.minutes)
|
|   across all albums and sales for the artist named 'Salmon and Garfunkel'.
|
|   Note: You can use your previous query as a starting point.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   4. GROUP BY
|
|   Write a single query that will SELECT the following for all artists:
|
|    * The artist name
|    * The total number of sales made by that artist
|    * The total amount they made from sales
|    * Their average sales price
|    * Their alphabetically first album title
|
|   Note: You can use your previous query as a starting point.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   5. MULTIPLE GROUP BY
|
|   Write a single query that will SELECT the following for all artists:
|
|    * The artist name
|    * The album genre
|    * The average sales price
|
|   for all (artist, genre) combinations.
|
|   If an artist has albums with different genres, then they should appear in
|   the results multiple times (one for each genre)
|
|   Note: You can use your previous query as a starting point.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   6. HAVING
|
|   1. Write a single query that will SELECT:
|      * Artist name
|      * Album title
|      * The number of sales
|
|     for all albums where the total sales amount is more than 8000.
|
|     Note: You can use your previous query as a starting point.
|
|   2. Add an ORDER BY to your query, so that the albums with the most sales
|      (i.e. highest COUNT) appear at the top of the results.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE
