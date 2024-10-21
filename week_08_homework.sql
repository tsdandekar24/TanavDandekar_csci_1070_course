--INSERT INTO rental (status)
--VALUES (CASE
--			WHEN 		
--		END)

SELECT rental_date, payment_date, return_date
FROM rental
INNER JOIN payment on rental.customer_id = payment.customer_id