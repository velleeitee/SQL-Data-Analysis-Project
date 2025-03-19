-- This query retrieves the top 10 highest paying Data Analyst jobs with their required skills.
-- It uses a Common Table Expression (CTE) to first select the top 10 jobs based on average yearly salary.

SELECT 
    job_id,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    name as company_name
FROM 
    job_postings_fact
LEFT JOIN 
    company_dim ON
    job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_location = 'Anywhere' AND 
    job_title_short = 'Data Analyst'  AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 
    10
;
