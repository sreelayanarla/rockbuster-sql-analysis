-- Step 1: Create a Common Table Expression (CTE) to calculate total amount paid by each customer
-- Only include customers from a selected list of top cities
WITH customer_payments AS (
    SELECT
        A.customer_id,
        A.first_name,
        A.last_name,
        C.city,
        D.country,
        SUM(E.amount) AS total_amount_paid  -- Calculate total amount paid per customer
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
    GROUP BY 
        A.customer_id, A.first_name, A.last_name, C.city, D.country
),

-- Step 2: Create another CTE to select the top 5 customers based on total amount paid
top_customers AS (
    SELECT *
    FROM customer_payments
    ORDER BY total_amount_paid DESC
    LIMIT 5
)

-- Step 3: Calculate the average total amount paid by these top 5 customers
SELECT 
    AVG(total_amount_paid) AS average
FROM top_customers;

