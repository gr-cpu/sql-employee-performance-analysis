-- Who are the top 5 highest serving employees
select 
	e.employee_id,
	e.hire_date,
	current_date - e.hire_date as tenure_days
from employee e
left join turnover t 
	on e.employee_id = t.employee_id
where t.employee_id is null
order by tenure_days desc
Limit 5

-- What is the turnover rate for each department?
select e.department_id,
	count(t.turnover_date) as Leavers,
	count(e.employee_id) as total_emp,
	round(
		count(t.turnover_date) * 100.0/
		count(e.employee_id),2) as "turnover rate"
from employee e
left join turnover t on e.employee_id = t.employee_id
group by 1
-- Which employees are at risk of leaving based on their performance
select employee_id, 
	department_id,  
	performance_score 
from performance
where performance_score <=3
order by performance_score desc

-- What are the main reasons employees are leaving the company?
select reason_for_leaving,
	count(*) As Frequency
from turnover
Group by reason_for_leaving
order by Frequency desc

-- How many employees have left the company?

select count(distinct employee_id) as "leavers" 
from turnover

-- How many employees have a performance score of 5.0 
SELECT 
	  performance_score,
	  count(distinct employee_id) 	
from performance
where performance_score = 5.0
group by 1

--How many employees have a performance score below 3.5 	
SELECT 
	employee_id, 
	performance_score
from performance
where performance_score < 3.5

-- Which department has the most employees with a performance of 5.0 / below 3.5?
select 
	department_id, 
	count(*) as performance_score
from performance	
where performance_score = 5.0
group by department_id
order by performance_score DESC
limit 1

-- Which department has the most employees with a performance below 3.5?
select department_id,
	count(*) "performance blw 3.5"
from performance
where performance_score < 3.5
group by department_id
order by "performance blw 3.5"

-- What is the average performance score by department?
 SELECT
 	department_id, 
	round(avg(performance_score),2) as " Avg performance"
from performance
group by 1
order by department_id desc

-- What is the total salary expense for the company?
select to_char(sum(salary_amount),'$999,999,999') as "Total salary expense"
from salary;

-- What is the average salary by job title?
select 
	e.job_title,
	avg(s.salary_amount) as "Avg salary"
from salary s
join employee e on e.employee_id = s.employee_id
group by 1
order by "Avg salary"
-- How many employees earn above 80,000?
select 
	count(distinct employee_id) as "salary above 80k"
from salary
where salary_amount > 80000

--What is the avg salary by job title
select e.job_title,
	round(avg(s.salary_amount), 2) as "Avg salary"
from salary s
join employee e on e.employee_id = s.employee_id
group by 1
order by "Avg salary" desc;





-- How does performance correlate with salary across departments?

SELECT
	e.department_id,
	round(corr(p.performance_score, s.salary_amount):: numeric, 2) as perf_salary_corr
from employee e
join performance p 
	on e.employee_id = p.employee_id
join salary s on e.employee_id = s.employee_id
group by e.department_id
order by perf_salary_corr 
desc


select *
from salary


