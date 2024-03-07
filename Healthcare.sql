-- Retrieve basic information about all patients
SELECT first
	   ,last
	   ,birthdate
	   ,ssn
	   ,passport
	   ,id
from public.patients

-- List all unique encounter classes recorded in encounters
SELECT distinct encounterclass
from public.encounters

-- Select all encounters that are ICU admissions for inpatients
SELECT * 
from public.encounters
where encounterclass = 'inpatient'
  and description = 'ICU Admission'

-- Select all inpatient ICU admissions within the year 2023
SELECT * 
from public.encounters
where encounterclass = 'inpatient'
  and description = 'ICU Admission'
  and stop >= '2023-01-01 00:00'
  and stop <= '2023-12-31 23:59'

-- Select all encounters classified as either outpatient or ambulatory
SELECT * 
from public.encounters
where encounterclass in ('outpatient', 'ambulatory')

-- Select conditions diagnosed more than 5000 times, ordered by frequency
SELECT description, 
	   count(*) as count_of_cond
from public.conditions
group by description
having count(*) > 5000
order by count(*) desc

-- Select conditions, excluding specific BMI range, diagnosed more than 5000 times
SELECT description, 
	   count(*) as count_of_cond
from public.conditions
where description != 'Body Mass Index 30.0-30.9, adult'
group by description
having count(*) > 5000
order by count(*) desc

-- Select all patients residing in Boston
SELECT * 
from public.patients
WHERE city = 'Boston'

Select all conditions matching a list of specific codes
SELECT * 
from public.conditions
where code in ('585.1', '585.2', '585.3', '585.4')

-- Count patients in each city, excluding Boston, with at least 100 residents, ordered by count descendent
SELECT city, count(*)
from public.patients
where city != 'Boston'
group by city
Having count(*)>= 100
order by count(*) desc

-- Select all records from immunizations
SELECT * from public.immunizations

-- Select immunization records joined with patient's basic information
SELECT t1.*,
	   t2.first,
	   t2.last,
	   t2.birthdate
from public.immunizations as t1
left join public.patients as t2
  on t1.patient = t2.id