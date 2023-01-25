drop table primary_product;
create temporary table primary_product

select
	order_item_id,
	order_id,
	product_id
from order_items
where created_at > '2014-12-05'
and is_primary_item = 1;

select
primary_id,
count(order_id),
count(case when xsell_product_id = 1 then 1 else null end) as xsold_p1,
count(case when xsell_product_id = 2 then 1 else null end) as xsold_p2,
count(case when xsell_product_id = 3 then 1 else null end) as xsold_p3,
count(case when xsell_product_id = 4 then 1 else null end) as xsold_p4,
count(case when xsell_product_id = 1 then 1 else null end) / count(order_id) as xsold_p1_rt,
count(case when xsell_product_id = 2 then 1 else null end) / count(order_id) as xsold_p2_rt,
count(case when xsell_product_id = 3 then 1 else null end) / count(order_id) as xsold_p3_rt,
count(case when xsell_product_id = 4 then 1 else null end) / count(order_id) as xsold_p4_rt
from
	(select
		primary_product.order_item_id,
		primary_product.order_id as order_id,
		primary_product.product_id as primary_id,
		order_items.product_id as xsell_product_id
	from primary_product
	left join order_items
		on primary_product.order_id = order_items.order_id
		and order_items.is_primary_item = 0) as crosssold
group by 1
