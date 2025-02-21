
--2 "Listar todas las películas con clasificación ('R')",

SELECT "title" , "rating"
FROM "film" 
WHERE "rating" = 'R';

--3 "Encontrar los actores con un ID entre 30 y 40",

SELECT "first_name" , "last_name" , "actor_id"
FROM "actor"
WHERE "actor_id" BETWEEN 30 AND 40;


--4 "Películas con idioma original y traducido iguales",

SELECT "title" , "original_language_id" 
FROM "film"
WHERE "language_id" = "original_language_id" ;


--5 "Ordenar las películas por duración",

SELECT "title" as "Nombre_Pelicula" , "length" as "Duracion"
FROM "film" 
ORDER BY "length" asc ;


--6 "Actores con "Allen" en su apellido",

SELECT "first_name" , "last_name"
FROM "actor" 
WHERE "last_name" like '%ALLEN%' ;


--7 "Cantidad de películas por clasificación",

SELECT "rating" as "clasificacion" , count(*) as "total_peliculas"
FROM "film"
GROUP BY "rating" ;


--8 "Películas con clasificación "PG-13" o duración mayor a 3 horas",

SELECT "title" as "Titulo" , "rating" as "clasificacion" , "length" as "duracion"
FROM "film"
WHERE "rating" = 'PG-13' or "length" > 180
ORDER BY "length" desc ;


--9 "Variabilidad del costo de reemplazo de las películas",

SELECT round(variance ("replacement_cost"),2)  as "Costo_Reemplazo"
FROM "film" ;


--10 "Mayor y menor duración de película",

SELECT min ("length") as "Menor_duracion" , max ("length") as "Mayor_duracion"
FROM "film" ;


--11 "Costo del antepenúltimo alquiler",
 
SELECT "amount" as "cantidad", rental."rental_date" as "fecha_alquiler"
FROM "payment"
JOIN "rental" on payment."rental_id" = rental."rental_id"
ORDER BY rental."rental_date" desc
LIMIT 1 OFFSET 3 ;


--12 "Películas sin clasificación ("NC-17" ni "G")",

SELECT "title" as "Pelicula", "rating" as "clasificacion"
FROM "film"
WHERE "rating" not in ('NC-17' , 'G') 
ORDER BY "rating" asc ;


--13 "Promedio de duración de películas por clasificación",

SELECT  "rating" as clasificacion , round(avg ("length"),0) as "promedio_duracion"
FROM "film"
GROUP BY "rating" ;
 

--14 "Películas con más de 180 minutos de duración",

SELECT "title" as "Peliculas", "length" as "duracion"
FROM "film"
WHERE "length" > 180 
ORDER BY "length" asc ;

--15 "Dinero total generado por la empresa",

SELECT sum ("amount") as "Total_dinero_generado"
FROM "payment" ;

--16 "Top 10 clientes con el ID más alto",

SELECT "customer_id" , concat("first_name" , ' ' , "last_name") as "nombre_clinete"
FROM "customer" 
ORDER BY customer_id desc 
LIMIT 10;

--17 "Actores en la película ('Egg Igby')",

SELECT "first_name" as "nombre" , "last_name" as "apellido" , "title" as "pelicula"
FROM actor a 
JOIN "film_actor" on a."actor_id"  = film_actor."actor_id" 
JOIN film f on film_actor."film_id"  = f."film_id" 
WHERE f.title = 'EGG IGBY' ;

--18 "Películas con nombres únicos",

SELECT distinct "title" as "Nombre_Peliculas"
FROM "film"
ORDER BY "title" ;

--19 "Películas de comedia con más de 180 minutos de duración",

SELECT f."title" as "nombre_pelicula" , c."name" as "genero" , "length" as "duracion" 
FROM "film" f
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Comedy' AND f."length" > 180;

--20 "Categorías con duración promedio mayor a 110 minutos",

SELECT "title" as "pelicula" , c."name" as "Categoria" , round(avg("length"),0) as "promedio_duracion" 
FROM "film"
JOIN "film_category" fc on film."film_id" = fc."film_id" 
JOIN "category" c  on fc."category_id" = c."category_id"
GROUP BY c."name" , film."title" 
HAVING avg("length") > 110
ORDER BY avg("length") asc ;


