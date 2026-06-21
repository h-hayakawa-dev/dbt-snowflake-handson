with orders as (
    select * from {{ ref('trusted_covered_orders') }}
),

customers as (
    select * from {{ ref('trusted_customers') }}
),

joined as (
    select
        o.order_key,
        o.customer_key,
        o.status_name,
        o.is_large_order,
        o.order_year_month,
        o.total_price,
        c.customer_name,
        c.market_segment,
        c.nation_key
    from orders o
    left join customers c
        on o.customer_key = c.customer_key
),

final as (
    select
        order_key, customer_key, status_name, is_large_order,
        order_year_month, total_price,
        customer_name, market_segment, nation_key
    from joined
)

select * from final