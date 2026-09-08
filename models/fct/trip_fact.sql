{{ 
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

with trips as(
    select 
    ride_id,
    date(to_timestamp(started_at)) as trip_date,
    start_station_id,
    end_station_id,
    member_casual,
    timestampdiff(second,to_timestamp(started_at),to_timestamp(ended_at)) as trip_duration_seconds
    from {{ ref('stg_bike') }}
)
select * from trips

{% if is_incremental() %}
    where trip_date > (select max(trip_date) from {{ this }})
{% endif %}