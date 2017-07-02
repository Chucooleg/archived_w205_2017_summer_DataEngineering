SELECT 
RANK() OVER(ORDER BY a.std_err DESC) as rank_std_err,
a.std_err,
a.measure_id,
m.measure_name
FROM analytical_procedures_stats a
INNER JOIN 3nf_measures m
ON a.measure_id = m.measure_id
WHERE a.hospitals_count > 4805*0.5
ORDER BY a.std_err DESC
LIMIT 10;