--21 "Duración media del alquiler de películas",

SELECT round(avg("rental_duration"),0) as "promedio_duracion_alquiler"
FROM "film" ;


--22 "Concatenar nombre y apellido de los actores",

SELECT concat ("first_name" , ' ' , "last_name") as "Nombres_actores"
FROM "actor";


--23 "Cantidad de alquileres por día (ordenados de mayor a menor)",

SELECT date("rental_date") as "dia_alquiler" , count("rental_id") as "cantidad_alquiler"
FROM "rental"
GROUP BY date("rental_date")
ORDER BY cantidad_alquiler desc ;


--24 "Películas con duración superior al promedio",

SELECT "title" as "Peliculas" , "length" as "duracion"
FROM "film"
WHERE "length" > (SELECT avg("length") 
                  FROM "film") ;

--25 "Número de alquileres por mes",

SELECT date_trunc('month' , "rental_date") as "mes_alquiler" , count("rental_id") as "cantidad"
FROM "rental" 
group by "mes_alquiler" 
order by "mes_alquiler" desc ;


--26 "Promedio, desviación estándar y varianza del total pagado",

SELECT round(avg("amount"),2) as "promedio_pagado" , round(stddev("amount"),2) as "desviacion_estandar_totalPagado" , round(variance("amount"),2) as "varianza_totalPagado"
FROM "payment" ;


--27 "Películas alquiladas por encima del precio medio",

SELECT "title" as "Pelicula" , "rental_rate" as "precio_promedio"
FROM "film"
WHERE "rental_rate" > (SELECT avg("rental_rate")
                       FROM "film" )
ORDER BY "rental_rate" desc ;


--28 "Actores con más de 40 películas",

SELECT "actor_id", count(film_id) as "total_peliculas"
FROM "film_actor"
GROUP BY "actor_id"
HAVING count("film_id") > 40
ORDER BY "total_peliculas" desc ;

--29 "Películas y su disponibilidad en inventario",

SELECT f."title" as "pelicula" ,
       count(i."inventory_id") as "cantidad_disponible"
FROM "film" f
LEFT JOIN "inventory" i on f."film_id" = i."film_id"
GROUP BY f."title"
ORDER BY "cantidad_disponible" desc;


--30 "Número de películas por acto",

SELECT actor."actor_id" , concat("first_name" , ' ' , "last_name") as "nombre_completo" , count("film_id") as "total_peliculas"
FROM "actor"
JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
GROUP BY actor."actor_id" , "nombre_completo" 
ORDER BY "total_peliculas" desc ;


--31 "Películas y sus actores, incluyendo aquellas sin actores registrados",

SELECT "title" as "pelicula" , (SELECT STRING_AGG(actor."first_name" || ' ' || actor."last_name" , ', ')
  FROM "film_actor"
  JOIN "actor" on film_actor."actor_id" = actor."actor_id"
  WHERE film_actor."film_id" = film."film_id") as "actores"
FROM "film"
ORDER BY "pelicula" ;


--32 "Actores y las películas en las que han participado, incluso sin registros",

SELECT actor."actor_id" , concat(actor."first_name" , ' ' , actor."last_name") as "nombre_actor" ,
(SELECT STRING_AGG(film."title" ,', ')
 FROM "film_actor"
 JOIN "film" on film_actor."film_id" = film."film_id"
 WHERE film_actor."actor_id" = actor."actor_id" ) as "peliculas"
FROM "actor"
ORDER BY "nombre_actor" asc ;


--33 T"odas las películas y sus registros de alquiler",

SELECT film."film_id" , "title" as "peliculas" , "rental_id" , "rental_date" as "fecha_alquiler" , "return_date" as "fecha_devolucion" , "customer_id" 
FROM "film"
LEFT JOIN "inventory" i on film."film_id" = i."film_id"
LEFT JOIN "rental" on i."inventory_id" = rental."inventory_id"
ORDER BY "title" , "return_date" ;


--34 "Top 5 clientes con mayor gasto",

