DROP TABLE 3nf_hospitals;

CREATE TABLE 3nf_hospitals AS
SELECT
	cast(provider_id as decimal(6,0)) provider_id,
	hospital_name,
	city,
	state,
	case
		when meets_criteria_for_meaningful_use_of_ehrs like 'Y' then 1
		else 0
		end as meets_criteria_for_meaningful_use_of_ehrs,
	cast(hospital_overall_rating as decimal(1,0)) hospital_overall_rating, 
	case
		when mortality_national_comparison like 'Same%' then 0
		when mortality_national_comparison like 'Above%' then 1
		when mortality_national_comparison like 'Below%' then -1
		end as mortality_national_comparison,
	case
		when safety_of_care_national_comparison like 'Same%' then 0
		when safety_of_care_national_comparison like 'Above%' then 1
		when safety_of_care_national_comparison like 'Below%' then -1
		end as safety_of_care_national_comparison,
	case
		when readmission_national_comparison like 'Same%' then 0
		when readmission_national_comparison like 'Above%' then 1
		when readmission_national_comparison like 'Below%' then -1
		end as readmission_national_comparison,
	case
		when patient_experience_national_comparison like 'Same%' then 0
		when patient_experience_national_comparison like 'Above%' then 1
		when patient_experience_national_comparison like 'Below%' then -1
		end as patient_experience_national_comparison,
	case
		when effectiveness_of_care_national_comparison like 'Same%' then 0
		when effectiveness_of_care_national_comparison like 'Above%' then 1
		when effectiveness_of_care_national_comparison like 'Below%' then -1
		end as effectiveness_of_care_national_comparison,
	case
		when timeliness_of_care_national_comparison like 'Same%' then 0
		when timeliness_of_care_national_comparison like 'Above%' then 1
		when timeliness_of_care_national_comparison like 'Below%' then -1
		end as timeliness_of_care_national_comparison,
	case
		when efficient_use_of_medical_imaging_national_comparison like 'Same%' then 0
		when efficient_use_of_medical_imaging_national_comparison like 'Above%' then 1
		when efficient_use_of_medical_imaging_national_comparison like 'Below%' then -1
		end as efficient_use_of_medical_imaging_national_comparison
FROM hospitals;




DROP TABLE 3nf_effective_care;

CREATE TABLE 3nf_effective_care AS
SELECT
	cast(provider_id as decimal(6,0)) provider_id,
	measure_id,
	cast(score as decimal(4,0)) score,
	cast(sample as decimal(6,0)) sample
FROM effective_care;




DROP TABLE 3nf_readmissions;

CREATE TABLE 3nf_readmissions AS
SELECT
	cast(provider_id as decimal(6,0)) provider_id,
	measure_id,
	case
		when compared_to_national like 'No Different%' then 0
		when compared_to_national like 'Better%' then 1
		when compared_to_national like 'Worse%' then -1
		else null
		end as national_comparison,
	cast(score as decimal(3,1)) score,
	cast(denominator as decimal(5,0)) sample,
	cast(lower_estimate as decimal(3,1)) lower_estimate,
	cast(higher_estimate as decimal(3,1)) higher_estimate
FROM readmissions;




DROP TABLE 3nf_measures;

CREATE TABLE 3nf_measures AS
SELECT
	ms.measure_id measure_id,
	ms.measure_name measure_name,
	CAST (CONCAT(SUBSTR(ms.measure_start_date, 7, 4),
				'-',
				SUBSTR(ms.measure_start_date, 1, 2),
				'-',
				SUBSTR(ms.measure_start_date, 4, 2)
				)
		AS date) AS measure_start_date,
	CAST (CONCAT (SUBSTR(ms.measure_end_date, 7, 4),
				'-',
				SUBSTR(ms.measure_end_date, 1, 2),
				'-',
				SUBSTR(ms.measure_end_date, 4, 2)
				)
		AS date) AS measure_end_date
FROM measures ms 
INNER JOIN 
(select distinct measure_id from effective_care
union select distinct measure_id from readmissions) i
ON ms.measure_id = i.measure_id

UNION

