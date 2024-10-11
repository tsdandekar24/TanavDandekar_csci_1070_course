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
--explain anaylze select first_name, last_name, SUM(amount)
--from customer
--inner join payment on customer.customer_id = payment.customer_id
--group by first_name, last_name
--order by SUM(amount);
-- It first talks about the number of rows that it returns and how long it does to do that. It then sorts it by
-- the sum(amount) and how it uses a quick sort. Next, it groups the columns by the first_name and last_name. After,
-- it joins the payment and customer tables based on the shared customer_id. It then proceeds to do a sequential scan
-- on payment and customer tables. It then shows a planning time of 5.008ms and exection time of 10.514ms.

select CONCAT(last_name, ', ', first_name) AS "Actor", COUNT(title) AS "Number of Movies"
from film_actor
inner join film on film_actor.film_id = film.film_id
inner join actor on film_actor.actor_id = actor.actor_id
where release_year = '2006'
group by first_name, last_name
order by COUNT(title) DESC;
--explain analyze select CONCAT(last_name, ', ', first_name) AS "Actor", COUNT(title) AS "Number of Movies"
--from film_actor
--inner join film on film_actor.film_id = film.film_id
--inner join actor on film_actor.actor_id = actor.actor_id
--where release_year = '2006'
--group by first_name, last_name
--order by COUNT(title) DESC;
-- The first line talks about the minimum and maximum times it takes to run the code. It also talks about the number of rows
-- it returns. It then orders the count(title) in a descending order and does a quick sort. It groups the rows by the actor.first_name
-- and actor.last_name. It joins film_actor and actor on actor_id. It then does a scan on the film_actor table. Then, it does
-- a sequetial scan on actor where the release_year is 2006. After, it does a sequential scan on actor table. The planning time is 6.035 ms.
-- The execution time is 2.875 ms.

select name, AVG(rental_rate)
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
group by name;

select name, COUNT(rental_rate), SUM(amount) 
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
inner join payment on rental.customer_id = payment.customer_id
group by name
order by COUNT(rental_rate) DESC
limit 5;

select to_char(rental_date, 'Month'), name, COUNT(rental_id)
from category
inner join film_category on category.category_id = film_category.category_id
inner join film on film_category.film_id = film.film_id
inner join inventory on film.film_id = inventory.film_id
inner join rental on inventory.inventory_id = rental.inventory_id
group by to_char(rental_date, 'Month'), name
order by to_char(rental_date, 'Month')
