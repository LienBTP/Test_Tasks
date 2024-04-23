SELECT name, budget
FROM
  (SELECT *
   FROM users
   WHERE owner_id NOT IN (SELECT id FROM users u)
   OR owner_id IS NULL) t5
LEFT JOIN
  (SELECT comp_id, sum(user_sum) AS budget
   FROM (SELECT COALESCE (owner_id, id) AS comp_id, user_sum
         FROM users u
         JOIN
        (SELECT user_id, sum(SUM) AS user_sum
         FROM payment_date
         WHERE SUM >0
         AND rk_id in (SELECT id AS rk_id FROM (SELECT *
						  FROM advertising_companies ac
						  WHERE is_main = 1
						  OR create_date = (SELECT min(create_date) FROM advertising_companies ac)))
         GROUP BY user_id) t2 ON t2.user_id = u.id) t3
    GROUP BY comp_id) t4 ON t5.id = t4.comp_id
ORDER BY name
