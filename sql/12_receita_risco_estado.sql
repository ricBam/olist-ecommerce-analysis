SELECT
    customer_state,
    
    -- Métricas Base (suas originais)
    SUM(valor_pago) FILTER (WHERE atrasado) AS receita_em_risco,
    SUM(valor_pago) AS receita_total_estado,
    COUNT(*) FILTER (WHERE atrasado) AS pedidos_atrasados,
    COUNT(*) AS pedidos_totais,
    
    -- 1. Percentual de pedidos atrasados (relação de volume)
    (COUNT(*) FILTER (WHERE atrasado)::DECIMAL / NULLIF(COUNT(*), 0)) * 100 AS pct_pedidos_atrasados,

    -- 2. Percentual de receita em risco (relação de valor)
    (SUM(valor_pago) FILTER (WHERE atrasado) / NULLIF(SUM(valor_pago), 0)) * 100 AS pct_receita_em_risco,

    -- 3. Ticket Médio dos Atrasos (relação direta Valor vs Qtd de Atrasos)
    SUM(valor_pago) FILTER (WHERE atrasado) / NULLIF(COUNT(*) FILTER (WHERE atrasado), 0) AS ticket_medio_atraso,

    -- 4. Índice de Severidade (Ticket Médio Atraso / Ticket Médio Geral)
    ((SUM(valor_pago) FILTER (WHERE atrasado) / NULLIF(COUNT(*) FILTER (WHERE atrasado), 0)) / 
    (SUM(valor_pago) / NULLIF(COUNT(*), 0))) AS indice_severidade_atraso

FROM pedidos_atraso
GROUP BY customer_state
ORDER BY receita_em_risco DESC;
