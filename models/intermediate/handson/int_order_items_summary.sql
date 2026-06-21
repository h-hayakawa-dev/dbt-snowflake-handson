with trusted_lineitems as (

    select * from {{ ref('trusted_lineitems') }}

),

summarized as (

    select
        order_key,
        count(*)            as line_item_count,
        sum(quantity)       as total_quantity,
        sum(extended_price) as gross_sales_amount

    from trusted_lineitems
    group by order_key

)

select * from summarized
