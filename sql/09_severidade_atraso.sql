WITH resumo_pedidos AS (
    SELECT
        CASE
            WHEN dias_atraso <= 0 THEN '1 - no prazo/adiantado'
            WHEN dias_atraso BETWEEN 1 AND 3  THEN '2 - 1 a 3 dias'
            WHEN dias_atraso BETWEEN 4 AND 7  THEN '3 - 4 a 7 dias'
            WHEN dias_atraso BETWEEN 8 AND 15 THEN '4 - 8 a 15 dias'
            ELSE '5 - mais de 15 dias'
        END AS faixa_atraso,
        AVG(review_score) AS nota_media,
        COUNT(*) AS qtd_pedidos
    FROM pedidos_atraso
    GROUP BY faixa_atraso
)
SELECT 
    faixa_atraso,
    nota_media,
    qtd_pedidos,
    -- ABS() garante que o resultado final seja sempre positivo
    ABS(
        ((nota_media - FIRST_VALUE(nota_media) OVER (ORDER BY faixa_atraso)) 
        / FIRST_VALUE(nota_media) OVER (ORDER BY faixa_atraso)) * 100
    ) AS dif_percentual_nota
FROM 
    resumo_pedidos
ORDER BY 
    faixa_atraso;
