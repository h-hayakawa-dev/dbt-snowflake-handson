with orders as (

    select * from {{ ref('trusted_covered_orders') }}

),

items as (

    select * from {{ ref('int_order_items_summary') }}

),

joined as (

    select
        orders.order_key,
        orders.order_date,
        orders.total_price,
        orders.is_large_order,
        items.line_item_count

    from orders
    left join items
        on orders.order_key = items.order_key

),

daily as (

    select
        order_date,
        count(*)                 as order_count,
        sum(total_price)         as sales_amount,
        count_if(is_large_order) as large_order_count,
        avg(line_item_count)     as avg_line_item_count

    from joined
    group by order_date

)

select * from daily
