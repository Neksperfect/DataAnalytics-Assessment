-- Question 1: High-Value Customers with Multiple Products
-- Identifying customers who have both a savings and an investment plan
-- Sorted by total deposits

SELECT u.id AS owner_id, 
       -- Concatenate first and last names to display as a single name
       CONCAT(u.first_name, ' ', u.last_name) AS name, 
       
       -- Count the number of distinct savings accounts the customer owns
       COUNT(DISTINCT s.id) AS savings_count, 
       
       -- Count the number of distinct investment plans the customer owns
       COUNT(DISTINCT p.id) AS investment_count, 
       
       -- Calculate the total deposits, converting the amount to a decimal and rounding to 2 decimal places
       ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
       
FROM users_customuser u

-- Join with savings accounts to get customer savings details
JOIN savings_savingsaccount s 
    ON u.id = s.owner_id

-- Join with investment plans to get customer investment details
JOIN plans_plan p 
    ON u.id = p.owner_id

-- Filter for customers who have a specific savings plan and an investment fund
WHERE s.plan_id = 1 
  AND p.is_a_fund = 1

-- Group by user ID and concatenated name to aggregate savings and investment counts
GROUP BY u.id, name

-- Only include customers who have at least one savings and one investment plan
HAVING COUNT(DISTINCT s.id) > 0 
   AND COUNT(DISTINCT p.id) > 0

-- Sort the results by total deposits in descending order to identify high-value customers
ORDER BY total_deposits DESC;

