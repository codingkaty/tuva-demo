with care_mapping as (

        select
            encounter_type,
            paid_amount
        from {{ ref('int_encounter_claims__cancer') }}
),

total_spend as (
    select sum(paid_amount) as total_paid
    from care_mapping
),

agg_spend as(
    select
        encounter_type,
        round(sum(paid_amount), 0) as total_paid_amount,
        round(sum(paid_amount) / (select total_paid from total_spend) * 100, 2) as pct_of_total_paid
    from care_mapping
    group by encounter_type
    order by pct_of_total_paid desc
)
select
    encounter_type,
    total_paid_amount,
    pct_of_total_paid,
    dense_rank() over (order by pct_of_total_paid desc) as spend_rank
from agg_spend
order by 3 desc