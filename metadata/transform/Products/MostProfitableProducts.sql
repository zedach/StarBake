SELECT
    product_id,
    product_name,
    total_cost,
    total_revenue,
    total_profit,
    profit_per_unit
FROM
    Products.ProductProfitability
ORDER BY
    total_profit DESC
LIMIT 3