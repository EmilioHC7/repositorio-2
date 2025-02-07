README.md

# Proyecto de Base de Datos de Películas

Este proyecto contiene una serie de consultas SQL realizadas sobre una base de datos de películas. A continuación, se describe el contenido del archivo `.sql` y las consultas que se han realizado.

## Descripción del Archivo SQL

El archivo `modulo4_BBDD_proyecto.sql` contiene varias consultas SQL que realizan operaciones sobre una base de datos de películas. Las consultas incluyen:


--2 Nombre de todas las peliculas con una clasificacion por edades en R
SELECT "title" , "rating"
FROM "film" 
where "rating" = 'R'


--3 Nombres de los actores que tengan un (actor_id) entre 30 y 40
select "first_name" , "last_name" , "actor_id"
from "actor"
where "actor_id" between 30 and 40;


--4 Peliculas cuyo idioma coincide con el idioma original
select "title" , "original_language_id" 
from "film"
where "language_id" = "original_language_id" ;


--5 Peliculas por duracion de forma ascendente
select "title" as Nombre_Pelicula , "length" as Duracion
from "film" 
order by "length" asc ;


--6 Nombre y apeliido de los actores que tengan (Allen) en su apellido
select "first_name" , "last_name"
from "actor" 
where "last_name" = 'ALLEN' ;


--7 Cantidad de peliculas en cada clasificacion de la tabla (film) y clasificacion junto con e recuento
select "rating" as "clasificacion" , count(*) as "total_peliculas"
from "film"
group by "rating" ;


--8 Titulo de todas las peliculas que son(PG-13) o tienen una duracion mayor de 3 horas en la tabla film
select "title" as "Titulo" , "rating" as "clasificacion" , "length" as "duracion"
from "film"
where "rating" = 'PG-13' or "length" > 180
order by "length" desc ;


--9 Encuentra la variabilidad de lo que costaria reemplazar las peliculas
select variance ("replacement_cost")  as Costo_Reemplazo
from "film" ;


--10 Mayor y menor duracion de una pelicula de la BBDD
select min ("length") as Menor_duracion , max ("length") as Mayor_duracion
from "film" ;


--11 Encuentra lo que costo el antepenultimo alquiler ordenado por dia 
select "amount" as cantidad, rental."rental_date" as fecha_alquiler
from "payment"
join "rental" on payment."rental_id" = rental."rental_id"
order by rental."rental_date" desc
limit 1 offset 3 ;


--12 Titulo de las peliculas en la tabla (film) que no sean (NG-17) ni (G) en cuanto a su clasificiacion
select "title" as Pelicula, "rating" as clasificacion
from "film"
where "rating" not in ('NC-17' , 'G') 
order by "rating" asc ;


--13 Promedio de duracion de las peliculas para cada clasificacion de la tabla (film) y muestra la clasificacion junto con el promedio de duracion
select  "rating" as clasificacion , avg ("length") as promedio_duracion
from "film"
group by "rating" ;


--14 Titulo de todas las peliculas que tengan una duracion mayor a 180 minutos
select "title" as Peliculas, "length" as duracion
from "film"
where "length" > 180 
order by "length" asc ;

--15 Cuanto dinero a generado en total la empresa
select sum ("amount") as Total_dinero_generado
from "payment" ;

--16 10 clientes con mayor valor de id
select "customer_id" , concat("first_name" , ' ' , "last_name") as nombre_clinete
from "customer" 
order by customer_id desc 
limit 10;

--17 Encuentra el nombre y apellido de los actores que aparecen en la pelicula con titulo (Edd lgby)
select "first_name" as nombre , "last_name" as apellido , "title" as pelicula
from actor a 
join "film_actor" on a.actor_id  = film_actor.actor_id 
join film f on film_actor.film_id  = f.film_id 
where f.title = 'EGG IGBY' ;

--18 Selecciona todos los nombres de las peliculas unicas
select distinct "title" as Nombre_Peliculas
from "film"
order by "title" ;

