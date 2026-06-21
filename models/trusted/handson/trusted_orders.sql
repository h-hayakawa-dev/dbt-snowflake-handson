with stg_orders as (

    select * from {{ ref('stg_orders') }}

),

cleansed as (

    -- 不正レコードの除外
    select *
    from stg_orders
    where total_price > 0
      and order_key is not null

),

deduplicated as (

    -- 粒度保証: order_keyで一意化(最新・任意の1行を残す)
    select *
    from cleansed
    qualify row_number() over (
        partition by order_key
        order by order_date desc
    ) = 1

)

select * from deduplicated