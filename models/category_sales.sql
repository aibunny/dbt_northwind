WITH category_sales AS (
  SELECT
    c.category_id,
    c.category_name,
    COUNT(od.order_id) AS num_orders,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS total_sales
  FROM
    {{ ref('postgres.categories') }} c
    LEFT JOIN {{ ref('postgres.products') }} p ON c.category_id = p.category_id
    LEFT JOIN {{ ref('postgres.order_details') }} od ON p.product_id = od.product_id
  GROUP BY
    c.category_id, c.category_name
)

SELECT *
FROM category_sales;
