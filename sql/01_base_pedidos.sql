-- sql/01_base_pedidos.sql
WITH itens_agregados AS (
    SELECT
        order_id,
        SUM(price) AS valor_itens,
        SUM(freight_value) AS valor_frete,
        COUNT(*) AS qtd_itens,
        FIRST(seller_id) AS seller_id
    FROM order_items
    GROUP BY order_id
),
pagamentos_agregados AS (
    SELECT
        order_id,
        SUM(payment_value) AS valor_pago
    FROM order_payments
    GROUP BY order_id
),
reviews_agregados AS (
    SELECT
        order_id,
        AVG(review_score) AS review_score
    FROM order_reviews
    GROUP BY order_id
)
SELECT
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    c.customer_state,
    i.valor_itens,
    i.valor_frete,
    i.qtd_itens,
    s.seller_state,
    p.valor_pago,
    r.review_score
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN itens_agregados i ON o.order_id = i.order_id
LEFT JOIN pagamentos_agregados p ON o.order_id = p.order_id
LEFT JOIN sellers s ON i.seller_id = s.seller_id
LEFT JOIN reviews_agregados r ON o.order_id = r.order_id