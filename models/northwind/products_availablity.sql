WITH product_availability AS (
  SELECT
    p.product_id,
    p.product_name,
    p.units_in_stock,
    p.units_on_order,
    p.reorder_level,
    CASE
      WHEN p.units_in_stock <= p.reorder_level THEN 'Low Stock'
      ELSE 'In Stock'
    END AS stock_status
  FROM
    {{ source('northwind_data','products') }} p
)

SELECT *
FROM product_availability