--Sales performance by coountries
-- Calculate total sales, customer count, and total rentals per country

SELECT 
    country.country,
    SUM(payment.amount) AS total_sales,
    COUNT(DISTINCT customer.customer_id) AS customer_count,
    COUNT(DISTINCT rental.rental_id) AS total_rentals
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN customer ON rental.customer_id = customer.customer_id
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country
ORDER BY total_sales DESC;
