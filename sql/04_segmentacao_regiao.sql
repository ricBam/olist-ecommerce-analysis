SELECT customer_state , atrasado , AVG(valor_itens) AS 'Valor pago medio', AVG(review_score) AS 'Media de review',AVG(qtd_itens) AS 'Quantidade media de itens' FROM pedidos_atraso
GROUP BY customer_state, atrasado
ORDER BY customer_state, atrasado