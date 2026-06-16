with source as (
    select * from {{ source('EXT_STAGE_TEST', 'REGION_MASTER')}}
)

select * from source