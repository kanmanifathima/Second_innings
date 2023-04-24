use sakila;
-- 1. Write a query to display how much business, in dollars, each store brought in
SELECT 
    s.store_id, SUM(amount) AS Gross
FROM
    payment p
        INNER JOIN
    rental r ON p.rental_id = r.rental_id
        INNER JOIN
    inventory i ON i.inventory_id = r.inventory_id
        INNER JOIN
    store s ON s.store_id = i.store_id
GROUP BY s.store_id;

-- 2.Write a query to display for each store its store ID, city, and country.
SELECT 
    store_id, city, country
FROM
    store s
        INNER JOIN
    address a ON (s.address_id = a.address_id)
        INNER JOIN
    city cit ON (cit.city_id = a.city_id)
        INNER JOIN
    country ctr ON (cit.country_id = ctr.country_id);
    
-- 3. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT 
    SUM(amount) AS Revenue, c.name AS Genre
FROM
    payment p
        INNER JOIN
    rental r ON (p.rental_id = r.rental_id)
        INNER JOIN
    inventory i ON (r.inventory_id = i.inventory_id)
        INNER JOIN
    film_category f ON (i.film_id = f.film_id)
        INNER JOIN
    category c ON (f.category_id = c.category_id)
GROUP BY c.name
ORDER BY SUM(amount) DESC LIMIT 5;

-- 4.Retrieve the names of actors/actresses who have never appeared in any 'R' rated movies. Use IN/NOT IN
                
SELECT 
    a.first_name, a.last_name, f.rating
FROM
    actor a
        LEFT JOIN
    film_actor fl ON a.actor_id = fl.actor_id
        INNER JOIN
    film f ON fl.film_id = f.film_id
WHERE
    f.rating NOT IN ('R');
    
-- extra .Retrieve the names of actors/actresses who have appeared in any 'R' rated movies. Use IN/NOT IN
SELECT 
    a.first_name, a.last_name, f.rating
FROM
    actor a
        LEFT JOIN
    film_actor fl ON a.actor_id = fl.actor_id
        INNER JOIN
    film f ON fl.film_id = f.film_id
WHERE
    f.rating IN ('R');
    
-- 5. Retrieve the title of film with the most DVD copies. List title and the # of DVD copies

SELECT f.title, COUNT(*) AS num_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY i.film_id
ORDER BY num_copies DESC Limit 72;

SELECT f.title, COUNT(*) AS num_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY i.film_id
Having count(*) =8;
-- finding the number of copies

select num_copies, count(*) as temp_count from (
SELECT f.title, COUNT(*) AS num_copies
FROM film f
JOIN inventory i ON f.film_id = i.film_id
GROUP BY i.film_id
ORDER BY num_copies) dr group by dr.num_copies;

    
select count(*) as num from inventory group by film_id order by num desc;

