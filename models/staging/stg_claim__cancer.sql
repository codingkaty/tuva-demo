with source as(
    select
        claim_id,
        claim_line_number,
        claim_type,
        person_id,
        member_id,
        payer,
        plan,
        claim_start_date,
        claim_end_date,
        claim_line_start_date,
        claim_line_end_date,
        admission_date,
        discharge_date,
        admit_source_code,
        admit_type_code,
        discharge_disposition_code,
        place_of_service_code,
        bill_type_code,
        paid_date,
        paid_amount,
        allowed_amount,
        charge_amount,
        coinsurance_amount,
        copayment_amount,
        deductible_amount,
        total_cost_amount,
        in_network_flag

    FROM {{ref('medical_claim')}}

)

select 
    claim_id,
    claim_line_number,
    claim_type,
    person_id,
    member_id,
    paid_date,
    paid_amount,
    allowed_amount,
    charge_amount,
    coinsurance_amount,
    copayment_amount,
    deductible_amount,
    total_cost_amount
from source
