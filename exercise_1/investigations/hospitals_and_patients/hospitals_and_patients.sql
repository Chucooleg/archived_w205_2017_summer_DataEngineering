SELECT
"hospitals_surveys" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_mean),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_surveys" AS pair,
ROUND(CORR(procedures_mean, surveys_mean),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"hospitals_nurses" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_communication_with_nurses_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"hospitals_doctors" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_communication_with_doctors_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"hospitals_staff" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_responsiveness_of_hospital_staff_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"hospitals_pain" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_pain_management_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"hospitals_medicines" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_communication_about_medicines_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"hospitals_discharge" AS pair,
ROUND(CORR(hospital_overall_rating, surveys_discharge_information_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_nurses" AS pair,
ROUND(CORR(procedures_mean, surveys_discharge_information_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_nurses" AS pair,
ROUND(CORR(procedures_mean, surveys_communication_with_nurses_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_doctors" AS pair,
ROUND(CORR(procedures_mean, surveys_communication_with_doctors_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_staff" AS pair,
ROUND(CORR(procedures_mean, surveys_responsiveness_of_hospital_staff_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_pain" AS pair,
ROUND(CORR(procedures_mean, surveys_pain_management_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_medicines" AS pair,
ROUND(CORR(procedures_mean, surveys_communication_about_medicines_score),4) AS correlation
FROM analytical_correlation_by_provider
UNION
SELECT
"procedures_discharge" AS pair,
ROUND(CORR(procedures_mean, surveys_discharge_information_score),4) AS correlation
FROM analytical_correlation_by_provider
ORDER BY ABS(correlation) DESC;
