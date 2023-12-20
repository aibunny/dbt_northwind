WITH revenue_by_region AS (
  SELECT
    o.ship_region,
    COUNT(o.order_id) AS num_orders,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_sales
  FROM
    {{  source('northwind_data','orders') }} o
    LEFT JOIN {{  source('northwind_data','order_details') }} od ON o.order_id = od.order_id
  GROUP BY
    o.ship_region
)

SELECT *
FROM revenue_by_region