with source as (
    select * from {{ source('TPCH', 'LINEITEM')}}
),

renamed as (
    select
        l_orderkey as order_key,
        l_linenumber as line_number,
        l_partkey as part_key,
        l_quantity as quantity,
        l_extendedprice as extended_price,
        l_discount as discount_rate,
        l_returnflag as return_flag
    from source
)

select * from renamed