SELECT customer."customer_id" , concat("first_name" , ' ' , "last_name") as "nombre_cliente" , sum(payment."amount") as "total_gastado"
FROM "customer"
JOIN "payment" on customer."customer_id" = payment."payment_id"
GROUP BY customer."customer_id" , "nombre_cliente"
ORDER BY "total_gastado" desc
LIMIT 5;


--35 "Actores con el nombre ('JOHNNY')",
SELECT "actor_id" , "first_name" as "nombre" , "last_name" as "apellido"
FROM "actor"
WHERE "first_name" = 'JOHNNY' ;


--36 "Renombrar columnas de actores",

SELECT "first_name" as "nombre" , "last_name" as "apellido"
FROM "actor" ;


--37 "Actor con el ID más bajo y más alto",

SELECT min("actor_id") as "id_mas_bajo" , max("actor_id") as "id_mas_alto"
FROM "actor" ;


--38 "Cantidad total de actores",

SELECT count(*) as "total_actores"
FROM "actor" ;


--39 "Ordenar actores por apellido",

SELECT "actor_id" , "first_name" as "nombre" , "last_name" as "apellido"
FROM "actor"
ORDER BY "apellido" asc ;


--40 "Primeras 5 películas registradas",

SELECT "film_id" , "title" as "pelicula"
FROM "film"
ORDER BY "pelicula" asc
LIMIT 5;


--41 "Actores con el mismo nombre y el más repetido",

SELECT "first_name" as "nombre" , count(*) as "total_actores"
FROM "actor"
GROUP BY "nombre"
ORDER BY "total_actores" desc;


--42 "Clientes y sus alquileres",

SELECT "rental_id" , "rental_date" as "dia_alquiler" , customer."customer_id" , "first_name" as "nombre" , "last_name" as "apellido"
FROM "rental"
JOIN "customer" on rental."customer_id" = customer."customer_id"
ORDER BY "rental_date" ;


--43 "Clientes y sus alquileres (incluyendo los que no han alquilado)",

SELECT customer."customer_id" , concat("first_name" , ' ' , "last_name") as "nombre_cliente" , "rental_id" , "rental_date"
FROM "customer"
LEFT JOIN "rental" on customer."customer_id" = rental."customer_id"
ORDER BY customer."customer_id" , rental."rental_id" ; 


--44 "CROSS JOIN entre películas y categorías",

SELECT "title" as "pelicula" , category."name" as "categoria"
FROM "film"
CROSS JOIN "category"
ORDER BY "pelicula" , "categoria" ;

--R/ ¿aporta valor esta consulta? NO, porque se estan mezclando todas las peliculas con categorias, incluso cuando no tienen relacion entre si, no se ve ve la conexion o relacion real entre las peliculas y categorias, y esta relacion deberia hacerse entre las tablas film y film.category.


--45 "Actores en películas de la categoría ('Action')",

SELECT actor."actor_id" , concat("first_name" , ' ' , "last_name") as "nombre_actor" , category."name" as "categotia"
FROM "actor"
JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
JOIN "film_category" on film_actor."film_id" = film_category."film_id"
JOIN "category" on film_category."category_id" = category."category_id"
WHERE category."name" = 'Action'
ORDER BY "nombre_actor" ;


--46 "Actores sin participación en ninguna película",

SELECT actor."actor_id" , concat("first_name" , ' ' , "last_name") as "nombre_actor"
FROM "actor"
LEFT JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
WHERE film_actor."film_id" is null
ORDER BY "nombre_actor" ;


--47 "Actores y cantidad de películas en las que han participado",

SELECT concat(actor."first_name" , ' ' ,actor."last_name") as "nombre_actor" , count(film_actor."film_id") as "total_peliculas"
FROM "actor"
JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
GROUP BY actor."actor_id" , "nombre_actor"
ORDER BY "total_peliculas" desc ;


--48 "Crear una vista con los actores y su cantidad de películas",

