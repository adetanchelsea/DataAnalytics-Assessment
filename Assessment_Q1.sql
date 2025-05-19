-- QUESTION 1: High-Value Customers with Multiple Products in MySQL
--  This query identifies customers who have at least one funded savings plan and one funded investment plan, along with total deposits (in Naira).

SELECT 
    u.id AS owner_id, -- unique customer id
	CONCAT(u.first_name, ' ', u.last_name) AS name, -- customer name
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    ROUND(SUM(IFNULL(s.confirmed_amount, 0)) / 100, 2) AS total_deposits
FROM users_customuser u
INNER JOIN plans_plan p ON p.owner_id = u.id
INNER JOIN savings_savingsaccount s ON s.plan_id = p.id
WHERE s.confirmed_amount IS NOT NULL
GROUP BY u.id, u.name
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC;


