SELECT atrasado, AVG(valor_itens) AS 'Valor pago medio', AVG(review_score) AS 'Media de review', AVG(qtd_itens) AS 'Quantidade media de itens',AVG(valor_frete) AS 'Valor medio do frete pago' FROM pedidos_atraso
GROUP BY atrasado
