with 

t1 as (select order_id, sum(price) as order_price
from (select order_id, unnest(product_ids) as product_id
from orders) o
join products p
on p.product_id = o.product_id
group by order_id),

t2 as (select user_id, u.order_id, array_length(product_ids,1) as order_size
from (select order_id,user_id
from user_actions
where order_id not in (select order_id from user_actions where action = 'cancel_order')) as u
join orders o
on u.order_id = o.order_id),

t3 as (select user_id, t1.order_id, order_price, order_size
from t1
join t2
on t1.order_id = t2.order_id)

select user_id, 
count(order_id) as orders_count, 
round(avg(order_size),2) as avg_order_size, 
sum(order_price) as sum_order_value, 
round(avg(order_price),2) as avg_order_value, 
min(order_price) min_order_value, 
max(order_price)max_order_value

from t3
group by user_id
limit 1000
