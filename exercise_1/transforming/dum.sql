select 
measure_id,
min(score), 
max(score), 
PERCENTILE_APPROX(score, 0.5), 
AVG(score)
from 3nf_readmissions group by measure_id;
