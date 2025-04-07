/*	Question Set 1 - Easy */

/* Q1: Who is the senior most employee based on job title? */

SELECT first_name, last_name, title
FROM employee
ORDER BY levels DESC
LIMIT 1


/* Q2: Which countries have the most Invoices? */

SELECT billing_country,COUNT(billing_country) as total
FROM invoice
GROUP BY billing_country
ORDER BY total DESC

/* Q3: What are top 3 values of total invoice? */

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

SELECT billing_city, SUM(total) as invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT c.customer_id,c.first_name, c.last_name,i.billing_city, SUM(i.total) as invoice_total
FROM customer c
JOIN invoice i ON c.customer_id=i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name,i.billing_city
ORDER BY SUM(i.total) DESC
LIMIT 1



/* Question Set 2 - Moderate */

/* Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT c.first_name,c.last_name,c.email
FROM customer c
JOIN invoice i ON c.customer_id=i.customer_id
JOIN invoice_line il ON il.invoice_id=i.invoice_id
WHERE track_id IN (
          SELECT track_id From track t
		  JOIN genre g ON t.genre_id=g.genre_id
		  WHERE g.name='Rock'
)
ORDER BY email

/* Q2: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT a.name , COUNT(ab.title) as top_title
FROM artist a 
JOIN album ab ON a.artist_id=ab.artist_id
JOIN track t ON t.album_id=ab.album_id
JOIN genre g ON g.genre_id=t.genre_id
WHERE g.name='Rock'
GROUP BY a.name
ORDER BY top_title DESC
LIMIT 10

/* Q3: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name, milliseconds
FROM track
WHERE milliseconds > (
          SELECT AVG(milliseconds)
		  FROM track
)
ORDER BY milliseconds DESC