--19 Encuentra el titulo de las peliculas que son comedias y tienen una duracion mayor a 180 minutos en la tabla (film)
SELECT f."title" as nombre_pelicula , c."name" as genero , "length" as duracion 
FROM "film" f
JOIN "film_category" fc ON f."film_id" = fc."film_id"
JOIN "category" c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Comedy' AND f."length" > 180;

--20 Encuentra las categorias de peliculas que tienen un promedio de duracion superior a 110 min y muestra el nombre de la categoria junto con el promedio de duracion
select "title" as pelicula , c."name" as Categoria , avg("length") as promedio_duracion 
from "film"
join "film_category" fc on film."film_id" = fc."film_id" 
join "category" c  on fc."category_id" = c."category_id"
group by c."name" , film.title 
having avg("length") > 110
order by avg("length") asc ;


--21 Cual es la media de duracion del alquiler de las peliculas
select avg("rental_duration") as promedio_duracion_alquiler
from "film" ;


--22 Crea una columna con el nombre y apellidos de todos los actores y actrices
select concat ("first_name" , ' ' , "last_name") as Nombres_actores
from "actor";


--23 Numeros de alquiler por dia, ordenados por cantidad de alquiler de forma decendente
select "rental_date" as dia_alquiler , count("rental_id") as cantidad_alquiler
from "rental"
group by "dia_alquiler"
order by cantidad_alquiler desc ;

--24 Encuentra las peliculas con una duracion superior al promedio
select "title" as Peliculas , "length" as duracion
from "film"
where "length" > (select avg("length") 
                  from "film") ;

--25 Averigua el numero de alquileres registrados por mes
select date_trunc('month' , "rental_date") as mes_alquiler , count("rental_id") as cantidad
from "rental" 
group by "mes_alquiler" 
order by mes_alquiler desc ;


--26 Encuentra el promedio, la desvicacion estandar y varianza del total pagado
select avg("amount") as promedio_pagado , stddev("amount") as desviacion_estandar_totalPagado , variance("amount") as varianza_totalPagado
from "payment" ;


--27 Que peliculas se alquilan por encima del precio medio
select "title" as Pelicula , "rental_rate" as precio_promedio
from "film"
where "rental_rate" > (select avg("rental_rate")
                       from "film" )
order by "rental_rate" desc ;


--28 Muestra el id de los actores que hayan participado en mas de 40 peliculas
select "actor_id", count(film_id) as total_peliculas
from "film_actor"
group by "actor_id"
having count(film_id) > 40
order by total_peliculas desc ;

--29 Obtener todas las peliculas y, si estan disponibles en el inventario mostrar la cantidad disponible
select f.title as pelicula ,
       count(i.inventory_id) as cantidad_disponible
from film f
left join inventory i ON f.film_id = i.film_id
group by f.title
order by cantidad_disponible desc;


--30 Obtener los actores y el numero de peliculas en las que ha actuado
select actor."actor_id" , concat("first_name" , ' ' , "last_name") as nombre_completo , count("film_id") as total_peliculas
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
group by actor."actor_id" , "nombre_completo" 
order by total_peliculas desc ;


--31 Obtener todos las peliculas y mostrar las actores que han actuado en ellas, incluso si algunas peliculas no tienen actores asociados
select "title" as pelicula , (select STRING_AGG(actor."first_name" || ' ' || actor."last_name" , ', ')
  from "film_actor"
  join "actor" on film_actor."actor_id" = actor."actor_id"
  where film_actor."film_id" = film."film_id") as actores
from "film"
order by pelicula ;


--32 Obtener todos los actores y mostrar las peliculas en las que han actuado, incluso si algunos actores no han actuado en ninguna pelicula
select actor."actor_id" , concat(actor."first_name" , ' ' , actor."last_name") as nombre_actor ,
(select STRING_AGG(film."title" ,', ')
 from "film_actor"
 join "film" on film_actor."film_id" = film."film_id"
 where film_actor."actor_id" = actor."actor_id" ) as peliculas
from "actor"
order by nombre_actor asc ;


