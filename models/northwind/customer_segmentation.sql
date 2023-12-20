WITH customer_segmentation AS (
  SELECT
    c.customer_id,
    c.company_name,
    COUNT(o.order_id) AS num_orders,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_spent
  FROM
    {{ source('northwind_data','customers') }} c
    LEFT JOIN {{ source('northwind_data','orders') }} o ON c.customer_id = o.customer_id
    LEFT JOIN {{ source('northwind_data','order_details') }} od ON o.order_id = od.order_id
  GROUP BY
    c.customer_id, c.company_name
)

SELECT *,
  CASE
    WHEN num_orders >= 10 AND total_spent >= 1000 THEN 'High Value'
    WHEN num_orders >= 5 THEN 'Mid Value'
    ELSE 'Low Value'
  END AS customer_segment
FROM customer_segmentation