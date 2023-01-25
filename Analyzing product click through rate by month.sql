
drop table product_pageviews;

create temporary table product_pageviews
select
	website_pageview_id,
    website_session_id,
    created_at
	From website_pageviews
    where pageview_url = '/products'
    ;

Select
	year(product_pageviews.created_at) as year,
	month(product_pageviews.created_at) as month,
	count(product_pageviews.website_session_id) as sessions_to_product_page,
	count(website_pageviews.website_session_id) as clcikced_to_next_page,
	count(website_pageviews.website_session_id) / count(product_pageviews.website_session_id) as clickthrough_rt,
	count(orders.order_id) as orders,
	count(orders.order_id) / count(product_pageviews.website_session_id) as products_to_order_rt
from product_pageviews
left join website_pageviews
	on product_pageviews.website_session_id = website_pageviews.website_session_id
    and product_pageviews.website_pageview_id < website_pageviews.website_pageview_id
    left join orders
    on product_pageviews.website_session_id = orders.website_session_id
group by 1,2;
