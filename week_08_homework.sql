--INSERT INTO rental (status)
--VALUES (CASE
--			WHEN 		
--		END)

SELECT rental_date, payment_date, return_date
FROM rental
INNER JOIN payment on rental.customer_id = payment.customer_id;

SELECT city, SUM(amount)
FROM city
INNER JOIN address on city.city_id = address.city_id
INNER JOIN customer on address.address_id = customer.address_id
INNER JOIN payment on customer.customer_id = payment.customer_id
WHERE city = 'Saint Louis' OR city = 'Kansas City'
GROUP BY city;

