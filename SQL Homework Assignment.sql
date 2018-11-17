use sakila;

-- 1a.
select first_name, last_name
from actor;

-- 1b.
select concat(first_name, " ",  last_name) as  'Actor Name'
from actor;

-- 2a.
select actor_id, first_name, last_name
from actor
where first_name = 'Joe';

-- 2b.
select actor_id, first_name, last_name
from actor
where last_name like "%gen%";

-- 2c.
select last_name, first_name
from actor
where last_name like "%li%" ;

-- 2d.
select country_id, country
from country
where country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.
alter table actor
add description blob;
select * from actor;

-- 3b.
alter table actor
drop column description;
select * from actor;

-- 4a.
select last_name, count(last_name) as 'Actors with that last name"'
from actor
group by last_name;

-- 4b.
select last_name, count(last_name) as 'Actors_with_that_last_name'
from actor
group by last_name
having count(last_name) > 1 ;

-- 4c.
update actor
set first_name = "Harpo"
where first_name = "Groucho" and last_name = "Williams";

-- 4d.
update actor
set first_name = "Groucho"
where first_name = "Harpo";

-- 5a.
show columns from sakila.address;
show create table sakila.address;

-- 6a.
select staff.first_name, staff.last_name, address.address
from staff
inner join address on staff.address_id = address.address_id;

-- 6b. 
select staff.first_name, staff.last_name, sum(payment.amount) as 'Total Amount'
from staff
join payment on (staff.staff_id =payment.staff_id)
where payment.payment_date between "2005-08-01" and "2005-08-30"
group by first_name, last_name;


-- 6c.
select film.title, sum(film_actor.actor_id) as 'Number of Actors in Film'
from film
inner join film_actor on film.film_id=film_actor.film_id
group by film.title;

-- 6d.
select film.title, sum(inventory.inventory_id) as 'Number of copies'
from film
inner join inventory on film.film_id=inventory.film_id
group by film.film_id
having title = "Hunchback Impossible";

-- 6e.
select customer.first_name, customer.last_name, sum(payment.amount) as 'Total Amount Paid'
from customer
inner join payment
on customer.customer_id = payment.customer_id
group by last_name
order by last_name;

-- 7a.
SELECT title FROM film
WHERE language_id IN
	(SELECT language_id FROM language
	WHERE name = "English")
AND (title LIKE "K%") OR (title LIKE "Q%");

-- 7b. 
select first_name, last_name from actor
where actor_id in
	(select actor_id from film_actor
    where film_id in 
		(select film_id from film
		where title = 'Alone Trip'));
        
-- 7c.
select customer.first_name, customer.last_name, customer.email, country.country from customer
left join address
on customer.address_id = address.address_id
left join city
on city.city_id = address.city_id
left join country
on country.country_id = city.country_id
where country = "Canada";

-- 7d.
select title from film
where film_id in 
	(select film_id from film_category
    where category_id in 
		(select category_id from category
        where name = 'Family'));
        
-- 7 e.
select film.title, count(rental.rental_id) as 'Number of rentals' from film
right join inventory on inventory.film_id = film.film_id
join rental on rental.inventory_id = inventory.inventory_id
group by film.title
order by count(rental.rental_id) desc;



-- 7f.
select store.store_id, sum(amount) as 'Revenue' from store
right join inventory on inventory.store_id = store.store_id
join rental on rental.inventory_id = inventory.inventory_id
left join payment on payment.rental_id = rental.rental_id
group by store_id;


-- 7g.
select store_id, city, country from store
join address on address.address_id=store.store_id
join city on city.city_id = address.city_id
join country on country.country_id = city.country_id;

-- 7h.
select category.name, sum(payment.amount) as 'Revenue by Category'
from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by name
limit 5;

-- 8a.
create view top_5_genres as 
select category.name, sum(payment.amount) as 'Revenue by Category'
from category
join film_category on film_category.category_id = category.category_id
join inventory on inventory.film_id = film_category.film_id
join rental on rental.inventory_id = inventory.inventory_id
join payment on payment.rental_id = rental.rental_id
group by name
limit 5;


-- 8b.
select * from top_5_genres;

-- 8c.
drop view top_5_genres;








        

		
    
	





















