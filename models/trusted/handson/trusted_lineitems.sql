with stg_lineitems as (
    select * from {{ ref('stg_lineitems') }}
),

cleansed as (

    -- 不正レコードの除外
    select *
    from stg_lineitems
    where quantity > 0
        and order_key is not null
        and line_number is not null
),

deduplicated as (

    -- 粒度保証: order_key x line_number の複合キーで一意化
    select *
    from cleansed
    qualify row_number() over (
        partition by order_key, line_number
        order by order_key
    ) = 1
)

select * from deduplicated