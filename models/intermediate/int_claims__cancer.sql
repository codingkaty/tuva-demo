with claims as (
select 
    claim_id,
    paid_amount,
    CASE
    WHEN revenue_center_code ~ '^(0024|01[0-9][0-9]|020[0-9]|021[0-9]|018[0-9]|019[0-9]|065[56]|0695|080[0-9])$'
        THEN 'inpatient'

    WHEN revenue_center_code ~ '^(045[0-9]|054[0-9]|068[0-9]|0981)$'
        THEN 'emergency'


    WHEN revenue_center_code ~ '^(02[4-9][0-9]|03[0-9][0-9]|04[0-9][0-9]|05[0-3][0-9]|05[5-9][0-9]|060[0-9]|06[1-4][0-9]|066[0-9]|067[0-9]|07[0-9][0-9]|08[2-8][0-9]|09[0-5][0-9]|098[2-9]|100[0-9]|210[0-9]|310[0-9])$'
        THEN 'outpatient'

    ELSE 'other'
    END AS care_setting
from {{ref('stg_claim__cancer')}} 
),

cancer_patients as (
    select distinct
        person_id,
        cancer_type,
        treatment_type,
        claim_id
    from {{ ref('int_active__cancer') }}
)

select
    c.person_id,
    c.cancer_type,
    c.treatment_type,
    cl.paid_amount,
    cl.care_setting
from claims cl 
left join cancer_patients c
    on c.claim_id = cl.claim_id
order by c.person_id, c.claim_id