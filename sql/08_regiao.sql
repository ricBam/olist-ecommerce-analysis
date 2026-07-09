WITH regioes AS (
    SELECT *,
        CASE
            WHEN customer_state IN ('AC','AP','AM','PA','RO','RR','TO') THEN 'Norte'
            WHEN customer_state IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
            WHEN customer_state IN ('DF','GO','MS','MT') THEN 'Centro-Oeste'
            WHEN customer_state IN ('ES','MG','RJ','SP') THEN 'Sudeste'
            WHEN customer_state IN ('PR','RS','SC') THEN 'Sul'
        END AS regiao_cliente,
        CASE
            WHEN seller_state IN ('AC','AP','AM','PA','RO','RR','TO') THEN 'Norte'
            WHEN seller_state IN ('AL','BA','CE','MA','PB','PE','PI','RN','SE') THEN 'Nordeste'
            WHEN seller_state IN ('DF','GO','MS','MT') THEN 'Centro-Oeste'
            WHEN seller_state IN ('ES','MG','RJ','SP') THEN 'Sudeste'
            WHEN seller_state IN ('PR','RS','SC') THEN 'Sul'
        END AS regiao_vendedor
    FROM pedidos_atraso
)
SELECT (regiao_cliente = regiao_vendedor) AS mesma_regiao,
       AVG(CAST(atrasado AS INT))*100 AS taxa_atraso,
       COUNT(*) AS qtd_pedidos
FROM regioes
GROUP BY mesma_regiao
