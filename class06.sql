USE sakila;

SELECT a1.last_name, GROUP_CONCAT(a1.first_name ORDER BY a1.first_name SEPARATOR ', ') AS actors_with_same_lastname
FROM actor a1
JOIN actor a2 ON a1.last_name = a2.last_name AND a1.actor_id != a2.actor_id
GROUP BY a1.last_name
ORDER BY a1.last_name;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) = 1;

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) > 1
ORDER BY rental_count DESC;

SELECT DISTINCT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
ORDER BY a.last_name, a.first_name;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'BETRAYED REAR'
AND a.actor_id NOT IN (
    SELECT a2.actor_id
    FROM actor a2
    JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f2.title = 'CATCH AMISTAD'
)
ORDER BY a.last_name, a.first_name;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa1 ON a.actor_id = fa1.actor_id
JOIN film f1 ON fa1.film_id = f1.film_id AND f1.title = 'BETRAYED REAR'
JOIN film_actor fa2 ON a.actor_id = fa2.actor_id
JOIN film f2 ON fa2.film_id = f2.film_id AND f2.title = 'CATCH AMISTAD'
ORDER BY a.last_name, a.first_name;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT a2.actor_id
    FROM actor a2
    JOIN film_actor fa ON a2.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
)
ORDER BY a.last_name, a.first_name;
