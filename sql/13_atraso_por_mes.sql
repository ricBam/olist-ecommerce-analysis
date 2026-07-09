SELECT
    STRFTIME(order_purchase_timestamp, '%Y-%m') AS ano_mes,
    COUNT(*) FILTER (WHERE atrasado) AS pedidos_atrasados,
    COUNT(*) AS pedidos_totais,
    (COUNT(*) FILTER (WHERE atrasado)::DECIMAL / COUNT(*)) * 100 AS pct_atraso
FROM pedidos_atraso
GROUP BY ano_mes
ORDER BY ano_mes;
