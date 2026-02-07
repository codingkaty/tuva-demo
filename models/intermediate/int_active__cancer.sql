with cancer_conditions as (
    select distinct
        person_id,
        cancer_type,
        claim_id
    from {{ ref('stg_condition__cancer') }}
    where active_cancer = 1
),

cancer_procedures as (
    select distinct
        person_id,
        treatment_type,
        claim_id
    from {{ ref('stg_procedure__cancer') }}
    where active_cancer_treatment = 1
      and procedure_date >= current_date - interval '6 month'
)

select
    person_id,
    cancer_type,
    null as treatment_type,
    claim_id
from cancer_conditions

union 

select
    person_id,
    null as cancer_type,
    treatment_type,
    claim_id
from cancer_procedures