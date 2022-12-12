
/* -----------------------------------------------------------------------------
|   1. Using a Subquery in an `IN` Clause
*/ -----------------------------------------------------------------------------

-- This query gets some artist ids that satisfy some strange criteria.
-- Write a query that returns the details of each artist for these artist ids.
SELECT artist_id, COUNT(s.*), AVG(s.amount)
FROM sales s
LEFT JOIN vendor v ON s.vendor_id = v.id
WHERE v.name LIKE '%Clam%'
GROUP BY artist_id
HAVING
    COUNT(s.*) > 5
    AND AVG(s.amount) > 25

SELECT * FROM artists
WHERE id IN (
    SELECT artist_id
    FROM sales s
    LEFT JOIN vendor v ON s.vendor_id = v.id
    WHERE v.name LIKE '%Clam%'
    GROUP BY artist_id
    HAVING
        COUNT(s.*) > 5
        AND AVG(s.amount) > 25
)

--Here's how you'd do it as a join. This might be part of the exercise, or an instructor note.
-- Note that it allows you to get the extra statistics.
SELECT a.*, COUNT(s.*), AVG(s.amount)
FROM artists a
JOIN sales s ON a.id = s.artist_id
LEFT JOIN vendor v ON s.vendor_id = v.id
WHERE v.name LIKE '%Clam%'
GROUP BY a.id
HAVING
    COUNT(s.*) > 5
    AND AVG(s.amount) > 25


/* -----------------------------------------------------------------------------
|   2. Single-Row Single-Column subquery
*/ -----------------------------------------------------------------------------

SELECT 2 * MIN(price) AS lower_bound FROM sales;

--Using the above, write a query to get all the sales that are more than twice the value of the lowest sale.

--Answer:
SELECT *
FROM sales
WHERE sales.amount_spent > (SELECT 2 * MIN(price) AS lower_bound FROM sales)

/* -----------------------------------------------------------------------------
|   3. Single-row multi-column Subquery
*/ -----------------------------------------------------------------------------

--Get the best-selling genres and record labels.
SELECT genre, record_label
FROM albums a
JOIN sales s ON s.album_id = a.id
GROUP BY genre, record_label
HAVING COUNT(s.*) > 800

--Answer:
SELECT *
FROM albums
WHERE (genre, record_label) IN
(
    SELECT genre, record_label
    FROM albums a
    JOIN sales s ON s.album_id = a.id
    GROUP BY genre, record_label
    HAVING COUNT(s.*) > 800
)

/* -----------------------------------------------------------------------------
|   4. Derived Table Subquery
*/ -----------------------------------------------------------------------------
-- Same as row comparator, but change to use statistics.

--Answer:
SELECT
    a.*,
    genre_stats.total_sales,
    genre_stats.total_revenue,
    genre_stats.sales_per_album
FROM albums a
JOIN
(
    SELECT
        genre,
        record_label,
        COUNT(s.*) AS total_sales,
        SUM(s.amount) AS total_revenue,
        COUNT(s.*)/COUNT(DISTINCT album_id) AS sales_per_album
    FROM albums a
    JOIN sales s ON s.album_id = a.id
    GROUP BY genre, record_label
    HAVING COUNT(s.*) > 800
) AS genre_stats
ON a.genre = genre_stats.genre
AND a.record_label = genre_stats.record_label

--Could also use something with an inequality to force a derived table rather than row comparator.
--Maybe split the assessment question to check derived table more uniquely.

/* -----------------------------------------------------------------------------
|   5. Correlated Subqueries
*/ -----------------------------------------------------------------------------

-- TODO: 2 similar queries with subqueries. Identify which one is using a correlated subquery, and rewrite it as a join.

/* -----------------------------------------------------------------------------
|   6. EXISTS
*/ -----------------------------------------------------------------------------

-- A query written with left join and IS NULL - rewrite to use EXISTS.
SELECT albums.title
FROM albums
LEFT JOIN sales
  ON albums.id = sales.album_id
WHERE sales.id IS NULL;

--Rewrite to:
SELECT albums.title
FROM albums
WHERE NOT EXISTS (
    SELECT 1 --can explain what this is doing, and why it's used.
    FROM sales
    WHERE sales.album_id = albums.id
)
