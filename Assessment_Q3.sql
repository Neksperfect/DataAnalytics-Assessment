-- Account Inactivity Alert Query
-- This query identifies active accounts (savings or investments) with no inflow transactions for over one year (365 days).
-- It pulls data from the 'plans_plan' and 'savings_savingsaccount' tables.

-- Calculating the date one year ago to avoid function calls in the WHERE clause
SET @one_year_ago = DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY);

SELECT 
    p.id AS plan_id,
    p.owner_id, 
    CASE WHEN p.is_a_fund = 1 
        THEN 'Investment' 
        ELSE 'Savings' 
    END AS type, 
    s.last_transaction_date,
    CASE
        WHEN s.last_transaction_date IS NULL THEN DATEDIFF(CURRENT_DATE, p.start_date)  -- If no transaction, calculate inactivity from start date
        ELSE DATEDIFF(CURRENT_DATE, s.last_transaction_date)  -- Otherwise, calculate from last transaction date
    END AS inactivity_days     -- Number of days since last inflow
FROM plans_plan p

-- Joining with a subquery that gets the most recent inflow for each plan
LEFT JOIN (
    SELECT plan_id, MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0  -- Only count inflows (positive transactions)
    GROUP BY plan_id
) s ON p.id = s.plan_id

-- Filtering for accounts with no inflow for over one year
WHERE (s.last_transaction_date IS NULL AND DATEDIFF(CURRENT_DATE, p.start_date) > 365)
   OR (s.last_transaction_date < @one_year_ago)

-- Grouping and order the results
GROUP BY p.id, p.owner_id, type, s.last_transaction_date, p.start_date
ORDER BY inactivity_days DESC;



