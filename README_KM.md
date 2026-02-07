METHODOLOGY: 
Here is the criteria I used to define cancer: 
1. Condition is listed as ICD-10-CM code in the range C00-C96 or D37 - D48 and the resolved date is not null.
2. Patient has received chemotherapy or radiation in the past 6 months.


KEY FINDINGS:
- Office visits are the top spending bucket over all. ER spend is ~18% of, which is relatively high for cancer patients. 
- Cancer of respiratory and intrathoracic organs is the top spending bucket by quite a large margin, taking 25% of total spend.
- A smaller group of cancer types make up the majority of the spend. The top 5 types (Respiratory, Breast, Digestive, Female Genital, and Skin) make up ~40% of the total spend. 

AI USAGE:
I used ai to generate regex code to identify icd-10-cm cancer codes in starting with values in the range: C00 - C96 and D37 - D48. I input the prompt and it spit out this sequence: '^(C([0-9][0-9]|[0-9][A-Z]|[A-Z][0-9]|[A-Z][A-Z])|D([3-4][0-9]|[3-4][A-Z]|[A-Z][0-9]|[A-Z][A-Z]))$'

How I corrected the AI: To check this work, I few test queries. First I ran a group by to check if I was getting a decent amount of data. It only returned 98 distinct person_ids per source_code_type icd-10-cm. Then I ran another query to search for a known icd-10-cm code "C9110" which returned null. I looked closer at the regex and realized it was only including characters with 2 digits, and I needed to add plus sign at the end of each expression in order to included values with any number of characters after them. 

Then I asked sql to covnert icd-10 code categories (listed below) into cancer type, including values with any number of characters after them. 

C00-C14  Malignant neoplasms of lip, oral cavity and pharynx
C15-C26  Malignant neoplasms of digestive organs
C30-C39  Malignant neoplasms of respiratory and intrathoracic organs
C40-C41  Malignant neoplasms of bone and articular cartilage
C43-C44  Melanoma and other malignant neoplasms of skin
C45-C49  Malignant neoplasms of mesothelial and soft tissue
C50-C50  Malignant neoplasms of breast
C51-C58  Malignant neoplasms of female genital organs

PERSONAL NOTES:
- Based on the claims data, the total amount paid was the amount paid by the insurer. In the Medical Claims table, two columns related to dollars paid wer empty, allowed amount and total_cost_amount. I defaulted to using paid amount to calculate Total Paid amount because of 2 reasons. 1) It was the only paid column with data & 2) copayment_amount was empty and it is the value charged (not paid). If I were to work on this project further, I would ask if the formula [Total Paid = paid_amount + copayment_amount] makes sense from a business perspective. 

Thanks for reading!

