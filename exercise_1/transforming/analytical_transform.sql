DROP TABLE analytical_procedures_stats;

CREATE TABLE analytical_procedures_stats AS
SELECT
	measure_id,
	min(score) as minimum, 
	max(score) as maximum, 
	PERCENTILE_APPROX(score, 0.5) as median, 
	AVG(score) as mean,
	STDDEV_SAMP(score) as std_dev,
	STDDEV_SAMP(score) / SQRT(COUNT(score)) as std_err,
	COUNT(score) as hospitals_count,
	(AVG(score) - (1.96* STDDEV_SAMP(score) / SQRT(COUNT(score)))) as lower_ci,
	(AVG(score) + (1.96* STDDEV_SAMP(score) / SQRT(COUNT(score)))) as upper_ci
FROM 3nf_effective_care GROUP BY measure_id

UNION

SELECT
	measure_id,
	min(score) as minimum, 
	max(score) as maximum,  
	PERCENTILE_APPROX(score, 0.5) as median, 
	AVG(score) as mean,
	STDDEV_SAMP(score) as std_dev,
	STDDEV_SAMP(score) / SQRT(COUNT(score)) as std_err,
	COUNT(score) as hospitals_count,
	(AVG(score) - (1.96* STDDEV_SAMP(score) / SQRT(COUNT(score)))) as lower_ci,
	(AVG(score) + (1.96* STDDEV_SAMP(score) / SQRT(COUNT(score)))) as upper_ci
FROM 3nf_readmissions GROUP BY measure_id;




DROP TABLE intermediate_procedures;

CREATE TABLE intermediate_procedures AS
SELECT 
	re.provider_id as provider_id,
	re.measure_id as measure_id,
	hp.hospital_name as hospital_name,
	hp.state as state,
	re.score as measure_score,
	((re.score - st.mean)/st.std_dev) as standardized_score,
	CASE
		when me.measure_name like "%Mortality%" then ((re.score - st.mean)/st.std_dev)*4
		when me.measure_name like "%Readmission%" then ((re.score - st.mean)/st.std_dev)*4
		when me.measure_name like "Influenza%" then ((re.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Hospital%" then ((re.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Thrombolytic%" then ((re.score - st.mean)/st.std_dev)*3	
		when me.measure_name like "Elective%" then ((re.score - st.mean)/st.std_dev)*3		 	 
		when me.measure_name like "Healthcare%" then ((re.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Colonoscopy%" then ((re.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Venous%" then ((re.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Median Time%" then ((re.score - st.mean)/st.std_dev)*2
		when me.measure_name like "%Within 30 Minutes%" then ((re.score - st.mean)/st.std_dev)*2
		when me.measure_name like "Admit Decision Time%" then ((re.score - st.mean)/st.std_dev)*2
		when me.measure_name like "%Within 45 minutes%" then ((re.score - st.mean)/st.std_dev)*2		 	
		when me.measure_name like "%at Arrival" then ((re.score - st.mean)/st.std_dev)*2
		when me.measure_name like "Emergency%" then ((re.score - st.mean)/st.std_dev)*2		 
		when me.measure_name like "Left without being seen" then ((re.score - st.mean)/st.std_dev)*2
		else ((re.score - st.mean)/st.std_dev)*1
	end as weighted_standardized_score
FROM 3nf_readmissions re 
INNER JOIN analytical_procedures_stats st
ON re.measure_id = st.measure_id
INNER JOIN 3nf_hospitals hp
ON re.provider_id = hp.provider_id
INNER JOIN 3nf_measures me
ON re.measure_id = me.measure_id

UNION

SELECT 
	ec.provider_id as provider_id,
	ec.measure_id as measure_id,
	hp.hospital_name as hospital_name,
	hp.state as state,
	ec.score as measure_score,
	((ec.score - st.mean)/st.std_dev) as standardized_score,
	CASE
		when me.measure_name like "%Mortality%" then ((ec.score - st.mean)/st.std_dev)*4
		when me.measure_name like "%Readmission%" then ((ec.score - st.mean)/st.std_dev)*4
		when me.measure_name like "Influenza%" then ((ec.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Hospital%" then ((ec.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Thrombolytic%" then ((ec.score - st.mean)/st.std_dev)*3	
		when me.measure_name like "Elective%" then ((ec.score - st.mean)/st.std_dev)*3		 	 
		when me.measure_name like "Healthcare%" then ((ec.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Colonoscopy%" then ((ec.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Venous%" then ((ec.score - st.mean)/st.std_dev)*3
		when me.measure_name like "Median Time%" then ((ec.score - st.mean)/st.std_dev)*2
		when me.measure_name like "%Within 30 Minutes%" then ((ec.score - st.mean)/st.std_dev)*2
		when me.measure_name like "Admit Decision Time%" then ((ec.score - st.mean)/st.std_dev)*2
		when me.measure_name like "%Within 45 minutes%" then ((ec.score - st.mean)/st.std_dev)*2		 	
		when me.measure_name like "%at Arrival" then ((ec.score - st.mean)/st.std_dev)*2
		when me.measure_name like "Emergency%" then ((ec.score - st.mean)/st.std_dev)*2		 
		when me.measure_name like "Left without being seen" then ((ec.score - st.mean)/st.std_dev)*2
		else ((ec.score - st.mean)/st.std_dev)*1
	end as weighted_standardized_score
FROM 3nf_effective_care ec 
INNER JOIN analytical_procedures_stats st
ON ec.measure_id = st.measure_id
INNER JOIN 3nf_hospitals hp
ON ec.provider_id = hp.provider_id
INNER JOIN 3nf_measures me
ON ec.measure_id = me.measure_id;





DROP TABLE analytical_survey_stats;

CREATE TABLE analytical_survey_stats AS
SELECT 
	dimension,
	MIN(score) as minimum,
	MAX(score) as maximum,
	PERCENTILE_APPROX(score, 0.5) as median,
	AVG(score) as mean,
	STDDEV_SAMP(score) as std_dev,
	STDDEV_SAMP(score) / SQRT(COUNT(score)) as std_err,
	COUNT(score) as hospitals_count,
	(AVG(score) - (1.96* STDDEV_SAMP(score) / SQRT(COUNT(score)))) as lower_ci,
	(AVG(score) + (1.96* STDDEV_SAMP(score) / SQRT(COUNT(score)))) as upper_ci
FROM 3nf_surveys_responses
WHERE subdimension LIKE 'performance_rate'
GROUP by dimension;




DROP TABLE analytical_procedures_by_provider;

CREATE TABLE analytical_procedures_by_provider AS
SELECT  
	i.provider_id as provider_id,
	j.hospital_name as hospital_name,
	i.procedures_mean as procedures_mean,
	i.procedures_std_dev as procedures_std_dev,
	i.procedures_std_err as procedures_std_err,
	i.procedures_available as procedures_available,
	i.procedures_lower_ci as procedures_lower_ci,
	i.procedures_upper_ci as procedures_upper_ci
FROM
(SELECT 
	provider_id,
	AVG(weighted_standardized_score) as procedures_mean,
	STDDEV_SAMP(weighted_standardized_score) as procedures_std_dev,
	((AVG(weighted_standardized_score) + (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score)))) - (AVG(weighted_standardized_score) - (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score))))) as procedures_std_err,
	COUNT(weighted_standardized_score) as procedures_available,
	(AVG(weighted_standardized_score) - (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score)))) as procedures_lower_ci,
	(AVG(weighted_standardized_score) + (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score)))) as procedures_upper_ci
	FROM intermediate_procedures
	WHERE weighted_standardized_score IS NOT NULL
	GROUP BY provider_id
	HAVING COUNT(weighted_standardized_score) > 17) as i
INNER JOIN
(SELECT 
	provider_id, hospital_name FROM 3nf_hospitals) as j
ON i.provider_id = j.provider_id;



DROP TABLE analytical_procedures_by_state;

CREATE TABLE analytical_procedures_by_state AS
SELECT
inp.state as state,
count(DISTINCT inp.provider_id)/MAX(sub.state_total) as hospital_participation_ratio,
AVG(weighted_standardized_score) as procedures_mean,
STDDEV_SAMP(weighted_standardized_score) as procedures_std_dev,
((AVG(weighted_standardized_score) + (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score)))) - (AVG(weighted_standardized_score) - (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score))))) as procedures_std_err,
COUNT(weighted_standardized_score) as procedures_available,
(AVG(weighted_standardized_score) - (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score)))) as procedures_lower_ci,
(AVG(weighted_standardized_score) + (1.96* STDDEV_SAMP(weighted_standardized_score) / SQRT(COUNT(weighted_standardized_score)))) as procedures_upper_ci
FROM intermediate_procedures inp
INNER JOIN (SELECT state, COUNT(DISTINCT provider_id) as state_total FROM 3nf_hospitals GROUP BY state) sub
ON inp.state = sub.state
WHERE weighted_standardized_score IS NOT NULL 
GROUP BY inp.state
HAVING COUNT(DISTINCT measure_id) > 26
AND count(DISTINCT inp.provider_id)/MAX(sub.state_total) > 0.75;








