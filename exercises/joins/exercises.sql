/* -----------------------------------------------------------------------------
|   1. Data Stored Across Multiple Tables
|
|   In the space given below, write the following queries:
|
|   * SELECT all the columns of artists table
|   * SELECT all the columns of albums table
|
|   Remember to include a semicolon ; after each query.
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
|   4. LEFT JOIN
|
|   * In the space below, write a single query to find out the title of all
|     albums with 0 sales.
|
|   (Hint: you can test if a value is `NULL` using `value IS NULL`)
|
|   * Extend the query, to additionally include the name of the artist for each
|     album with 0 sales.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   5. RIGHT JOIN
|
|   In the space below, write another query to find out the artist name, and
|   album title of all albums with 0 sales.
|
|   Do this using a RIGHT join (and no LEFT join).
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   6. FULL JOIN
|
|   The albums table also has another column containing references to the
|   artists table, called collaborator_id. This is either empty, or contains the
|   id of a row in the artists table.
|
|   * Write two queries, a LEFT JOIN and a RIGHT JOIN, that join the artists to
|     the albums using the collaborator_id.
|   * Note how many rows were returned for each query.
|
|   * Try to predict how many rows would be returned by a FULL OUTER JOIN using
|     this column.
|   * Write the query to see if you were correct.
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE


/* -----------------------------------------------------------------------------
|   7. Using Table Aliases
|
|   Write a single query that will return:
|     * The album title
|     * The name of the artist for the album
|     * The name of the collaborate on the album (if there is one)
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE
