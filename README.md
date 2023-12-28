# Patient Data: Diabetes Prediction
## Introduction
Hospitals (especially the general hospitals) are always crowded on daily basis. Among the major patients visiting or being admitted in hospitals are those with deadly and serious diseases like hypertension, diabetes etc. In this analysis, patients with diabetes along with its other related problems were queried.
## Analysis Questions:
1. Retrieve the Patient_id and ages of all patients.
2. Select all female patients who are older than 40.
3. Calculate the average BMI of patients.
4. List patients in descending order of blood glucose levels.
5. Find patients who have hypertension and diabetes.
6. Determine the number of patients with heart disease.
7. Group patients by smoking history and count how many smokers and nonsmokers there are.
8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
10. Calculate the age of patients in years (assuming the current date as of now).
11. Rank patients by blood glucose level within each gender group.
12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
13. Insert a new patient into the database with sample data.
14. Delete all patients with heart disease from the database.
15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
17. Create a view that displays the Patient_ids, ages, and BMI of patients.
18. Suggest improvements in the database schema to reduce data redundancy and improve data integrity.
19. Explain how you can optimize the performance of SQL queries on this dataset.
## Project Tool Used: SQL
## Analysis Insights and Results
1. The Patient_id and ages of all patients are shown below.  The samples patients are 10,000 in number.
2. Female patients who are older than 40 are 31,155. 
3. The average BMI of patients is calculated to be 27.32
4. Below is the list of patients in descending order of blood glucose levels
5. Patients with hypertension and diabetes are two thousand and eighty-eight (2,088)
6. The patients with heart disease are three thousand, nine hundred and forty-two (3,942).
7. By grouping the patients based on smoking history, smokers are found to be 29,089 while non-smokers are found to be 35,095. Therefore, majority of the sampled patients are non-smokers.
8. The patients (with BMI) above the average BMI are 59,563 and this means they are more than those below the average BMI.
9. The patient with the highest HbA1c level among others is Michael Thompson while the patient with the lowest HbA1c level is Ellen Moffatt. Those with lowest HbA1c level (3.5) are 7,451 while those with highest HbA1c level (9) are 556.
10. The oldest patients are found to be 80years with 1984 as their year of birth
11. More females have lesser blood glucose level than males.
12. The patients who are older than 50 are 38,463 in number and their smoking history was updated to "Ex-smoker" as shown below.
13. A new patient with the patient_id “PT188882” is inserted into the database as shown below.
14. All patients with heart disease (3942) were deleted from the database with the query below.
15. The patients with hypertension but not diabetes are 4,839
16. A unique constraint on the "patient_id" was done with the following query.
17. A view that displays the Patient_ids, ages, and BMI of patients 
18. The current diabetes database schema exhibits a solid foundation, yet there’s room for optimization. The database schema can be improved through the following:
i. Splitting Patient Information: Patient information could be broken into separate tables to avoid redundant data. A patients’ table could be created to store general patient details (name, gender, age) and a health_metrics’ table to store health-related information.
ii. Data Validation for Precision: Cconstraints or triggers to ensure age and health metrics fall within reasonable ranges can be implemented to promote accurate and reliable data.
iii. Documentation for Clarity: Relationships, foreign keys, and constraints should be documented to facilitate understanding for future developers working with the schema.
iv. Constraints for Data Integrity: Appropriate constraints, such as foreign key constraints should be added to maintain referential integrity between tables.
v. Review and Refine Data Types: Data types should be evaluated and refined to ensure they align optimally with the nature of the stored data.
19. Optimizing the performance of SQL queries on this dataset involves various strategies to enhance efficiency and reduce query execution times. Below are some key considerations and optimization techniques:
i. Indexing Columns: Frequently queried columns can be identified and indexed to enhance query performance.
ii. Selective Retrieval for Precision: When crafting SELECT statements, the needed columns should be queried. Instead of opting for SELECT *, only the necessary fields should be selectively retrieved. This reduces data transfer volumes and speeds up query execution.
iii. Avoid SELECT DISTINCT: While SELECT DISTINCT is a powerful tool, it can be resource-intensive. Its usage should be avoided while alternative approaches can be explored if possible. 
iv. Limiting Results with LIMIT: For queries that potentially return large result sets, LIMIT clause should be used to restrict the number of rows returned. This is particularly beneficial for paginated displays and can significantly enhance query performance.
v. Harnessing the Power of Caching: Caching mechanisms at the database or application level can be used to store frequently used query results. Caching is a valuable strategy for queries involving relatively static data.
vi. Parameterized Queries for Security and Efficiency: To safeguard against SQL injection risks and to improve the efficiency of query execution plans, parameterized queries can be embraced especially for frequently reused queries with different parameter values.
 
Conclusion
In this analysis, diabetes_prediction data has been explored with SQL along with schema improvement, and query optimization. From different insights in patient records to create a more efficient database structure and fine-tuning SQL queries, each step contributes to a more insightful and responsive data experience.
The Overall SQL Queries
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

Dashboard
![Screenshot (205)](https://github.com/quadri-usman/Diabetes-Prediction/assets/105228467/15d74cbb-3be6-4098-8430-324f62fc8ae0)