SELECT
	ec.measure_id measure_id,
	ec.measure_name measure_name,
	CAST (CONCAT(SUBSTR(ec.measure_start_date, 7, 4),
				'-',
				SUBSTR(ec.measure_start_date, 1, 2),
				'-',
				SUBSTR(ec.measure_start_date, 4, 2)
				)
		AS date) AS measure_start_date,
	CAST (CONCAT (SUBSTR(ec.measure_end_date, 7, 4),
				'-',
				SUBSTR(ec.measure_end_date, 1, 2),
				'-',
				SUBSTR(ec.measure_end_date, 4, 2)
				)
		AS date) AS measure_end_date	
FROM effective_care ec
WHERE ec.measure_id = "IMM_3_OP_27_FAC_ADHPCT";





DROP TABLE 3nf_survey_references;

CREATE TABLE 3nf_survey_references AS
SELECT  *
FROM    (   SELECT  
			"communication_with_nurses" as dimension,
			"minimum" as subdimension,
			cast(communication_with_nurses_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i1 
UNION
SELECT  *
FROM    (   SELECT  
			"communication_with_nurses" as dimension,
			"median" as subdimension,
			cast(communication_with_nurses_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i2
UNION
SELECT  *
FROM    (   SELECT  
			"communication_with_nurses" as dimension,
			"benchmark" as subdimension,
			cast(communication_with_nurses_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i3

UNION

SELECT  *
FROM    (   SELECT  
			"communication_with_doctors" as dimension,
			"minimum" as subdimension,
			cast(communication_with_doctors_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i4 
UNION
SELECT  *
FROM    (   SELECT  
			"communication_with_doctors" as dimension,
			"median" as subdimension,
			cast(communication_with_doctors_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i5
UNION
SELECT  *
FROM    (   SELECT  
			"communication_with_doctors" as dimension,
			"benchmark" as subdimension,
			cast(communication_with_doctors_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i6

UNION

SELECT  *
FROM    (   SELECT  
			"responsiveness_of_hospital_staff" as dimension,
			"minimum" as subdimension,
			cast(responsiveness_of_hospital_staff_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i7 
UNION
SELECT  *
FROM    (   SELECT  
			"responsiveness_of_hospital_staff" as dimension,
			"median" as subdimension,
			cast(responsiveness_of_hospital_staff_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i8
UNION
SELECT  *
FROM    (   SELECT  
			"responsiveness_of_hospital_staff" as dimension,
			"benchmark" as subdimension,
			cast(responsiveness_of_hospital_staff_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i9

UNION

SELECT  *
FROM    (   SELECT  
			"pain_management" as dimension,
			"minimum" as subdimension,
			cast(pain_management_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i10 
UNION
SELECT  *
FROM    (   SELECT  
			"pain_management" as dimension,
			"median" as subdimension,
			cast(pain_management_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i11
UNION
SELECT  *
FROM    (   SELECT  
			"pain_management" as dimension,
			"benchmark" as subdimension,
			cast(pain_management_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i12

UNION

SELECT  *
FROM    (   SELECT  
			"communication_about_medicines" as dimension,
			"minimum" as subdimension,
			cast(communication_about_medicines_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i13 
UNION
SELECT  *
FROM    (   SELECT  
			"communication_about_medicines" as dimension,
			"median" as subdimension,
			cast(communication_about_medicines_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i14
UNION
SELECT  *
FROM    (   SELECT  
			"communication_about_medicines" as dimension,
			"benchmark" as subdimension,
			cast(communication_about_medicines_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i15

UNION

SELECT  *
FROM    (   SELECT  
			"cleanliness_and_quietness_of_hospital_environment" as dimension,
			"minimum" as subdimension,
			cast(cleanliness_and_quietness_of_hospital_environment_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i16 
UNION
SELECT  *
FROM    (   SELECT  
			"cleanliness_and_quietness_of_hospital_environment" as dimension,
			"median" as subdimension,
			cast(cleanliness_and_quietness_of_hospital_environment_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i17
UNION
SELECT  *
FROM    (   SELECT  
			"cleanliness_and_quietness_of_hospital_environment" as dimension,
			"benchmark" as subdimension,
			cast(cleanliness_and_quietness_of_hospital_environment_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i18

UNION

SELECT  *
FROM    (   SELECT  
			"discharge_information" as dimension,
			"minimum" as subdimension,
			cast(discharge_information_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i19 
UNION
SELECT  *
FROM    (   SELECT  
			"discharge_information" as dimension,
			"median" as subdimension,
			cast(discharge_information_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i20
UNION
SELECT  *
FROM    (   SELECT  
			"discharge_information" as dimension,
			"benchmark" as subdimension,
			cast(discharge_information_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i21

UNION

SELECT  *
FROM    (   SELECT  
			"overall_rating_of_hospital" as dimension,
			"minimum" as subdimension,
			cast(overall_rating_of_hospital_floor as decimal(4,2)) score			 
            FROM    surveys_responses 
            LIMIT 1
        ) i22 
UNION
SELECT  *
FROM    (   SELECT  
			"overall_rating_of_hospital" as dimension,
			"median" as subdimension,
			cast(overall_rating_of_hospital_achievement_threshold as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i23
UNION
SELECT  *
FROM    (   SELECT  
			"overall_rating_of_hospital" as dimension,
			"benchmark" as subdimension,
			cast(overall_rating_of_hospital_benchmark as decimal(4,2)) score
            FROM    surveys_responses 
            LIMIT 1
        ) i24
ORDER BY dimension;





DROP TABLE 3nf_surveys_responses;

CREATE TABLE 3nf_surveys_responses AS
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"communication_with_nurses" as dimension,
			"baseline_rate" as subdimension,
			cast(communication_with_nurses_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"communication_with_nurses" as dimension,
			"performance_rate" as subdimension,
			cast(communication_with_nurses_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"communication_with_doctors" as dimension,
			"baseline_rate" as subdimension,
			cast(communication_with_doctors_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"communication_with_doctors" as dimension,
			"performance_rate" as subdimension,
			cast(communication_with_doctors_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"responsiveness_of_hospital_staff" as dimension,
			"baseline_rate" as subdimension,
			cast(responsiveness_of_hospital_staff_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"responsiveness_of_hospital_staff" as dimension,
			"performance_rate" as subdimension,
			cast(responsiveness_of_hospital_staff_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"pain_management" as dimension,
			"baseline_rate" as subdimension,
			cast(pain_management_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"pain_management" as dimension,
			"performance_rate" as subdimension,
			cast(pain_management_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"communication_about_medicines" as dimension,
			"baseline_rate" as subdimension,
			cast(communication_about_medicines_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses  
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"communication_about_medicines" as dimension,
			"performance_rate" as subdimension,
			cast(communication_about_medicines_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"cleanliness_and_quietness_of_hospital_environment" as dimension,
			"baseline_rate" as subdimension,
			cast(cleanliness_and_quietness_of_hospital_environment_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"cleanliness_and_quietness_of_hospital_environment" as dimension,
			"performance_rate" as subdimension,
			cast(cleanliness_and_quietness_of_hospital_environment_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"discharge_information" as dimension,
			"baseline_rate" as subdimension,
			cast(discharge_information_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"discharge_information" as dimension,
			"performance_rate" as subdimension,
			cast(discharge_information_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"overall_rating_of_hospital" as dimension,
			"baseline_rate" as subdimension,
			cast(overall_rating_of_hospital_baseline_rate as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"overall_rating_of_hospital" as dimension,
			"performance_rate" as subdimension,
			cast(overall_rating_of_hospital_performance_rate as decimal(4,2)) score
            FROM    surveys_responses 

UNION

SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"hcahps" as dimension,
			"base_score" as subdimension,
			cast(hcahps_base_score as decimal(4,2)) score
            FROM    surveys_responses 
UNION
SELECT  
			cast(provider_number as decimal(6,0)) provider_id,
			"hcahps" as dimension,
			"consistency_score" as subdimension,
			cast(hcahps_consistency_score as decimal(4,2)) score
            FROM    surveys_responses 

ORDER BY dimension;

