SELECT (seller_state = customer_state) AS mesmo_estado,
       AVG(CAST(atrasado AS INT))*100 AS taxa_atraso,
       COUNT(*) AS qtd_pedidos
FROM pedidos_atraso
GROUP BY mesmo_estado
