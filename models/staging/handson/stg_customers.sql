with source as (
    select * from {{ source('TPCH', 'CUSTOMER')}}
),

renamed as (
    select
        c_custkey as customer_key,
        c_name as customer_name,
        c_nationkey as nation_key,
        c_phone as phone_number,
        c_acctbal as account_balance,
        c_mktsegment as market_segment
    from source
)

select * from renamed
