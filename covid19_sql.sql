CREATE database dataset;
use dataset;
show tables;

# 1)Find the number of corona patients who faced shortness of breath.
SELECT DISTINCT(count(shortness_of_breath))as corona_patients from corona_tested_006
WHERE corona = 'positive' and shortness_of_breath = 'True';


# 2)Find the number of negative corona patients who have fever and sore_throat. 

SELECT DISTINCT(count(fever and sore_throat))as Negative_corona_patients from corona_tested_006
WHERE corona = 'negative' and fever = 'True' and sore_throat = 'True';



# 3)Group the data by month and rank the number of positive cases.

SELECT DATE_FORMAT(Test_date, '%d-%m-%y')as month, count(Test_date)as positive_cases FROM corona_tested_006 
WHERE corona = 'positive' GROUP BY month
ORDER BY positive_cases and Test_date;


# 4)Find the female negative corona patients who faced cough and headache.

SELECT count(*)as female_Negative_corona_patients FROM corona_tested_006
WHERE corona = 'negative' and Cough_symptoms = 'True' and Headache = 'True' and Sex = 'Female';

# 5)How many elderly corona patients have faced breathing problems?

SELECT count(*)as elderly_corona_patients FROM corona_tested_006 
WHERE Age_60_above = True and Corona = 'positive' and Shortness_of_breath = True;

select count(*) as elderly_corona_patients from corona_tested_006 
where shortness_of_breath='True';

# 6)Which three symptoms were more common among COVID positive patients?
SELECT symptom,count(*)as count FROM(SELECT 
	CASE 
		WHEN Fever = 'True' THEN 'Fever'
		WHEN Cough_symptoms = 'True' THEN 'Cough'
		WHEN Sore_throat = 'True'THEN 'Sore throat'
		WHEN Shortness_of_breath = 'True' THEN 'Shortness of breath'
		WHEN Headache = 'True' THEN 'Headache'
	ELSE NULL
        END AS symptom,Corona
        FROM corona_tested_006
WHERE Corona = 'positive')as covid_symptoms
WHERE symptom IS NOT NULL
GROUP BY symptom
ORDER BY count DESC LIMIT 3;

# 7)Which symptom was less common among COVID negative people?

SELECT symptom,count(*)as count FROM (SELECT 
CASE 
	WHEN Fever = 'True' THEN 'Fever'
	WHEN Cough_symptoms = 'True' THEN 'Cough'
	WHEN Sore_throat = 'True' THEN 'Sore throat'
	WHEN Shortness_of_breath = 'True' THEN 'Shortness of breath'
	WHEN Headache = 'True' THEN 'Headache'
ELSE NULL
	END as symptom,Corona 
    FROM corona_tested_006
    WHERE Corona = 'negative') as non_covid_symptoms
WHERE symptom IS NOT NULL
GROUP BY symptom
ORDER BY count ASC LIMIT 1;

# 8)What are the most common symptoms among COVID positive males whose known contact was abroad?

SELECT symptom,count(*)as count FROM(SELECT 
        CASE 
            WHEN Fever = 'True' THEN 'Fever'
            WHEN Cough_symptoms = 'True' THEN 'Cough'
            WHEN Sore_throat = 'True' THEN 'Sore throat'
            WHEN Shortness_of_breath = 'True' THEN 'Shortness of breath'
            WHEN Headache = 'True' THEN 'Headache'
            ELSE NULL
        END AS symptom,Corona,Sex,Known_contact FROM corona_tested_006
WHERE Corona = 'positive' and Sex = 'male' and Known_contact = 'Abroad')as covid_symptoms
WHERE symptom IS NOT NULL
GROUP BY symptom
ORDER BY count DESC;