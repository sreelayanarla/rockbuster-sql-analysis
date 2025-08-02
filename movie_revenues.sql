-- Retrieve the top 10 films that generated the highest total revenue

SELECT 
    F.title,
    SUM(P.amount) AS total_revenue
FROM film F
INNER JOIN inventory I ON F.film_id = I.film_id
INNER JOIN rental R ON I.inventory_id = R.inventory_id
INNER JOIN payment P ON R.rental_id = P.rental_id
GROUP BY F.title
ORDER BY total_revenue DESC
LIMIT 10;

-- Retrieve the 10 films that generated the **least** total revenue

SELECT 
    F.title,
    SUM(P.amount) AS total_revenue
FROM film F
INNER JOIN inventory I ON F.film_id = I.film_id
INNER JOIN rental R ON I.inventory_id = R.inventory_id
INNER JOIN payment P ON R.rental_id = P.rental_id
GROUP BY F.title
ORDER BY total_revenue ASC
LIMIT 10;
