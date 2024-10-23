
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
--

	

