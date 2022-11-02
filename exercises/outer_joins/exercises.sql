
/* -----------------------------------------------------------------------------
|   1. LEFT JOIN
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
-- Expected Row Count: 1


/* -----------------------------------------------------------------------------
|   2. FULL JOIN
|
|   The albums table also has another column containing references to the
|   artists table, called collaborator_id. This is either empty, or contains the
|   id of a row in the artists table.
|
|   One at a time, uncomment the two queries below, to look at the results of
|   the LEFT and RIGHT joins between artists (collaborators) and albums.
|
|   * Try to predict how many rows would be returned by a FULL OUTER JOIN
|     version of this query.
|   * Write, and run the query to see if you were correct.
|
*/ -----------------------------------------------------------------------------


-- SELECT artists.name, albums.title
-- FROM artists
-- LEFT JOIN albums
-- ON artists.id = albums.collaborator_id;


-- SELECT artists.name, albums.title
-- FROM artists
-- RIGHT JOIN albums
-- ON artists.id = albums.collaborator_id;


-- YOUR FULL JOIN GOES HERE

/* -----------------------------------------------------------------------------
|   3. Joining vs Filtering
|
|   Write a query that returns all artists, and any eelectronic albums if they've made any.
|   Results should include:
|       * The artist name
|       * The album title
|       * The album release_date
|
|  Now change the query to only return the artists which have made eelectronic albums.
|
*/ -----------------------------------------------------------------------------

-- FIRST QUERY GOES HERE
-- Expected Row Count: 10

-- SECOND QUERY GOES HERE
-- Expected Row Count: 9

/* -----------------------------------------------------------------------------
|   4. Join Order
|
|   Uncomment the below query to see the contents of the new `vendors` table.
|
|   Then write a query that returns all albums and any sales made by 'Clamazon'.
|   The results should include:
|       * The album title
|       * The vendor_name for each sale
|       * All columns from `sales`
|
*/ -----------------------------------------------------------------------------

-- SELECT id, vendor_name FROM vendors;

-- YOUR CODE GOES HERE
-- Expected Row Count: 768

/* -----------------------------------------------------------------------------
|   5. Joining the Same Table Twice
|
|   Write a single query that will return:
|     * The album title
|     * The name of the artist for the album
|     * The name of the collaborator on the album (if there is one)
|
*/ -----------------------------------------------------------------------------

-- YOUR CODE GOES HERE
