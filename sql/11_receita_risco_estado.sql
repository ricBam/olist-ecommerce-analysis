SELECT
    customer_state,
    SUM(valor_pago) FILTER (WHERE atrasado) AS receita_em_risco,
    SUM(valor_pago)  AS receita_total_estado,
    (SUM(valor_pago) FILTER (WHERE atrasado) / SUM(valor_pago)) * 100 AS pct_receita_em_risco,
    COUNT(*) FILTER (WHERE atrasado) AS pedidos_atrasados
FROM pedidos_atraso
GROUP BY customer_state
ORDER BY receita_em_risco DESC;
