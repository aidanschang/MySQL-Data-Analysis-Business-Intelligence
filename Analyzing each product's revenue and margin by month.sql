
select 
year(created_at) as year,
month(created_at) as month,
sum(case when product_id = 1 then price_usd else null end) as mrfuzzy_rev,
sum(case when product_id = 1 then price_usd-cogs_usd else null end) as mrfuzzy_margin,
sum(case when product_id = 2 then price_usd else null end) as lovebear_rev,
sum(case when product_id = 2 then price_usd-cogs_usd else null end) as lovebear_margin,
sum(case when product_id = 3 then price_usd else null end) as sugarpanda_rev,
sum(case when product_id = 3 then price_usd-cogs_usd else null end) as sugarpanda_margin,
sum(case when product_id = 4 then price_usd else null end) as minibear_rev,
sum(case when product_id = 4 then price_usd-cogs_usd else null end) as minibear_margin,
sum(price_usd) as total_revenue,
sum(price_usd) - sum(cogs_usd) as total_margin
from order_items
where created_at <= '2014-12-31'
group by 1, 2;
