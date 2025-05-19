# Data Analytics SQL Assessment

This repository contains my solutions for the SQL Proficiency Assessment, designed to test data retrieval, aggregation, joins, subqueries, and data manipulation skills across multiple tables.

---

## Table of Contents

1. [High-Value Customers with Multiple Products](#1-high-value-customers-with-multiple-products)  
2. [Transaction Frequency Analysis](#2-transaction-frequency-analysis)  
3. [Account Inactivity Alert](#3-account-inactivity-alert)  
4. [Customer Lifetime Value (CLV) Estimation](#4-customer-lifetime-value-clv-estimation)  

---

## 1. High-Value Customers with Multiple Products

### Approach:
- Identified customers who have at least one funded savings plan (`is_regular_savings = 1`) and one funded investment plan (`is_a_fund = 1`).
- Joined `users_customuser` with `plans_plan` and `savings_savingsaccount` to aggregate counts of each plan type per customer.
- Calculated total deposits by summing `confirmed_amount` (converted from kobo to base currency).
- Used grouping and conditional aggregation to filter customers meeting the criteria.
- Sorted results by total deposits descending.

### Challenges:
- Ensuring the correct identification of plan types using the flags (`is_regular_savings`, `is_a_fund`).
- Joining tables efficiently without duplicate rows impacting aggregates.
- Handling monetary values stored in kobo by converting to the base currency.

---

## 2. Transaction Frequency Analysis

### Approach:
- Calculated total transactions per customer.
- Determined active months per customer based on the earliest and latest transaction dates.
- Computed average transactions per month for each customer.
- Categorized customers into High, Medium, and Low frequency groups based on average transactions.
- Aggregated and reported customer counts and average transactions per category.

### Challenges:
- Handling cases where customers had transactions spanning less than a month to avoid division errors.
- Using `TIMESTAMPDIFF` to calculate the number of active months accurately.
- Categorizing frequency using CASE statements cleanly.

---

## 3. Account Inactivity Alert

### Approach:
- Retrieved active plans (both savings and investments) from `plans_plan`.
- Identified the date of the last confirmed transaction from `savings_savingsaccount` for each plan.
- Calculated inactivity days by comparing the last transaction date to the current date.
- Filtered plans with inactivity over 365 days.
- Output included plan ID, owner ID, plan type, last transaction date, and inactivity days.

### Challenges:
- Determining inactivity accurately when some plans had no transactions.
- Correctly differentiating savings and investment plans using the appropriate flags.
- Handling NULL values for last transaction dates by excluding inactive or non-funded accounts.

---

## 4. Customer Lifetime Value (CLV) Estimation

### Approach:
- Calculated each customer's tenure in months since signup.
- Counted total transactions for each customer.
- Calculated average profit per transaction as 0.1% of average transaction value (`confirmed_amount`).
- Computed estimated CLV using the formula:  
  `(total_transactions / tenure_months) * 12 * avg_profit_per_transaction`.
- Handled cases with zero tenure by substituting tenure with 1 month to avoid division by zero.
- Ordered customers by estimated CLV descending.

### Challenges:
- Handling customers with zero months of tenure.
- Correctly converting monetary values from kobo to the base currency.
- Ensuring NULL transactions do not affect aggregates.

---

## General Challenges and Resolutions

- Some date columns in tables had unexpected names; careful exploration of schema was necessary.
- Monetary values in kobo required conversion for accurate reporting.
- Avoided division by zero and NULL handling issues using conditional logic.
- Used CTEs (Common Table Expressions) for clarity and modular query design.
- Ensured queries were optimized for readability and performance.

---

Thank you for reviewing my SQL assessment.  
Please feel free to reach out for any clarifications or further explanations.

Chelsea Adetan
---
