-- QUESTION 2: Transaction Frequency Analysis
-- Categorize customers by average number of savings transactions per month

-- Step 1: Compute total transactions and active months per customer
WITH monthly_txn_counts AS (
    SELECT 
        s.owner_id,
        COUNT(*) AS total_transactions,
        -- Calculate the number of months between first and last transaction
        TIMESTAMPDIFF(MONTH, MIN(s.created_on), MAX(s.created_on)) + 1 AS active_months
    FROM savings_savingsaccount s
    WHERE s.confirmed_amount IS NOT NULL  -- Only include confirmed deposit transactions
    GROUP BY s.owner_id
)

-- Step 2: Group by frequency category and compute required aggregates
SELECT 
    CASE 
        WHEN (m.total_transactions / m.active_months) >= 10 THEN 'High Frequency'
        WHEN (m.total_transactions / m.active_months) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    
    COUNT(*) AS customer_count,
    
    ROUND(AVG(m.total_transactions / m.active_months), 1) AS avg_transactions_per_month
FROM monthly_txn_counts m
GROUP BY frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
