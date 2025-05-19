-- QUESTION 3: Account Inactivity Alert

-- Find active accounts with no inflow for 365+ days
SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    -- Get last transaction date or NULL if none
    MAX(s.created_on) AS last_transaction_date,
    -- Calculate days since last transaction or NULL if no transaction
    DATEDIFF(CURDATE(), MAX(s.created_on)) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount s ON s.plan_id = p.id AND s.confirmed_amount IS NOT NULL
GROUP BY p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
HAVING
    (
      MAX(s.created_on) IS NULL OR -- No transaction ever
      DATEDIFF(CURDATE(), MAX(s.created_on)) > 365 -- More than 1 year since last transaction
    )
AND
    -- Consider only active plans: either savings or investment
    (p.is_regular_savings = 1 OR p.is_a_fund = 1)
ORDER BY
    inactivity_days DESC;
