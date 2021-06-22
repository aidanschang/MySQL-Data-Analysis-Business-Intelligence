select
year(website_sessions.created_at) as year,
quarter(website_sessions.created_at) as quarter,
count(website_sessions.website_session_id) as sessions,
count(orders.order_id) as orders
From website_sessions
left join orders
	on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at <= '2014-12-31'
group by 1, 2;
