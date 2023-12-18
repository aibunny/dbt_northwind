WITH order_trends AS (
  SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(order_id) AS num_orders,
    SUM(freight) AS total_freight
  FROM
    {{ ref('postgres.orders') }}
  GROUP BY
    month
)

SELECT *
FROM order_trends;