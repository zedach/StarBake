SELECT
    product_id,
    product_name,
    total_units_sold,
    total_revenue,
    average_revenue_per_unit
FROM
    Products.ProductPerformance
ORDER BY
    total_units_sold DESC,
    total_revenue DESC
LIMIT 3