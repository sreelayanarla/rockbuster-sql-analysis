-- Calculate the average total amount paid by the top 5 customers
SELECT AVG(total_amount_paid) AS average
FROM (
    -- Subquery to find the top 5 customers based on total amount paid
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
        'Aurora', 'Tokat', 'Tarsus', 'Atlixco', 'Emeishan', 'Pontianak',
        'Shimoga', 'Aparecida de Goinia', 'Zalantun', 'Taguig'
    )
    GROUP BY A.customer_id, A.first_name, A.last_name, C.city, D.country
    ORDER BY total_amount_paid DESC
    LIMIT 5
) AS total_amount_paid;

-- This query finds how many of the top 5 customers (by total amount paid) 
-- are based in each country, along with the total customer count per country.

SELECT 
    D.country,
    COUNT(DISTINCT A.customer_id) AS all_customer_count,      -- Total number of customers in each country
    COUNT(DISTINCT top_customers.customer_id) AS top_customer_count  -- Number of top 5 customers per country
FROM customer A
-- Join to get country-level data
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id

-- Left join with the subquery to match top customers by country
LEFT JOIN (
    SELECT
        A.customer_id,
        A.first_name,
        A.last_name,
        C.city,
        D.country,
        SUM(E.amount) AS total_amount_paid
    FROM payment E
    INNER JOIN customer A ON E.customer_id = A.customer_id
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    WHERE C.city IN (
        'Aurora', 'Tokat', 'Tarsus', 'Atlixco', 'Emeishan', 
        'Pontianak', 'Shimoga', 'Aparecida de Goinia', 
        'Zalantun', 'Taguig'
    )
    GROUP BY A.customer_id, A.first_name, A.last_name, C.city, D.country
    ORDER BY total_amount_paid DESC
    LIMIT 5
) AS top_customers 
ON top_customers.country = D.country  -- Join on country to count top customers per region

GROUP BY D.country
ORDER BY top_customer_count DESC;  -- Sort by top customers in descending order


