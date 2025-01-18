-- SQL Queries for Healthcare Database Analysis

--- 1. Retrieve each doctor's first name, last name, and specialty ---

SELECT 
    first_name,
    last_name,
    specialty
FROM 
    doctors;

--- 2. Generate a descriptive string for each doctor ---

SELECT
    CONCAT(first_name, ' ', last_name, ' has specialty ', specialty) AS doctor_description
FROM 
    doctors;

--- 3. Find the minimum and maximum weight in the dataset ---

SELECT 
    MIN(weight) AS min_weight,
    MAX(weight) AS max_weight
FROM 
    patients;

--- 4. Retrieve patient names and weights in descending order ---

SELECT 
    first_name,
    last_name,
    weight
FROM 
    patients
ORDER BY 
    weight DESC;

--- 5. Retrieve the patient with the maximum weight ---
-- Option 1: Using MAX function.

SELECT 
    first_name,
    last_name,
    MAX(weight) AS max_weight
FROM 
    patients;

-- Option 2: Using ORDER BY and LIMIT.

SELECT 
    first_name,
    last_name,
    weight
FROM 
    patients
ORDER BY 
    weight DESC
LIMIT 1;

--- 6. Retrieve patients with weight between 100 and 120, ordered by weight ascending ---

SELECT 
    first_name,
    last_name,
    weight
FROM 
    patients
WHERE 
    weight BETWEEN 100 AND 120
ORDER BY 
    weight ASC;

--- 7. Find patients from Hamilton with allergies ---
-- Retrieve first name, last name, and allergies for patients in Hamilton with non-empty allergy fields.

SELECT 
    first_name,
    last_name,
    allergies
FROM 
    patients
WHERE 
    allergies IS NOT NULL 
    AND city = 'Hamilton';

--- 8. Find the top 5 diagnoses by number of cases ---

SELECT 
    diagnosis,
    COUNT(diagnosis) AS count_cases
FROM 
    admissions
GROUP BY 
    diagnosis
ORDER BY 
    count_cases DESC
LIMIT 5;

--- 9. Retrieve the most recent admission for patient with ID 35 ---

SELECT *
FROM 
    admissions
WHERE 
    patient_id = 35
ORDER BY 
    admission_date DESC
LIMIT 1;

--- 10. Retrieve the most recent admission for the most common diagnosis ---

SELECT *
FROM 
    admissions
WHERE 
    diagnosis = (
        SELECT 
            diagnosis
        FROM 
            admissions
        GROUP BY 
            diagnosis
        ORDER BY 
            COUNT(diagnosis) DESC
        LIMIT 1
    )
ORDER BY 
    admission_date DESC
LIMIT 1;

--- 11. Find unique patient names starting and ending with 'S' and count them ---

SELECT 
    DISTINCT first_name,
    SUM(CASE WHEN first_name LIKE 'S%s' THEN 1 ELSE 0 END) AS counts
FROM 
    patients
WHERE 
    first_name LIKE 'S%s'
GROUP BY 
    first_name
ORDER BY 
    counts DESC;

--- 12. Calculate admission costs by insurance status ---
-- Patients with even IDs have insurance.

SELECT
    CASE 
        WHEN patient_id % 2 = 0 THEN 'YES' 
        ELSE 'NO' 
    END AS has_insurance,
    SUM(CASE WHEN patient_id % 2 = 0 THEN 10 ELSE 50 END) AS insurance_cost
FROM 
    admissions
GROUP BY 
    has_insurance;

--- 13. Count male and female patients by province with filtering ---
-- Include only provinces with more than 20 patients total, sorted by male count descending.

SELECT 
    prn.province_name,
    SUM(CASE WHEN p.gender = 'F' THEN 1 ELSE 0 END) AS Female,
    SUM(CASE WHEN p.gender = 'M' THEN 1 ELSE 0 END) AS Male
FROM 
    patients p
JOIN 
    province_names prn ON p.province_id = prn.province_id
GROUP BY 
    prn.province_name
HAVING 
    (Male + Female) > 20
ORDER BY 
    Male DESC;

--- 14. Retrieve details of the 5 lightest patients ---

SELECT 
    patient_id,
    weight,
    height,
    birth_date
FROM 
    patients
ORDER BY 
    weight ASC
LIMIT 5;

--- 15. Add age to the details of the lightest patients ---
-- Include the age (rounded to 2 decimal places) at the time of their admission.

SELECT 
    p.patient_id,
    weight,
    height,
    birth_date,
    ROUND((JULIANDAY(admission_date) - JULIANDAY(birth_date)) / 365, 2) AS patient_years
FROM 
    patients p 
JOIN 
    admissions a ON p.patient_id = a.patient_id
ORDER BY 
    weight ASC
LIMIT 5;
