-- This query retrieves the top 10 highest paying Data Analyst jobs with their required skills.
-- It uses a Common Table Expression (CTE) to first select the top 10 jobs based on average yearly salary.
-- Then, it joins the CTE with the skills tables to aggregate and list the distinct skills and skill types required for each job.

WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        job_location,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN 
        company_dim ON
        job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_location = 'Anywhere' AND 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.job_id,
    top_paying_jobs.salary_year_avg,
    top_paying_jobs.job_title,
    STRING_AGG(DISTINCT skills_dim.skills, ', ') AS skills,
    STRING_AGG(DISTINCT skills_dim.type, ', ') AS skill_types
FROM 
    top_paying_jobs
INNER JOIN 
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    top_paying_jobs.job_id,
    top_paying_jobs.salary_year_avg,
    top_paying_jobs.job_title
ORDER BY
    top_paying_jobs.salary_year_avg DESC;