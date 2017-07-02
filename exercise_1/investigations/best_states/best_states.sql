SELECT 
state,
ROUND(procedures_mean, 4) as procedures_mean,
CEIL((PERCENT_RANK() OVER(ORDER BY procedures_mean DESC) + 0.0000001)*5) as rank_mean_group,
ROUND(procedures_std_err, 4) as procedures_std_err,
RANK() OVER(PARTITION BY CEIL((PERCENT_RANK() OVER(ORDER BY procedures_mean DESC) + 0.0000001)*5) ORDER BY procedures_std_err ASC) as partition_rank_std_err
FROM analytical_procedures_by_state 
HAVING rank_mean_group = 1
ORDER BY procedures_std_err ASC
LIMIT 10 ;
