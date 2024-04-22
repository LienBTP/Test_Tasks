SELECT name, budget
from (SELECT *
	  from users 
	  where owner_id NOT IN (select id from users u)
	  or owner_id is NULL) t5
left JOIN (select comp_id, sum(user_sum) as budget
		   from (select COALESCE (owner_id,id) as comp_id, user_sum  
		   		 from users u
		   		 join (select user_id, sum(sum) as user_sum 
		   		 	   from payment_date
		   		 	   where sum >0
		   		 	   and rk_id in (select id as rk_id from (select * from advertising_companies ac
		   		 	   				 	   			 where is_main = 1
		   		 	   				 	             OR create_date = (
		   		 	   				 	             		select min(create_date) from advertising_companies ac)))
		   		 	  group by user_id) t2 
		   		 on t2.user_id = u.id) t3
		   		 group by comp_id) t4 
on t5.id = t4.comp_id
order by name
