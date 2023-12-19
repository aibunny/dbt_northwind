WITH product_sales AS (
  SELECT
    p.product_id,
    p.product_name,
    COUNT(od.order_id) AS num_orders,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_sales
  FROM
    {{ ref('products') }} p
    LEFT JOIN {{ ref('order_details') }} od ON p.product_id = od.product_id
  GROUP BY
    p.product_id, p.product_name
)

SELECT *
FROM product_sales;