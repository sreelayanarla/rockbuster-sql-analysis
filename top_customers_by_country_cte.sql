-- Step 1: CTE to calculate total amount paid by customers in selected cities
WITH customer_payments AS (
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
),

-- Step 2: CTE to get top 5 customers based on total amount paid
top_customers AS (
    SELECT *
    FROM customer_payments
    ORDER BY total_amount_paid DESC
    LIMIT 5
)

-- Step 3: Count total customers and top customers per country
SELECT
    D.country,
    COUNT(DISTINCT A.customer_id) AS all_customer_count, -- Total number of customers in each country
    COUNT(DISTINCT top_customers.customer_id) AS top_customer_count -- Top 5 customers from each country (if any)
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_id = D.country_id

-- Join with top customers based on country
LEFT JOIN top_customers ON top_customers.country = D.country

GROUP BY D.country
ORDER BY top_customer_count DESC;