create view "actor_num_peliculas" as
SELECT concat(actor."first_name" , ' ' ,actor."last_name") as "nombre_actor" , count(film_actor."film_id") as "total_peliculas"
FROM "actor"
JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
GROUP BY actor."actor_id" , "nombre_actor"
ORDER BY "total_peliculas" desc ;


--49 "Total de alquileres por cliente",

SELECT customer."customer_id" , concat("first_name" , ' ' , "last_name") as "Cliente" , count("rental_id") as "total_alquileres"
FROM "customer"
LEFT JOIN "rental" on customer."customer_id" = rental."customer_id"
GROUP BY customer."customer_id" , "Cliente"
order BY "total_alquileres" desc;

--50 "Duración total de las películas de ('Action')",

SELECT sum(film."length") as "duracion_total" , category."name" as "Categoria"
FROM "film"
JOIN film_category on film."film_id" = film_category."film_id"
JOIN "category" on film_category."category_id" = category."category_id"
WHERE category."name" = 'Action'
GROUP BY category."name" ;


--51 "Crear tabla temporal con total de alquileres por cliente",

create temporary table "cliente_rentas_temporal" as
SELECT customer."customer_id" , concat (customer."first_name" , ' ' , customer."last_name") as "cliente" , count(rental."rental_id") as "total_peliculas"
FROM "customer"
LEFT JOIN "rental" on customer."customer_id" = rental."customer_id"
GROUP BY customer."customer_id" , "cliente"
ORDER BY "total_peliculas" desc ;

SELECT *
FROM "cliente_rentas_temporal" ;


--52 "Crear tabla temporal con películas alquiladas al menos 10 veces",

create temporary table "peliculas_alquiladas" as
SELECT film."film_id" , film."title" as "pelicula" , count(rental."rental_id") as "total_peliculas"
FROM "film"
JOIN "inventory" on film."film_id" = inventory."film_id"
JOIN "rental" on inventory."inventory_id" = rental."inventory_id"
GROUP BY film."film_id" , "pelicula"
HAVING count (rental."rental_id") >= 10;

SELECT *
FROM "peliculas_alquiladas" ;

--53 "Películas alquiladas por "Tammy Sanders" y no devueltas",

SELECT concat(customer."first_name" , ' ' , customer."last_name") as "cliente" ,
film."title" as peliculas , rental."rental_date" as fecha_alquiler , rental."return_date" as fecha_retorno
FROM "rental"
JOIN "inventory" on rental."inventory_id" = inventory."inventory_id"
JOIN "film" on inventory."film_id" = film."film_id"
JOIN "customer" on rental."customer_id" = customer."customer_id"
WHERE customer."first_name" = 'TAMMY' and customer."last_name" = 'SANDERS' and rental."return_date" is null
ORDER BY film."title" ;


--54 "Actores en películas de ('Sci-Fi')",

SELECT actor."first_name" as "nombre" , actor."last_name" as "apellido" , category."name" as "categoria"
FROM "actor"
JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
JOIN "film" on film_actor."film_id" = film."film_id"
JOIN "film_category" on film."film_id" = film_category."film_id"
JOIN "category" on film_category."category_id" = category."category_id"
WHERE category."name" = 'Sci-Fi'
ORDER BY actor."last_name" ;


--55 "Actores en películas alquiladas después de ('Spartacus Cheaper')",

SELECT distinct actor."first_name" as "nombre", actor."last_name" as "apellido" , film."title" as pelicula , rental."rental_date" as "fecha_alquiler"
FROM "actor"
JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
JOIN "film" on film_actor."film_id" = film."film_id"
JOIN "inventory" on film."film_id" = inventory."film_id"
JOIN "rental" on inventory."inventory_id" = rental."inventory_id"
WHERE rental."rental_date" > (
     SELECT min(rental."rental_date") 
     FROM "rental"
     JOIN "inventory" on rental."inventory_id" = inventory."inventory_id" 
     JOIN "film" on inventory."film_id" = film."film_id"
     WHERE film."title" ='SPARTACUS CHEAPER'
)
order by actor."last_name" , actor."first_name" ;


--56 "Actores que no han trabajado en películas de ('Music')",

