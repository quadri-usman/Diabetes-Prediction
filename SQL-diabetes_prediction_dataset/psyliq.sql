-- Retrieving the overall raw data
select * from psyliq..Diabetes_prediction$

--Retrieve the Patient_id and ages of all patients
select Patient_id, age 
from psyliq..Diabetes_prediction$

-- Select all female patients who are older than 40.
select * from psyliq..Diabetes_prediction$
where gender = 'female' and age >40
order by age asc

-- Calculate the average BMI of patients.
select avg(bmi) as AverageBMI, SUM(bmi)/COUNT(Patient_id) 'Average BMI'
 from psyliq..Diabetes_prediction$

-- List patients in descending order of blood glucose levels.
select * from psyliq..Diabetes_prediction$
 order by blood_glucose_level desc

 -- Find patients who have hypertension and diabetes
select * from psyliq..Diabetes_prediction$
where hypertension = 1 and diabetes = 1
order by diabetes asc
-- Determine the number of patients with heart disease.
select count(heart_disease) as Heart_DiseasePatients from psyliq..Diabetes_prediction$
where heart_disease = 1

-- Group patients by smoking history and count how many smokers and nonsmokers there are.
select smoking_history, COUNT(smoking_history) 
from psyliq..Diabetes_prediction$
group by smoking_history

-- Retrieve the Patient_ids of patients who have a BMI greater than the average BMI
select Patient_id, bmi from psyliq..Diabetes_prediction$
where bmi>(SELECT AVG(bmi) FROM psyliq..Diabetes_prediction)
--order by bmi asc
-- Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel
select *
from psyliq..Diabetes_prediction$
-- where HbA1c_level = 9
order by HbA1c_level desc

select *
from psyliq..Diabetes_prediction$
-- where HbA1c_level = 3.5
order by HbA1c_level

-- Calculate the age of patients in years (assuming the current date as of now).
SELECT EmployeeName, Patient_id,
       2023 - age AS Birth_Years,
       age AS current_age
FROM psyliq..Diabetes_prediction$
order by Birth_Years

-- Rank patients by blood glucose level within each gender group
SELECT 
    Patient_id,
    gender,
    blood_glucose_level,
    RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level) AS glucose_level_rank
FROM psyliq..Diabetes_prediction$

-- Update the smoking history of patients who are older than 50 to "Ex-smoker."
UPDATE psyliq..Diabetes_prediction$
SET smoking_history = 'Ex-smoker'
WHERE age > 50

select age, smoking_history from psyliq..Diabetes_prediction$
where age>50

-- Insert a new patient into the database with sample data.
INSERT INTO psyliq..Diabetes_prediction$(EmployeeName, Patient_id, gender, 
age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, 
blood_glucose_level, diabetes)
VALUES('Sandra Andrew', 'PT188882', 'Male', 35, 0, 0, 'current', 26.5, 6.0, 120, 0)

select * from psyliq..Diabetes_prediction$
where EmployeeName = 'Sandra Andrew'

-- Delete all patients with heart disease from the database.
delete from psyliq..Diabetes_prediction$
where heart_disease = 1

-- Find patients who have hypertension but not diabetes using the EXCEPT operator.
SELECT Patient_id, hypertension, diabetes
FROM psyliq..Diabetes_prediction$ AS d1
WHERE hypertension = 1 AND NOT EXISTS (
    SELECT 1
    FROM psyliq..Diabetes_prediction$ AS d2
    WHERE d1.Patient_id = d2.Patient_id AND d2.diabetes = 1
)
order by diabetes desc

-- Define a unique constraint on the "patient_id" column to ensure its values are unique
ALTER TABLE psyliq..Diabetes_prediction$
ADD CONSTRAINT uniquePatient_id UNIQUE (Patient_id);

-- Create a view that displays the Patient_ids, ages, and BMI of patients.
CREATE VIEW patientView as
SELECT Patient_id, age, bmi
FROM psyliq..Diabetes_prediction$

SELECT * FROM patient_view;

-- Suggest improvements in the database schema to reduce data redundancy and improve data integrity
