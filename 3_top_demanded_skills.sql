-- This query retrieves the top 10 most demanded skills for Data Analyst positions based on the number of job postings that require each skill.
-- It joins the job postings table with the skills tables to count the number of job postings for each skill.
-- The results are grouped by skill and ordered by the count of job postings in descending order, 
-- ensuring that the most demanded skills appear first.

SELECT 
    s.skills,
    COUNT(sj.job_id) AS demand_count
FROM
    job_postings_fact jp
INNER JOIN
    skills_job_dim sj ON 
    jp.job_id = sj.job_id
INNER JOIN
    skills_dim s ON 
    sj.skill_id = s.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    s.skills
ORDER BY
    demand_count DESC
LIMIT   
    10
;