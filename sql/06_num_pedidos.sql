SELECT customer_state, atrasado, COUNT(*) AS qtd_pedidos
FROM pedidos_atraso
GROUP BY customer_state, atrasado
ORDER BY customer_state
