with trusted_orders as (

    select * from {{ ref('trusted_orders') }}

),

enriched as (

    select
        order_key,
        customer_key,
        status_code,
        case status_code
            when 'O' then 'オープン'
            when 'F' then '完了'
            when 'P' then '処理中'
            else '不明'
        end                                as status_name,
        total_price,
        total_price >= 100000              as is_large_order,
        order_date,
        to_char(order_date, 'YYYY-MM')     as order_year_month,
        priority_code,
        clerk_name

    from trusted_orders

)

select * from enriched
