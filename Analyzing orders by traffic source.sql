select
year(website_sessions.created_at) as year,
quarter(website_sessions.created_at) as quarter,
count( case when utm_source = 'gsearch' and utm_campaign = 'nonbrand' then orders.order_id else null end) as Gsearch_nonbrand,
count( case when utm_source = 'bsearch' and utm_campaign = 'nonbrand' then orders.order_id else null end) as Bsearch_nonbrand,
count( case when utm_campaign = 'brand' then orders.order_id else null end) as Brand_search_overall,
count( case when http_referer is not null and utm_source is null then orders.order_id else null end) as Organic_search,
count( case when utm_source is null and http_referer is null then orders.order_id else null end) as direct_type_in
From website_sessions
left join orders
	on website_sessions.website_session_id = orders.website_session_id
where website_sessions.created_at <= '2014-12-31'
group by 1, 2;
