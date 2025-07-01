Task 6: Subqueries and Nested Queries
Objective
Demonstrate the use of scalar subqueries, correlated subqueries, and nested queries in SELECT, WHERE, and FROM clauses.

Tools Used
DB Browser for SQLite or MySQL Workbench

Overview
This task uses a sample database consisting of two tables: customers and orders. The focus is on using subqueries with operators like IN, EXISTS, NOT IN, =, and ALL, and applying subqueries inside SELECT, WHERE, and FROM clauses.

Table Schema
customers



SQL Queries with Descriptions
Scalar Subquery in SELECT
Displays customer names with the total number of orders in the system.


SELECT customer_name,
       (SELECT COUNT(*) FROM orders) AS total_orders
FROM customers;
Subquery in WHERE using IN
Lists customer names who have placed at least one order.


SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
);
Subquery in WHERE using EXISTS
Finds customers who have at least one order.


SELECT customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
);
Subquery in FROM Clause (Derived Table)
Shows the count of delivered orders per customer.

sql
Copy
Edit
SELECT customer_id, COUNT(*) AS delivered_count
FROM (
    SELECT * FROM orders WHERE status = 'Delivered'
) AS delivered_orders
GROUP BY customer_id;
Correlated Subquery
Finds all orders where the status occurs more than once for the same customer.



SELECT *
FROM orders o1
WHERE (
    SELECT COUNT(*)
    FROM orders o2
    WHERE o2.customer_id = o1.customer_id
    AND o2.status = o1.status
) > 1;
Scalar Subquery with =
Returns the name of the customer who placed the most recent order.



SELECT customer_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    ORDER BY order_date DESC
    LIMIT 1
);
Subquery with NOT IN
Shows customers who have not placed any orders.

sql
Copy
Edit
SELECT customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id FROM orders
);
Subquery with ALL
Displays the most recent order of each customer.


SELECT *
FROM orders o1
WHERE order_date >= ALL (
    SELECT order_date
    FROM orders o2
    WHERE o1.customer_id = o2.customer_id
);
Subquery with GROUP BY and HAVING
Finds customers who placed more than two 'Delivered' orders.


SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE status = 'Delivered'
    GROUP BY customer_id
    HAVING COUNT(*) > 2
);
Multiple Scalar Subqueries in SELECT
Shows each customer with total and delivered order counts.


SELECT customer_name,
    (SELECT COUNT(*) FROM orders o1 WHERE o1.customer_id = c.customer_id) AS total_orders,
    (SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = c.customer_id AND status = 'Delivered') AS delivered_orders
FROM customers c;
Outcome
This task strengthens skills in writing advanced SQL queries using subqueries, helps understand nested logic, and prepares for real-world data querying in reporting and backend analysis.

