-- QUESTION 4: Customer Lifetime Value (CLV) Estimation

WITH customer_transactions AS (
    SELECT
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) AS name,
        -- Calculate account tenure in months from signup date to today
        TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
        -- Count total completed transactions for each customer
        COUNT(s.id) AS total_transactions,
        -- Calculate average profit per transaction (0.1% of average confirmed_amount in base currency)
        AVG(s.confirmed_amount) / 100 * 0.001 AS avg_profit_per_transaction
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s 
        ON s.owner_id = u.id AND s.confirmed_amount IS NOT NULL
    GROUP BY
        u.id, u.first_name, u.last_name, u.date_joined
)

SELECT
    customer_id,
    name,
    tenure_months,
    total_transactions,
    -- Estimated CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction
    -- Use LEAST to avoid division by zero by treating zero tenure as 1 month
    ROUND(
        (total_transactions / LEAST(tenure_months, 1)) * 12 * avg_profit_per_transaction
    , 2) AS estimated_clv
FROM
    customer_transactions
ORDER BY
    estimated_clv DESC;