SELECT distinct  actor."first_name" , actor."last_name" , category."name" as "categoria_Music"
FROM actor
LEFT JOIN "film_actor" on actor."actor_id" = film_actor."actor_id"
LEFT JOIN "film_category" on film_actor."film_id" = film_category."film_id"
LEFT JOIN "category" on film_category."category_id" = category."category_id" and category."name" = 'Music'
WHERE actor."actor_id" not in (
    SELECT film_actor."actor_id"
    FROM "film_actor"
    JOIN "film_category" fc on film_actor."film_id" = film_category."film_id"
    JOIN "category" on film_category."category_id" = category."category_id"
    WHERE category."name" = 'Music'
)
ORDER BY actor."last_name" , actor."first_name" ;


--57 "Películas alquiladas por más de 8 días",

SELECT distinct film."title" as "pelicula" , (rental."return_date" - rental."rental_date") as "dias_alquilados"
FROM "rental"
JOIN "inventory" on rental."inventory_id" = inventory."inventory_id"
JOIN "film" on inventory."film_id" = film."film_id"
WHERE (rental."return_date" - rental."rental_date") > interval '8 days'
ORDER BY "dias_alquilados" desc, film."title" ;


--58 "Películas de la misma categoría que ('Animation')",

SELECT film."title" as "pelicula" , category."name" as "categoria"
FROM "film"
JOIN "film_category" on film."film_id" = film_category."film_id"
JOIN "category" on film_category."category_id" = category."category_id"
WHERE category."name" = 'Animation' ;


--59 "Películas con la misma duración que ('Dancing Fever')",

SELECT film."title" as "pelicula" , film."length" as "duracion"
FROM "film"
WHERE "length" = (
  SELECT "length" 
  FROM "film"
  WHERE film."title" = 'DANCING FEVER'
)
ORDER BY film."title" ;


--60 "Clientes que han alquilado al menos 7 películas distintas",

SELECT c."first_name", c."last_name", COUNT(DISTINCT f."film_id") as "total_peliculas_alquiladas",
       STRING_AGG(DISTINCT f."title", ', ') as peliculas_alquiladas
FROM "customer" c
JOIN "rental" r on c."customer_id" = r."customer_id"
JOIN "inventory" i on r."inventory_id" = i."inventory_id"
JOIN "film" f on i."film_id" = f."film_id"
GROUP BY c."customer_id", c."first_name", c."last_name"
HAVING COUNT(DISTINCT f."film_id") >= 7
ORDER BY c."last_name" asc;



--61 "Total de películas alquiladas por categoría",

SELECT category."name" as "categoria" , count(rental."rental_id") as "total_peliculas"
FROM "category"
JOIN "film_category" on category."category_id" = film_category."category_id"
JOIN "inventory" on film_category."film_id" = inventory."film_id"
JOIN "rental" on inventory."inventory_id" = rental."inventory_id"
GROUP BY category."category_id" , category."name"
ORDER BY "total_peliculas" desc;


--62  "Número de películas por categoría estrenadas en 2006",

SELECT category."name" as "categoria" , count(film."film_id") as "total_peliculas" , film."release_year"
FROM "category"
JOIN "film_category" on category."category_id" = film_category."category_id"
JOIN "film" on film_category."film_id" = film."film_id"
WHERE film."release_year" = 2006
GROUP BY category."category_id" , category."name" , film."release_year"
ORDER BY "total_peliculas" desc ;


--63 "Combinaciones entre trabajadores y tiendas",

SELECT  staff."staff_id" , concat(staff."first_name" , ' ' , staff."last_name") as "trabajador" , store."store_id" as "tienda"
FROM "staff"
CROSS JOIN "store"
ORDER BY staff."staff_id" , "tienda" ;


--64 "Cantidad total de películas alquiladas por cada cliente",

SELECT customer."customer_id" , concat(customer."first_name" , ' ' , customer."last_name") as "cliente" , count(rental."rental_id") as "total_peliculas_alquiladas"
FROM "customer"
LEFT JOIN "rental" on customer."customer_id" = rental."customer_id"
GROUP BY customer."customer_id" , "cliente"
ORDER BY "total_peliculas_alquiladas" desc ;


