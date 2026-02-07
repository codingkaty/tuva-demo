/*Pulls in claims and encounter data by cancer patient.*/
select 
    a.person_id,
    a.cancer_type,
    a.treatment_type,
    c.paid_amount,
    c.charge_amount,
    c.allowed_amount,
    c.deductible_amount,
    c.copayment_amount,
    c.total_cost_amount,
    e.encounter_id,
    e.encounter_type
from {{ref('int_active__cancer')}} a 
left join {{ref('stg_claim__cancer')}} c 
    on a.claim_id = c.claim_id
left join {{ref('stg_encounter__cancer')}} e 
    on c.person_id = e.person_id
    order by c.person_id