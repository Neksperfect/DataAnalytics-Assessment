-- Question 2: Transaction Frequency Analysis
-- Categorizing customers based on average transactions per month
-- This query groups customers by their transaction frequency, calculating the average number of transactions per month.

SELECT frequency_category, 
       COUNT(customer_id) AS customer_count, 
        -- Rounding average transactions per month to one decimal place
       ROUND(AVG(transaction_count), 1) AS avg_transactions_per_month
FROM (
    -- Subquery to categorize transaction frequency
    SELECT u.id AS customer_id,
        -- Categorizing transaction frequency based on average transactions per month
        CASE 
            WHEN COUNT(s.id) / 12 >= 10 THEN 'High Frequency'      -- 10 or more transactions per month
            WHEN COUNT(s.id) / 12 BETWEEN 3 AND 9 THEN 'Medium Frequency' -- Between 3 and 9 transactions per month
            WHEN COUNT(s.id) / 12 <= 2 THEN 'Low Frequency'        -- 2 or fewer transactions per month
            ELSE 'Unknown'                                        -- for any unexpected values
        END AS frequency_category,
        
        -- Calculating the number of transactions per month
        COUNT(s.id) / 12 AS transaction_count
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s 
			ON u.id = s.owner_id
    GROUP BY u.id
) AS freq
GROUP BY frequency_category;