--33 Obtener todas las peliculas que tenemos y todos los registros de alquiler
select film."film_id" , "title" as peliculas , "rental_id" , "rental_date" as fecha_alquiler , "return_date" as fecha_devolucion , "customer_id" 
from "film"
left join "inventory" i on film."film_id" = i."film_id"
left join "rental" on i."inventory_id" = rental."inventory_id"
order by "title" , "return_date" ;


--34 Encuentra los 5 clientes que mas dinero se hayan gastado con nosotros
select customer."customer_id" , concat ("first_name" , ' ' , "last_name") as nombre_cliente , sum(payment."amount") as total_gastado
from "customer"
join "payment" on customer."customer_id" = payment."payment_id"
group by customer."customer_id" , "nombre_cliente"
order by "total_gastado" desc
limit 5;


--35 Selecciona todos los actores cuyo primer nombre es (JOHNNY)
select "actor_id" , "first_name" as nombre , "last_name" as apellido
from "actor"
where "first_name" = 'JOHNNY' ;


--36 Renombra la columna (first_name) como nombre y (last_name) como apellido
select "first_name" as nombre , "last_name" as apellido
from "actor" ;


--37 Encuentra el ID del actor mas bajo y mas alto en la tabla actor
select min("actor_id") as id_mas_bajo , max("actor_id") as id_mas_alto
from "actor" ;


--38 Cuenta cuantos actores hay en la tabla "actor"
select count(*) as total_actores
from "actor" ;


--39 Selecciona todos los actores y ordenalos por apellido en orden ascendente
select "actor_id" , "first_name" as nombre , "last_name" as apellido
from "actor"
order by "apellido" asc ;


--40 Selecciona las primeras 5 peliculas de la tabla (film)
select "film_id" , "title" as pelicula
from "film"
order by "pelicula" asc
limit 5;


--41 Agrupa los actores por su nombre y cuenta cuantos actores tienen el mismo nombre ¿cual es el nombre mas repetido?
select "first_name" as nombre , count(*) as total_actores
from "actor"
group by "nombre"
order by "total_actores" desc
limit 1;


--42 Encuentra todos los alquileres y los nombres de los clientes que los realizaron
select "rental_id" , "rental_date" as dia_alquiler , customer."customer_id" , "first_name" as nombre , "last_name" as apellido
from "rental"
join "customer" on rental."customer_id" = customer."customer_id"
order by "rental_date" ;


--43 Muestra todos los clientes y sus alquileres si existen , incluyendo aquellos que no tienen alquileres
select customer."customer_id" , concat("first_name" , ' ' , "last_name") as nombre_cliente , "rental_id" , "rental_date"
from "customer"
left join "rental" on customer."customer_id" = rental."customer_id"
order by customer."customer_id" , rental."rental_id" ; 


--44 Realiza un CROSS JOIN entre las tablas film y category ¿aporta valor esta conulta? ¿por que?, deja despues de la consulta la contestacion
select "title" as pelicula , category."name" as categoria
from "film"
cross join "category"
order by "pelicula" , "categoria" ;

--R/ ¿aporta valor esta consulta? NO, porque se estan mezclando todas las peliculas con categorias, incluso cuando no tienen relacion entre si, no se ve ve la conexion o relacion real entre las peliculas y categorias, y esta relacion deberia hacerse entre las tablas film y film.category.


--45 Encuentra los actores que han participado en peliculas de la categoria accion
select actor."actor_id" , concat("first_name" , ' ' , "last_name") as nombre_actor , category."name" as categotia
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
join "film_category" on film_actor."film_id" = film_category."film_id"
join "category" on film_category."category_id" = category."category_id"
where category."name" = 'Action'
order by nombre_actor ;


--46 Encuentra todos los actores que no han participado en peliculas
select actor."actor_id" , concat("first_name" , ' ' , "last_name") as nombre_actor
from "actor"
left join "film_actor" on actor."actor_id" = film_actor."actor_id"
where film_actor."film_id" is null
order by nombre_actor ;


