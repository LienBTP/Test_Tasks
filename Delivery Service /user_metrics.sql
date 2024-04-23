WITH 
t1 AS (SELECT order_id,sum(price) AS order_price
       FROM
           (SELECT order_id, unnest(product_ids) AS product_id FROM orders) o
       JOIN products p ON p.product_id = o.product_id
       GROUP BY order_id),
t2 AS (SELECT user_id, u.order_id, array_length(product_ids, 1) AS order_size
       FROM
           (SELECT order_id, user_id
            FROM user_actions
            WHERE order_id not in (SELECT order_id FROM user_actions WHERE action = 'cancel_order')) AS u
       JOIN orders o ON u.order_id = o.order_id),
t3 AS (SELECT user_id, t1.order_id, order_price, order_size
       FROM t1
       JOIN t2 ON t1.order_id = t2.order_id)

SELECT user_id,
       count(order_id) AS orders_count,
       round(avg(order_size), 2) AS avg_order_size,
       sum(order_price) AS sum_order_value,
       round(avg(order_price), 2) AS avg_order_value,
       min(order_price) min_order_value,
       max(order_price)max_order_value
FROM t3
GROUP BY user_id
LIMIT 1000
