WITH order_trends AS (
  SELECT
    product_id,
    COUNT(order_id) AS num_orders,
    SUM(quantity) AS total_quantity
  FROM
    {{ ref('order_details') }}
  GROUP BY
    month
)

SELECT *
FROM order_trends;