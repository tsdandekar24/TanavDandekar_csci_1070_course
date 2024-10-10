select *
from customer
where last_name like 'T%'
order by first_name;

select *
from rental
where rental_date between '2005-05-28' and '2005-06-01';

select title, COUNT(rental_id)
from inventory
inner join film on inventory.film_id = film.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by title
order by COUNT(rental_id) DESC
limit 10;

select first_name, last_name, SUM(amount)
from customer
inner join payment on customer.customer_id = payment.customer_id
group by first_name, last_name
order by SUM(amount);

select CONCAT(last_name, ', ', first_name) AS "Actor", COUNT(title) AS "Number of Movies"
from film_actor
inner join film on film_actor.film_id = film.film_id
inner join actor on film_actor.actor_id = actor.actor_id
where release_year = '2006'
group by first_name, last_name
order by COUNT(title) DESC;

select *
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id