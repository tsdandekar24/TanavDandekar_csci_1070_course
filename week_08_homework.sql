-- 1.
UPDATE rental
SET status = 
    CASE
        WHEN return_date > rental_date + INTERVAL '1 day' * rental_duration THEN 'late'
        WHEN return_date < rental_date + INTERVAL '1 day' * rental_duration THEN 'early'
        ELSE 'on time'
    END
FROM inventory, film
WHERE rental.inventory_id = inventory.inventory_id AND inventory.film_id = film.film_id;
-- 2.
SELECT city, SUM(amount) AS "Total Payment"
FROM city
INNER JOIN address on city.city_id = address.city_id
INNER JOIN customer on address.address_id = customer.address_id
INNER JOIN payment on customer.customer_id = payment.customer_id
WHERE city = 'Saint Louis' OR city = 'Kansas City'
GROUP BY city;

-- 3. 
SELECT name, COUNT(name)
FROM film_category
INNER JOIN category on film_category.category_id = category.category_id
GROUP BY name;

-- 4.
-- There is a table for film category and category because the film category deals with the each film and its category_id.
-- The category table deals with general information of each category such as the category_id and its name. They are connected
-- by the category_id.

-- 5.
SELECT film.film_id, title, length
FROM film
INNER JOIN inventory on film.film_id = inventory.film_id
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
WHERE return_date BETWEEN '2005-05-01' AND '2005-05-31';

-- 6.
SELECT film_id, amount
FROM inventory
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on rental.rental_id = payment.rental_id
WHERE amount < (SELECT AVG(amount) FROM payment);

-- 7.
SELECT status, COUNT(status)
FROM rental
GROUP BY status;

-- 8.
SELECT film_id, length, PERCENT_RANK() OVER(ORDER BY length) AS "Percent Rank"
FROM film;

-- 9.
EXPLAIN ANALYZE SELECT status, COUNT(status)
FROM rental
GROUP BY status;
-- In the HashAggregate row, it talks about the estimate rows being looked at being 736 rows, and how many rows it produces. 
-- It also mentions the amount of time it takes to run this. Because the rows are being grouped by, it uses status as its group key. 
-- It talks about the amount of memory it uses. After that, it does a sequential scan looking at all the rows to count
-- the different statuses.

EXPLAIN ANALYZE SELECT film_id, amount
FROM inventory
INNER JOIN rental on inventory.inventory_id = rental.inventory_id
INNER JOIN payment on rental.rental_id = payment.rental_id
WHERE amount < (SELECT AVG(amount) FROM payment)
-- It first talks about doing a has join  and how many rows it has to consider for it. It shows the amount of time
-- it takes to perform the hash join. The conditional of the hash join is when rental.inventory_id = inventory.inventory_id.
-- It talks about its lists of plans for calculating the payment. It recognizes the aggregate function AVG() for amount.
-- It looks about 291 rows for the data. While doing this, it does a sequential scan on payment column. It records the time
-- and the amount of rows it looks at. Then, it looks at the other join statament and how much time and rows it looks at. The
-- condition it looks at is when payment.rental_id = rental.rental_id. It does another sequential scan on the payment column.
-- It records the amount of time and number of rows it looks at. It filters the data where the amount is less than $0, which
-- ends up removing 7042 rows. It talks about how it looks at 16,044 rows and how it takes about 5.2 seconds to look at this
-- data. It uses 16,384 buckets and a certain amount of memory. During this, it does a sequential scan on the rental table. It
-- returns the amount of time and rows it looks at. Once all of the stuff is done for the join statments, it has a limited
-- number of rows to look at. It uses 8192 buckets and more memory. It performs another sequential scan on the inventory table
-- and lists the time and rows it looks at. Finally, it lists the total planning and execution times for these statments to do.

-- The difference between these 2 explain anaylze statements is that it's obviously more complicated for the second SQL statements
-- due to there being more restrictions and things it has to look at before it can run the statments. Because the second statment
-- is more complicated, it takes more memory to run it due to it looking at multiple tables. The first statement only had to lok at one table.
-- The first statment had to run a COUNT(), but it only had to display the results of it. The second statment had AVG(),
-- but in its where statement. In addition, the where statement had an embedded select statement just to run the AVG(amount).
-- The statements could only select data that fit the where statement of amount > AVG(amount) from the payment table.

-- Extra credit
-- Set-based programming uses groups of data like tables to manipulate the data to what the programmer wants to receive. An example of 
-- set-based programming is SQL. SQL uses tables from databases. The user can input statements to produce the data to what they want.
-- Procedural programming uses multiple functions to eventually break down the data into steps. Python is an example of procedural programming. 
-- Python can use functions in order to get the data they want. Different variables and functions can be used to achieve this.

