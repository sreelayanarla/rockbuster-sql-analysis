
-- CTE 1: Calculate total amount paid per customer in selected cities
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

-- CTE 2: Select the top 5 customers based on total amount paid
top_customers AS (
    SELECT *
    FROM customer_payments
    ORDER BY total_amount_paid DESC
    LIMIT 5
)

-- Final Query: Calculate the average total amount paid by the top 5 customers
SELECT 
    AVG(total_amount_paid) AS average_total_amount_paid
FROM top_customers;
