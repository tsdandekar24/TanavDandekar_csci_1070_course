select *
from payment
where amount >= 9.99;

select MAX(amount)
from payment;

select title, amount
from payment
inner join rental on payment.rental_id = rental.rental_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
where amount = '11.99';

select first_name, last_name, email, address, city, country
from staff
inner join address on staff.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id

-- I am interested in working in industries that have to deal with business or banks with computer science.
-- Also, I don't know how it would work but maybe companies that have to deal with medical things.

-- The crow's foot notation in the dvdrental shows the connections between two or more different tables. For example,
-- rental and customer tables are connected by the customer_ids in both tables. From rental to customer, there is a
-- "|o". This means there is one and an optional relationship. One of the rentals could have one or no relationships 
-- between the customer. From customer to rental, there is a "||".  This means there is one thing that customer is 
-- related to rental. The customer can only be attached to one rental thing.