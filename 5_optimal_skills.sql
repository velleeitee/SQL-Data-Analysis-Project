-- This query retrieves the top 50 most demanded skills and the top 50 highest paying skills for Data Analyst positions.
-- It combines these results to find the optimal skills that are both in high demand and high paying.
-- The results are ordered by the average salary in descending order.

WITH top_demanded_jobs AS ( 
    SELECT 
        s.skills,
        COUNT(sj.job_id) AS demand_count
    FROM
        job_postings_fact jp
    INNER JOIN
        skills_job_dim sj ON jp.job_id = sj.job_id
    INNER JOIN
        skills_dim s ON sj.skill_id = s.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
    GROUP BY
        s.skills
    ORDER BY
        demand_count DESC
    LIMIT   
        100
), top_demanded_skills AS (
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
        100
)
SELECT 
    top_demanded_jobs.skills,
    top_demanded_jobs.demand_count,
    top_demanded_skills.avg_salary
FROM
    top_demanded_jobs
INNER JOIN
    top_demanded_skills ON top_demanded_jobs.skills = top_demanded_skills.skills
ORDER BY
    top_demanded_skills.avg_salary DESC
;