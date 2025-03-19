-- This query retrieves the top 10 highest paying skills for Data Analyst positions based on the average yearly salary.
-- It joins the job postings table with the skills tables to calculate the average salary for each skill.
-- The results are grouped by skill and ordered by the average salary in descending order, 
-- ensuring that the highest paying skills appear first.

SELECT 
    s.skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM
    job_postings_fact jp
INNER JOIN
    skills_job_dim sj ON jp.job_id = sj.job_id
INNER JOIN
    skills_dim s ON sj.skill_id = s.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    s.skills
ORDER BY
    avg_salary DESC
LIMIT   
    10
;