-- Question 4: Customer Lifetime Value (CLV) Estimation
-- Calculating account tenure, total transactions, and estimated CLV
-- Sorted by estimated CLV in descending order

SELECT u.id AS customer_id, 
       -- Concatenate first and last names, or return NULL if both are missing
       CASE 
           WHEN u.first_name IS NULL AND u.last_name IS NULL THEN NULL
           WHEN u.first_name IS NULL THEN u.last_name
           WHEN u.last_name IS NULL THEN u.first_name
           ELSE CONCAT(u.first_name, ' ', u.last_name) 
       END AS name, 
       
       -- Calculate the customer's tenure in months since the signup date
       TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months, 
       
       -- Count the total number of transactions made by the customer
       COUNT(s.id) AS total_transactions, 
       
       -- Estimate the Customer Lifetime Value (CLV), rounded to 2 decimal places
       ROUND(
         (COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) * 12 * 
         (SUM(s.confirmed_amount) * 0.001 / COUNT(s.id)), 2
       ) AS estimated_clv
       
FROM users_customuser u

-- Join with savings accounts to get customer transaction details
JOIN savings_savingsaccount s 
    ON u.id = s.owner_id

-- Group by customer ID and calculated name to aggregate transactions and tenure
GROUP BY u.id, name

-- Sort the results by estimated CLV in descending order to identify high-value customers
ORDER BY estimated_clv DESC;

