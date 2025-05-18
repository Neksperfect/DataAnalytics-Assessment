# DataAnalytics-Assessment

# Data Analytics Assessment for Cowrywise

## Overview
This repository contains SQL solutions for the Cowrywise Data Analyst Assessment. The goal is to demonstrate proficiency in SQL through queries that retrieve, aggregate, and manipulate data efficiently.

### Repository Structure
```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```

## Question Explanations

### Question 1: High-Value Customers with Multiple Products
- Identifies customers with both a savings and an investment plan.
- The query joins three tables: `users_customuser`, `savings_savingsaccount`, and `plans_plan`.
- Filters for customers who have at least one savings and one investment plan.
- Orders results by total deposits in descending order.

**Challenge:** Combining conditions from multiple tables to ensure accuracy.
               Using CONCAT directly without checking for nulls can result in unexpected outputs.
               
### Question 2: Transaction Frequency Analysis
- Categorizes customers based on the average number of transactions per month.
- Uses `CASE WHEN` to label frequency as High, Medium, or Low.
- Groups by frequency category to display customer count.

**Challenge:** Correctly calculating the average transactions per month using subquerries and case statements.

### Question 3: Account Inactivity Alert
- Finds accounts with no inflow transactions for over a year.
- Uses `DATEDIFF` to compute inactivity days.
- Includes both savings and investment accounts in the result.

**Challenge:** Ensuring accurate calculation of inactivity days while handling different account types.
               Calculating the date one year ago to avoid function calls in the WHERE clause.
               Combining multiple complex querries to show all plans where last transaction is either NULL (no transactions) or older than 1 year.

### Question 4: Customer Lifetime Value (CLV) Estimation
- Calculates tenure (months since signup) and total transactions.
- Estimates CLV based on transaction volume and account tenure.
- Orders customers by CLV from highest to lowest.

**Challenge:** Using the formula efficiently while handling division by zero for tenure.
               Using CONCAT directly without checking for nulls can result in unexpected outputs.
               The formula for CLV estimation combines several operations, making it prone to errors.

## Conclusion
The SQL queries were designed to be efficient and readable while addressing the requirements accurately. Challenges were tackled by carefully analyzing table relationships and data formats.
