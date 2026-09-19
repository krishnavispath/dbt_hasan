select * from {{ ref('trip_fact') }}
where trip_duration_seconds < 0