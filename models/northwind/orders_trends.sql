WITH order_trends AS (
  SELECT
    product_id,
    COUNT(order_id) AS num_orders,
    SUM(quantity) AS total_quantity
  FROM
    {{ source('northwind_data','order_details') }}
  GROUP BY
    product_id
)

SELECT *
FROM order_trends