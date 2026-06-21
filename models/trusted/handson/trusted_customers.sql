with stg_customers as (

    select * from {{ ref('stg_customers') }}

),

cleansed as (

    -- 不正レコードの除外
    select *
    from stg_customers
    where customer_name is not null

),

deduplicated as (

    -- 粒度保証: customer_keyで一意化
    select *
    from cleansed
    qualify row_number() over (
        partition by customer_key
        order by customer_key
    ) = 1

)

select * from deduplicated
