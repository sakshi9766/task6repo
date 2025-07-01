SELECT customer_name,
       (SELECT COUNT(*) FROM orders) AS total_orders
FROM customers;

SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
);

SELECT customer_name
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
);

SELECT customer_id, COUNT(*) AS delivered_count
FROM (
    SELECT * FROM orders WHERE status = 'Delivered'
) AS delivered_orders
GROUP BY customer_id;

SELECT *
FROM orders o1
WHERE (
    SELECT COUNT(*)
    FROM orders o2
    WHERE o2.customer_id = o1.customer_id
    AND o2.status = o1.status
) > 1;

SELECT customer_name
FROM customers
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    ORDER BY order_date DESC
    LIMIT 1
);

SELECT customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id FROM orders
);

SELECT *
FROM orders o1
WHERE order_date >= ALL (
    SELECT order_date
    FROM orders o2
    WHERE o1.customer_id = o2.customer_id
);

SELECT customer_name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE status = 'Delivered'
    GROUP BY customer_id
    HAVING COUNT(*) > 2
);

SELECT customer_name,
    (SELECT COUNT(*) FROM orders o1 WHERE o1.customer_id = c.customer_id) AS total_orders,
    (SELECT COUNT(*) FROM orders o2 WHERE o2.customer_id = c.customer_id AND status = 'Delivered') AS delivered_orders
FROM customers c;





