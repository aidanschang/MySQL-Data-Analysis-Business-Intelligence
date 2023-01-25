select
year(website_sessions.created_at) as year,
quarter(website_sessions.created_at) as quarter,
count(orders.order_id) / count(website_sessions.website_session_id) as session_to_order_cvt,
sum(orders.price_usd) / count(orders.order_id) as revenue_per_order,
sum(orders.price_usd) / count(website_sessions.website_session_id) as revenue_per_session

From website_sessions
left join orders
	on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at <= '2014-12-31'
group by 1, 2;
