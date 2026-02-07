with source as (
    
    select
        condition_id,
        person_id,
        patient_id,
        encounter_id,
        claim_id,
        recorded_date,
        onset_date,
        resolved_date,
        condition_type,
        source_code_type,
        source_code,
        source_description
    FROM core.condition
    )

select *,
    case
        when source_code ~ '^C0[0-9].*|^C1[0-4].*' then 'Lip, Oral Cavity, Pharynx'
        when source_code ~ '^C1[5-9].*|^C2[0-6].*' then 'Digestive Organs'
        when source_code ~ '^C3[0-9].*' then 'Respiratory & Intrathoracic Organs'
        when source_code ~ '^C4[0-1].*' then 'Bone & Articular Cartilage'
        when source_code ~ '^C4[3-4].*' then 'Skin / Melanoma'
        when source_code ~ '^C4[5-9].*' then 'Mesothelial / Soft Tissue'
        when source_code ~ '^C50.*' then 'Breast'
        when source_code ~ '^C5[1-8].*' then 'Female Genital Organs'
        else 'Other'
       end as cancer_type,
    case 
            when source_code ~  '^C[0-8][A-Za-z0-9_]*|^C[9][A-Za-z0-6_]*|^D[3-4][7-8]*'
                AND source_code_type LIKE 'icd-10-cm' 
                AND resolved_date IS NULL
            then 1
            else 0
    end as active_cancer
from source
