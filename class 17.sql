use sakila;

#1: Create two or three queries using address table in sakila db:
SELECT address, postal_code, city.city, country.country
FROM address
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE postal_code IN ('18743', '35200', '52137');

SELECT address, postal_code, city.city, country.country
FROM address
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
WHERE postal_code NOT IN ('23564', '38975', '52137');

#1.2 measure execution time
show PROFILES;

#1.3 Then create an index for postal_code on address table.

CREATE INDEX idx_postal_code ON address (postal_code);

DROP INDEX idx_postal_code ON address;

#1.4
#La explicacion es sensilla, en la primera vez que se runean los resultados en el apartado de duracion de la consulta se observa un tiempo
#estimado de .016 sec. Pero luego de la creacion del index (que cabe aclarar que fue mas tardia que cualquier otro comando .065 sec), el tiempo se redujo
#a menos de .001 sec. Me lleva a pensar que aunque inicialmente la creacion del index es mas tardia es muy util en consultas que se lleven
#a cabo de manera segida mientras que hacerlo sin el index es util al utilizar consultas mucho mas raras.

#2

SHOW INDEXES FROM actor;
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Santiago';

SELECT actor_id, first_name, last_name FROM actor WHERE last_name = 'Pozo';

#la diferencia radica en la velocidad y cantidad de datos a analizar. mientras que al buscar por nombre analiza las 200 filas y no tiene
#y no tiene una key para filtrar se hace un poceso mucho mas largo. mientras que al analizar el apellido que cuenta con una key que 
#funciona como indice, podria buscar de manera mas rapida y eficiente cualquier dato.

#3 

EXPLAIN SELECT film_id, title, description
FROM film
WHERE description LIKE '%action%';

EXPLAIN SELECT film_id, title, description
FROM film_text
WHERE MATCH(title, description) AGAINST('action');

#de la misma forma que en el caso anterior la diferencia radica en la cantidad de filas y el uso de keys. mientras que con like se 
#analizan todas las filas y no utiliza ninguna key, al usar against que cuenta con una key y por ende lee menos columnas y mejora la velocidad
#de ejecucion