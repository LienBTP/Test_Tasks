Задача: cоставление SQL-запроса для расчета показателей заказов каждого пользователя
- общее число заказов (orders_count)
- среднее количество товаров в заказе (avg_order_size)
- суммарная стоимость всех покупок (sum_order_value)
- средний чек пользователя (avg_order_value)
- минимальная стоимость заказа (min_order_value)
- максимальная стоимость заказа (max_order_value)

Шаги: 
- Исключение отмененных заказов из таблицы с действиями пользователей (user_actions)
- Объединение таблицы user_actions с данными о заказах (orders)
- Добавление таблицы products с данными о товарах (id, name, price)
- Расчет метрик

[Результат](http://redash.public.karpov.courses/embed/query/50940/visualization/77972?api_key=mPz9fpNltgD1hHQWpVnuyXqG1eA3K8LIgMkQF9O8&) 