DROP TABLE analytical_correlation_by_provider;

CREATE TABLE analytical_correlation_by_provider AS
SELECT 
h.provider_id,
h.hospital_overall_rating AS hospital_overall_rating,
ap.procedures_mean AS procedures_mean,
(n.score + d.score + s.score + p.score + m.score + d.score)/6 AS surveys_mean,
n.score AS surveys_communication_with_nurses_score,
d.score AS surveys_communication_with_doctors_score,
s.score AS surveys_responsiveness_of_hospital_staff_score,
p.score AS surveys_pain_management_score,
m.score AS surveys_communication_about_medicines_score,
d.score AS surveys_discharge_information_score

FROM 
3nf_hospitals h

INNER JOIN
analytical_procedures_by_provider ap
ON h.provider_id = ap.provider_id

INNER JOIN 
(SELECT provider_id, score 
FROM 3nf_surveys_responses
WHERE subdimension LIKE 'performance_rate'
AND dimension LIKE '%nurses%') n
ON h.provider_id = n.provider_id

INNER JOIN
(SELECT provider_id, score 
FROM 3nf_surveys_responses 
WHERE subdimension LIKE 'performance_rate'
AND dimension LIKE '%doctors%') d
ON h.provider_id = d.provider_id

INNER JOIN
(SELECT provider_id, score 
	FROM 3nf_surveys_responses
WHERE subdimension LIKE 'performance_rate'
AND dimension LIKE '%staff%') s
ON h.provider_id = s.provider_id

INNER JOIN
(SELECT provider_id, score 
FROM 3nf_surveys_responses
WHERE subdimension LIKE 'performance_rate'
AND dimension LIKE '%pain%') p
ON h.provider_id = p.provider_id

INNER JOIN
(SELECT provider_id, score
FROM 3nf_surveys_responses
WHERE subdimension LIKE 'performance_rate'
AND dimension LIKE '%medicines%') m
ON h.provider_id = m.provider_id

INNER JOIN
(SELECT provider_id, score
FROM 3nf_surveys_responses
WHERE subdimension LIKE 'performance_rate'
AND dimension LIKE '%discharge%') dc
ON h.provider_id = dc.provider_id;
