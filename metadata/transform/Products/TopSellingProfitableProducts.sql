SELECT
    TSP.product_id, TSP.product_name
FROM
    Products.TopSellingProducts TSP
UNION ALL
SELECT
    MPP.product_id, MPP.product_name
FROM
    Products.MostProfitableProducts MPP
 