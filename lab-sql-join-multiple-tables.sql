-- Instructions



-- 1 Write a query to display for each store its store ID, city, and country.
use sakila; 

select s.store_id as Store_ID, c.city as City, cc.country as Country from Store as s
Join address as a on s.address_id = a.address_id
join city as c on a.city_id=c.city_id
join country as cc on c.country_id = cc.country_id
group by s.store_id;


-- 2 Write a query to display how much business, in dollars, each store brought in.
select s.store_id as Store_ID, round(sum(p.amount),2) As Business
from store as s 
join customer as c
on c.store_id=s.store_id
join  payment as p
on p.customer_id = c.customer_id
join rental as r
on p.rental_id = r.rental_id
group by s.store_id;


-- 3 What is the average running time of films by category?
-- film_category as fc film_id, category_id
-- film as f film_id, length
-- category as c category_id, name

select c.name as category_name, round(avg(f.length),2) as lenght
from film as f
join film_category as fc 
on fc.film_id = f.film_id
join category as c
on c.category_id = fc.category_id
group by c.name
order by lenght ASC;


-- 4 Which film categories are longest?
select c.name as category_name, round(avg(f.length),2) as lenght
from film as f
join film_category as fc 
on fc.film_id = f.film_id
join category as c
on c.category_id = fc.category_id
group by c.name
order by lenght DESC;

-- 5 Display the most frequently rented movies in descending order.
-- rental: rental_id, rental_date, -inventory_id 
-- inventory film_id, inventory_id 
-- film film_id, title
-- select * from rental;
-- select * from inventory;

select count(f.title) as most_rented, f.title as title from film as f
join inventory as i on i.film_id=f.film_id
join rental as r on r.inventory_id = i.inventory_id
group by f.title
order by count(f.title) DESC;


-- 6 List the top five genres in gross revenue in descending order.
-- payment - rental_id, amount
-- category category_id, name
-- film_category category_id, 
-- rental - rental_id, rental_date, inventory_id
-- join inventory as i on i.inventory_id = r.inventory_id

select c.name as genre, sum(p.amount) as revenue from payment as p
join rental as r on p.rental_id=r.rental_id
join inventory as i on i.inventory_id=r.inventory_id
join film as f on f.film_id=i.film_id
join film_category as fc on fc.film_id=f.film_id
join category as c on c.category_id=fc.category_id
group by genre
order by revenue DESC
limit 5;

-- 7 Is "Academy Dinosaur" available for rent from Store 1?

-- film film_id, title
-- inventory i.inventory_id, film_id, store_id
-- store s.store_idinventory_id
select f.title as title, s.store_id as store, i.inventory_id as Inv_id from inventory as i
join store as s on i.store_id=s.store_id
join film as f on f.film_id = i.film_id
join rental as r on r.inventory_id = i.inventory_id
where title = 'Academy Dinosaur' and s.store_id = 1 and r.return_date is not null 
group by i.inventory_id;

