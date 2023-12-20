WITH customer_orders AS (
  SELECT
    o.order_id,    
    c.customer_id,
    c.company_name,
    COUNT(od.product_id) AS num_products_ordered,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_order_amount
  FROM
    {{ source('northwind_data', 'orders') }} o
    JOIN {{ source('northwind_data', 'customers') }} c ON o.customer_id = c.customer_id
    LEFT JOIN {{ source('northwind_data', 'order_details') }} od ON o.order_id = od.order_id
  GROUP BY
    o.order_id, c.customer_id, c.company_name
)

SELECT *
FROM customer_orders
