use employees;
-- 1
select 
	de.dept_no
	, d.dept_name 
	, e.gender 
	, count(e.emp_no) as num_of_employees
from 
	employees e 
	inner join dept_emp de
		on e.emp_no = de.emp_no 
	left join departments d
		on de.dept_no = d.dept_no 
group by 
	1, 2, 3
	
-- 2
-- version 1
select 
	count(distinct emp_no) as num_of_employees
from 
	employees e 
where
 	e.emp_no in (
	select 
		t.emp_no 
	from 
		titles t
	where
	 	title = 'Senior Engineer'
	)
	and year(e.birth_date) = 1953
	and month(e.birth_date) = 1
-- version 2
select 
	count(distinct e.emp_no) as num_of_employees
from 
	titles t, employees e 
where 
	t.emp_no = e.emp_no
	and t.title = 'Senior Engineer'
	and year(e.birth_date) = 1953
	and month(e.birth_date) = 1
	
-- 3
select 
	de.dept_no
	, d.dept_name 
	, e.gender 
	, count(e.emp_no) as num_of_employees
from 
	employees e 
	inner join dept_emp de
		on e.emp_no = de.emp_no 
	left join departments d
		on de.dept_no = d.dept_no 
group by 
	1, 2, 3
having 
	num_of_employees > 10000
	
-- 4
select 
	first_name
	, last_name 
-- 	concat(first_name, ' ', last_name) as full_name
from 
	employees
where 
	birth_date = (
		select 
			min(birth_date)
		from
			employees 
	)
order by 
	1, 2
	
-- 5
select 
	d.dept_name 
	, e.gender 
	, count(e.emp_no) as num_of_employees
from 
	departments d 
	left join dept_emp de 
		on d.dept_no = de.dept_no 
	left join employees e 
		on de.emp_no = e.emp_no 
group by 
	1,2
order by 
	1,2
	
-- 6
-- version 1
select 
	t.title 
	, count(e.emp_no) as num_of_employees
from 
	titles t 
	left join employees e 
		on t.emp_no = e.emp_no 
where 
	e.gender = 'F'
group by 
	1
order by 
	2 desc 
limit 1
-- version 2
select 
	title 
	, num_of_employees 
from (
	select 
		t.title 
		, e.gender
		, count(e.emp_no) as num_of_employees
	from 
		titles t 
		left join employees e 
			on t.emp_no = e.emp_no 
	group by 
		1, 2
	) count_per_gender 
where 
	gender = 'F'
order by 
	2 desc 
limit 1
	
	
-- 7
select
	concat(e.first_name, ' ', e.last_name) as full_name
	, s.num_of_salary_changes
from (
	select
		emp_no
		, count(*) as num_of_salary_changes
	from 
		salaries 
	group by 
		1
	order by 
		2 desc, 1 asc
	limit 1
) s
inner join 
	employees e
		on s.emp_no = e.emp_no 
		
-- 8 
select distinct
	concat(e.first_name, ' ', e.last_name) as full_name
	, t.title 
from 
	employees e
	inner join titles t
		on e.emp_no = t.emp_no 
	inner join salaries s 
		on e.emp_no = s.emp_no 
where 
	s.salary >= (
select 
	 1.5 * avg(salary)
from 
	salaries s 
)

-- 9
select
	distinct t.title
from 
	titles t
where 
	t.title not in (
select 
	distinct t.title 
from 
	titles t 
	inner join dept_emp de 
		on t.emp_no = de.emp_no 
where
	de.dept_no = 'd001'
)

-- 10
select 
	concat(e.first_name, ' ', e.last_name) as full_name 
from 
	employees e
	inner join (
	select 
		emp_no 
		, count(dept_no) as num_of_dept 
	from 
		dept_emp de 
	group by 
		emp_no
	having 
		count(dept_no) > 1
	) subquery_1 
		on e.emp_no = subquery_1.emp_no
		
-- 11
select 
	full_name
from (
	select 
		concat(first_name, ' ', last_name) as full_name 
		, count(e.emp_no) as num_of_employees
	from 
		employees e 
	group by 
		1
	having 
		num_of_employees > 1
	order by 
		2 desc
) full_names

-- 12
select 
	distinct title 
from 
	titles 
where
	emp_no in (
	select 
		emp_no
	from 
		employees
	where 
		birth_date = (
			select 
				min(birth_date)
			from
				employees 
		)
)







