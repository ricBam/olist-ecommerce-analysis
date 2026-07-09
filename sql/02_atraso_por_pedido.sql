SELECT *,
       order_delivered_customer_date > order_estimated_delivery_date AS atrasado,
       DATE_DIFF('day', order_estimated_delivery_date, order_delivered_customer_date) AS dias_atraso
  FROM base_pedidos
 WHERE order_status = 'delivered'
   AND order_delivered_customer_date IS NOT NULL;
