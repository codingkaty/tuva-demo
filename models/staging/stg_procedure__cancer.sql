with source as(
    select 
        procedure_id,
        encounter_id,
        claim_id,
        person_id,
        member_id,
        patient_id,
        procedure_date,
        source_code_type,
        source_code,
        source_description,
        case 
            when source_code  ~ '^(9640[1-2]|9640[9]|9641[1-7]|9642[0-5]|96450)$'
                OR source_code ~ '^(772(6[1-9]|[7-9][0-9])|773(7[1-3]|8[5-6])|774(0[1-9]|[1-9][0-9])|777[5-9][0-9])$'
            then 1
            else 0
    end as active_cancer_treatment
    from  core.procedure
)

select *,
    case
  when source_code ~ '^(964[0-9]{2}|965[0-4][0-9])$' then 'chemotherapy'
  when source_code ~'^(772|773|774|775|776|777)[0-9]{2}$' then 'radiation'
  when lower(source_description) ~ 'excision|resection|extirpation' then 'surgery'
  else 'other'
end as treatment_type
from source