-- Title: Top 10 Countries by Customer Count
-- Description: This query identifies the top 10 countries with the highest number of customers. 
-- It uses INNER JOINs to access country information through the address and city tables, ensuring only valid customer data is included.

SELECT 
    D.country,
    COUNT(A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id
GROUP BY D.country
ORDER BY customer_count DESC
LIMIT 10;

-- Title: Top 5 Customers from the Top 10 Cities
-- Description: This query finds the top 5 customers who have paid the highest total amounts in the top 10 revenue-generating cities.

SELECT
    A.customer_id,
    A.first_name,
    A.last_name,
    C.city,
    D.country,
    SUM(E.amount) AS total_amount_paid
FROM payment E
INNER JOIN customer AS A ON E.customer_id = A.customer_id
INNER JOIN address AS B ON A.address_id = B.address_id
INNER JOIN city AS C ON B.city_id = C.city_id
INNER JOIN country AS D ON C.country_id = D.country_id
WHERE C.city IN (
    'Aurora', 'Tokat', 'Tarsus', 'Atlixco', 'Emeishan',
    'Pontianak', 'Shimoga', 'Aparecida de Goinia', 'Zalantun', 'Taguig'
)
GROUP BY A.customer_id, A.first_name, A.last_name, C.city, D.country
ORDER BY total_amount_paid DESC
LIMIT 5;


