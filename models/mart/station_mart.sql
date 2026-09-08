with station_dimension as(
    select 
    *
    from {{ ref('station_dimension') }}
)
SELECT

    s.STATION_ID,
    s.STATION_NAME,
    s.station_lat,
    s.station_lng,
    s.station_type_code,

    st.STATION_TYPE_NAME,
    st.DESCRIPTION AS STATION_TYPE_DESCRIPTION

FROM station_dimension s

LEFT JOIN {{ ref('station_type') }} st
    ON s.station_type_code = st.STATION_TYPE_CODE