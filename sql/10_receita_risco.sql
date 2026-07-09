SELECT
    COUNT(*) FILTER (WHERE atrasado) AS pedidos_atrasados,
    FORMAT('{:,.2f}', ROUND(SUM(valor_pago) FILTER (WHERE atrasado), 2)) AS receita_em_risco,
    FORMAT('{:,.2f}', ROUND(SUM(valor_pago), 2)) AS receita_total,
    (SUM(valor_pago) FILTER (WHERE atrasado) / SUM(valor_pago)) * 100 AS pct_receita_em_risco
FROM pedidos_atraso;