--47 Selecciona el nombre de los actores y la cantidad de peliculas en las que han participado
select concat(actor."first_name" , ' ' ,actor."last_name") as nombre_actor , count(film_actor."film_id") as total_peliculas
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
group by actor."actor_id" , "nombre_actor"
order by total_peliculas desc ;


--48 Crea una vista llamada (actor_num_peliculas) que muestre los nombres de los actores y el numero de peliculas en las que han participado
create view "actor_num_peliculas" as
select concat(actor."first_name" , ' ' ,actor."last_name") as nombre_actor , count(film_actor."film_id") as total_peliculas
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
group by actor."actor_id" , "nombre_actor"
order by total_peliculas desc ;


--49 Calcula el numero total de aquileres realizados por cada cliente
select customer."customer_id" , concat("first_name" , ' ' , "last_name") as Cliente , count("rental_id") as total_alquileres
from "customer"
left join "rental" on customer."customer_id" = rental."customer_id"
group by customer."customer_id" , cliente 
order by total_alquileres desc;


--50 Calcula la duracion total de las peliculas en la categoria 'Action'
select sum(film."length") as duracion_total , category."name" as Categoria
from "film"
join film_category on film."film_id" = film_category."film_id"
join "category" on film_category."category_id" = category."category_id"
where category."name" = 'Action'
group by category."name" ;


--51 Crea una tabla temporal llamada (cliente_rentas_temporal) para almacenar el total de alquileres por cliente
create temporary table "cliente_rentas_temporal" as
select customer."customer_id" , concat (customer."first_name" , ' ' , customer."last_name") as cliente , count(rental."rental_id") as total_peliculas
from "customer"
left join "rental" on customer."customer_id" = rental."customer_id"
group by customer."customer_id" , "cliente"
order by total_peliculas desc ;

select *
from "cliente_rentas_temporal" ;


--52 Crea una tabal temporal llamada (peliculas_alquiladas) que almacene las peliculas que han sido alquiladas al menos 10 veces
create temporary table "peliculas_alquiladas" as
select film."film_id" , film."title" as pelicula , count(rental."rental_id") as total_peliculas
from "film"
join "inventory" on film."film_id" = inventory."film_id"
join "rental" on inventory."inventory_id" = rental."inventory_id"
group by film."film_id" , "pelicula"
having count (rental."rental_id") >= 10;

select *
from "peliculas_alquiladas" ;

--53 Encuentra el titulo de las peliculas que han sido alquiladas por el cliente con nombre (Tammy Sanders) y que aun no se han devuelto. Ordena los resultados alfabeticamente por titulo de pelicula
select concat(customer."first_name" , ' ' , customer."last_name") as cliente ,
film."title" as peliculas , rental."rental_date" as fecha_alquiler , rental."return_date" as fecha_retorno
from "rental"
join "inventory" on rental."inventory_id" = inventory."inventory_id"
join "film" on inventory."film_id" = film."film_id"
join "customer" on rental."customer_id" = customer."customer_id"
where customer."first_name" = 'TAMMY' and customer."last_name" = 'SANDERS' and rental."return_date" is null
order by film."title" ;


--54 Encuentra los nombres de los actores que han actuado en almenos una pelicula que pertenece a la categoria (Sci-Fi). Ordena los resultados alfabeticamente por apellido
select actor."first_name" as nombre , actor."last_name" as apellido , category."name" as categoria
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
join "film" on film_actor."film_id" = film."film_id"
join "film_category" on film."film_id" = film_category."film_id"
join "category" on film_category."category_id" = category."category_id"
where category."name" = 'Sci-Fi'
order by actor."last_name" ;


--55 Encuentra el nombre y apellido de los actores que han actuado en peliculas que se alquilaron despues de que la pelicula (Spartacus Cheaper) se alquilara por primera vez. Ordena los resultados alfabeticamente por apellido
select distinct actor."first_name" as nombre, actor."last_name" as apellido , film."title" as pelicula , rental."rental_date" as fecha_alquiler
from "actor"
join "film_actor" on actor."actor_id" = film_actor."actor_id"
join "film" on film_actor."film_id" = film."film_id"
join "inventory" on film."film_id" = inventory."film_id"
join "rental" on inventory."inventory_id" = rental."inventory_id"
where rental."rental_date" > (
     select min(rental."rental_date") 
     from "rental"
     join "inventory" on rental."inventory_id" = inventory."inventory_id" 
     join "film" on inventory."film_id" = film."film_id"
     where film."title" ='SPARTACUS CHEAPER'
)
order by actor."last_name" , actor."first_name" ;


