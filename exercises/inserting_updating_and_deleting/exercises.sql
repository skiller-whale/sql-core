/* -----------------------------------------------------------------------------
|
|  1. Creating New Tables
|
|  * In the space below, write a command that will create a table called tracks,
|    containing these columns:
|     * id, as an integer
|     * name, as a string with maximum length 255
|     * rating, as a numeric / floating point number
|
|  * Add a SELECT statement underneath to check that your table has been created
|
*/ -----------------------------------------------------------------------------

-- TODO: Write your command here!

/* -----------------------------------------------------------------------------
|
| 2. Dropping a Table From the Database
|
| * Write a command below that will remove the tracks table.
|
| * Uncomment the SELECT statement to check that the table no longer exists.
|   (This will produce an error if the table has been removed.)
|
| * Comment out the DROP command, so that the table is available for the
|   remaining exercises.
|
*/ -----------------------------------------------------------------------------

-- TODO: Write your command here!

-- TODO: Uncomment this query.
-- SELECT * FROM tracks;

/* -----------------------------------------------------------------------------
|
| 3. Altering Existing Tables
|
| * Write a command that will add a column to tracks called album_id that is an
|   integer.
|
| * Write one command that will change the type of the rating column from
|   NUMERIC to INTEGER.
|
| * Write two commands that will:
|       1. remove the name column from tracks, and then
|       2. add a name column as a string, but with a maximum length of 50.
|
| * Write a command that adds a column, description, as a long text field to the
|   albums table  (not the tracks table).
|
*/ -----------------------------------------------------------------------------

-- TODO: Write your table alteration commands here

/* -----------------------------------------------------------------------------
|
| 4. Adding New Rows to a Table
|
| * Uncomment the SELECT statement below and save the file. Notice the
|   order of columns from the tracks table.
|
| * Above the SELECT, write one command to insert the following data as one row
|   to the tracks table without specifying column names:
|
|    * id=1, name='Bridge Over Troubled Water', rating=5, album_id=3
|
| * Add a second command that will insert the following data as one row to the
|   tracks table:
|
|    * id=2, name='I Am A Rockfish', album_id=3
|
| * Add a third command that will insert the following data as several rows with
|   one command:
|
|    * id=3, name='Mrs Dolphinson', album_id=3
|    * id=4, name='The Sounds Of Salmon', album_id=3
|    * id=5, name='Walrus Bound', album_id=3
|
*/ -----------------------------------------------------------------------------

-- TODO: Write your data insert commands here!

-- TODO: Uncomment this query
-- SELECT albums.title as album_title,
--   albums.description as album_desc,
--   tracks.*
-- FROM albums
--   LEFT JOIN tracks ON tracks.album_id = albums.id
-- WHERE albums.id = 3;

/* -----------------------------------------------------------------------------
|
| 5.  Deleting Rows From a Table
|
| * Uncomment the SELECT statement below.
|
| * Before the SELECT, write a command that will delete rows from the tracks
|   table where id = 3.
|
| * Adjust the DELETE command to delete all rows with id less than 3.
|
| * Remove the WHERE clause and check how many rows are output when you save the
|   file.
|
*/ -----------------------------------------------------------------------------

-- TODO: Write your data deletion commands here!

-- TODO: Uncomment this query
-- SELECT * FROM tracks;

/* -----------------------------------------------------------------------------
|
| 6. Updating Data in a Table
|
| * Make sure that the DELETE command(s) from the previous exercise are
|   commented out or removed (so that there is data in the tracks table).
|
| * Uncomment the SELECT below.
|
| * Write a command to update all rows to have a rating of 4.
|
| * Write a command that will update the rows with id 3 or 4 to set the value of
|   name to NULL.
|
| * Write a command that will update all rows without a name to have a rating
|   of 2.
|
| * Write a command that will update the album with id 3 to have a description.
|   (Use whatever short sentence comes to mind.)
|
*/ -----------------------------------------------------------------------------

-- TODO: Write your data update commands here!

-- TODO: Uncomment this query
-- SELECT albums.title as album_title,
--   albums.description as albums_desc,
--   tracks.*,
--   tracks.rating
-- FROM albums
-- JOIN tracks
--   ON tracks.album_id = albums.id
-- WHERE albums.id = 3;
