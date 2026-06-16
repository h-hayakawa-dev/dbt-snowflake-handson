with source as (
    select * from {{source('TPCH', 'ORDERS') }}
),

renamed as (
    select
        o_orderkey as order_key,
        o_custkey as customer_key,
        o_orderstatus as status_code,
        o_totalprice as total_price,
        o_orderdate as order_date,
        o_orderpriority as priority_code,
        o_clerk as clerk_name,
        o_comment as order_comment
    from source
)

select * from renamed