--56 Encuentra el nombre y apellido de los actores que no han actuado en ninguna pelicula de la categoria 'Music'
select distinct  actor."first_name" , actor."last_name" , category."name" as categoria_Music
from "actor"
left join "film_actor" on actor."actor_id" = film_actor."actor_id"
left join "film_category" on film_actor."film_id" = film_category."film_id"
left join "category" on film_category."category_id" = category."category_id" and category."name" = 'Music'
where actor."actor_id" not in (
    select film_actor."actor_id"
    from "film_actor"
    join film_category fc on film_actor."film_id" = film_category."film_id"
    join category on film_category."category_id" = category."category_id"
    where category."name" = 'Music'
)
ORDER BY actor."last_name" , actor."first_name" ;


--57 Encuentra el titulo de todas las peliculas que fueron alquiladas por mas de 8 dias
select distinct film."title" as pelicula , (rental."return_date" - rental."rental_date") as dias_alquilados
from "rental"
join "inventory" on rental."inventory_id" = inventory."inventory_id"
join "film" on inventory."film_id" = film."film_id"
where (rental."return_date" - rental."rental_date") > interval '8 days'
order by dias_alquilados desc, film."title" ;


--58 Encuentra el titulo de todas las peliculas que son de las misma categoria que (Animation)
select film."title" as pelicula , category."name" as categoria
from "film"
join "film_category" on film."film_id" = film_category."film_id"
join "category" on film_category."category_id" = category."category_id"
where category."name" = 'Animation' ;


--59 Encuentra los nombres de las películas que tienen la misma duración que la película con el título (Dancing Fever). Ordena los resultados alfabéticamente por título de película.
select film."title" as pelicula , film."length" as duracion
from "film"
where "length" = (
  select "length" 
  from "film"
  where film."title" = 'DANCING FEVER'
)
order by film."title" ;


--60 Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
select customer."first_name" as nombre , customer."last_name"as apellido , count(inventory."film_id") as total_peliculas
from "customer"
join "rental" on customer."customer_id" = rental."customer_id"
join "inventory" on rental."inventory_id" = inventory."inventory_id"
group by customer."customer_id" , customer."first_name" , customer."last_name"
having count(inventory."film_id") >= 7
order by customer."last_name" , customer."first_name" ;


--61 Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select category."name" as categoria , count(rental."rental_id") as total_peliculas
from "category"
join "film_category" on category."category_id" = film_category."category_id"
join "inventory" on film_category."film_id" = inventory."film_id"
join "rental" on inventory."inventory_id" = rental."inventory_id"
group by category."category_id" , category."name"
order by total_peliculas desc;


--62  Encuentra el número de películas por categoría estrenadas en 2006.
select category."name" as categoria , count(film."film_id") as total_peliculas , film."release_year"
from "category"
join "film_category" on category."category_id" = film_category."category_id"
join "film" on film_category."film_id" = film."film_id"
where film."release_year" = 2006
group by category."category_id" , category."name" , film."release_year"
order by total_peliculas desc ;


--63 Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select  staff."staff_id" , concat(staff."first_name" , ' ' , staff."last_name") as trabajador , store."store_id" as tienda
from "staff"
cross join "store"
order by staff."staff_id" , "tienda" ;


--64 Ecuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select customer."customer_id" , concat(customer."first_name" , ' ' , customer."last_name") as cliente , count(rental."rental_id") as total_peliculas_alquiladas
from "customer"
left join "rental" on customer."customer_id" = rental."customer_id"
group by customer."customer_id" , "cliente"
order by "total_peliculas_alquiladas" desc ;


