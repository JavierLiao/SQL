###连接查询
##（2）SQL99标准

#1.内连接
#等值连接
#查询员工名，部门名
SELECT last_name,department_name
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id;

#查询名字中包含e的员工名和工种名
SELECT last_name, job_title
FROM employees e
INNER JOIN jobs j
ON e.job_id = j.job_id
WHERE last_name LIKE '%e%';

#查询部门个数>3的城市名和部门个数
SELECT city,COUNT(*)
FROM departments d
INNER JOIN locations l
ON d.location_id = l.location_id
GROUP BY city
HAVING COUNT(*)>3;

#查询哪个部门的部门员工个数》3的部门名和员工个数，并按个数降序
SELECT department_name, COUNT(*) 员工个数
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
GROUP BY department_name
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

#查询员工名、部门名、工种名，并按部门名降序
SELECT last_name, department_name, job_title
FROM employees e
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN jobs j
ON e.job_id = j.job_id
ORDER BY d.department_name DESC;


#非等值连接
#查询员工的工资级别
SELECT salary,grade_level
FROM employees e
INNER JOIN job_grades g
ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;

#查询每个工资级别的个数>2的个数，按级别降序
SELECT grade_level,COUNT(*)
FROM employees e
INNER JOIN job_grades g
ON e.salary BETWEEN g.lowest_sal AND g.highest_sal
GROUP BY grade_level
HAVING COUNT(*)>20
ORDER BY grade_level DESC;


#自连接
#查询员工名字及上级名字,包含k
SELECT e.last_name,m.last_name
FROM employees e
INNER JOIN employees m
ON e.manager_id = m.employee_id
WHERE e.last_name LIKE '%k%';


#2.外连接
#查询没有男朋友的女神名
select  `name`,boyName
from beauty g
left join boys b
on g.boyfriend_id = b.id
where boyName is null;

#查询哪个部门没有员工
select department_name,e.*
from departments d
left join employees e
on d.department_id = e.department_id;

#全连接
  
  
###2.2.7子查询（内查询）
#（1）用在where（having）后
#1.标量子查询
#谁的工资比Abel高
select *
from employees
where salary > (
			select salary
			from employees
			where last_name = 'Abel'
);

#查询与141号工种相同，而工资比143号员工多的员工的姓名，job_id和工资
select last_name, job_id, salary
from employees
where job_id = (
		select job_id
		from employees
		where employee_id = 141
) 
and salary > (
		select salary
        from employees
        where employee_id = 143
);

#查询工资最少的员工的名字，job_id以及工资
select last_name, job_id, salary
from employees
where salary = (
		select min(salary)
		from employees
);

#查询最低工资>50号部门最低工资的部门ID和其最低工资
select min(salary)
from employees
where department_id = 50;


select department_id, min(salary)
from employees
group by department_id
having min(salary) > (
		select min(salary)
		from employees
		where department_id = 50
);
 
#非法使用标量子查询


#2.列子查询（多行子查询）
#查询location_id是1400或1700的部门中的所有员工姓名
select last_name, location_id
from employees e
join departments d
on e.department_id = d.department_id
where location_id in (1400,1700);

select last_name
from employees
where department_id in (
		select distinct department_id
		from departments
		where location_id in (1400,1700)
);

#查询其他部门中比job_id为‘IT_PROG’部门任一工资低的员工号、姓名、job_id以及salary
select employee_id, last_name, job_id, salary
from employees
where salary < any(
		select distinct salary
		from employees
		where job_id = 'IT_PROG'
)
and job_id <> 'IT_PROG';

select employee_id, last_name, job_id, salary
from employees
where salary < (
		select max(salary)
		from employees
		where job_id = 'IT_PROG'
)
and job_id <> 'IT_PROG';


#3.行子查询
#查询员工编号最小并且工资最高的员工信息
select *
from employees
where employee_id = (
	select min(employee_id) from employees
) and salary = (
	select max(salary) from employees
);

select *
from employees
where (employee_id,salary) = (
	select min(employee_id),max(salary)
	from employees
);



##(2)放在select后

#查询每个部门的员工个数
select d.*,(
	select count(*)
	from employees e
	where e.department_id = d.department_id
) 员工个数
from departments d;

select d.*,count(last_name)
from departments d
left join employees e
on e.department_id = d. department_id
group by d.department_id;


#查询员工号为102的部门名
select (
	select department_name
	from departments d
	where e.department_id = d.department_id
) 部门名
from employees e
where e.employee_id = 102;


##(3)放在from后面
#查询每个部门的平均工资的工资等级

select ag_dep.*, g.grade_level
from (
	select department_id, avg(salary) ag
	from employees e
	group by department_id
) ag_dep
inner join job_grades g
on ag_dep.ag between g.lowest_sal and g.highest_sal;


##(4)放在exists后面(相关子查询）
#查询有员工的部门名
select department_name
from departments d
where exists(
	select *
	from employees e
	where d.department_id = e.department_id
);

select distinct department_name
from departments d
join employees e
on d.department_id = e.department_id;

select department_name
from departments
where department_id in (
	select department_id
	from employees
);

#查询没有女朋友的男神信息
select boyName
from boys b
left join beauty g
on b.id = g.boyfriend_id
where g.id is null;

select boyName
from boys
where id not in (
	select boyfriend_id
	from beauty
);

select boyName
from boys
where not exists(
	select *
    from beauty
    where boys.id = beauty.boyfriend_id
);



###练习
#查询每个部门中工资比本部门平均工资搞得员工的员工号，姓名和工资
select employee_id, last_name, salary
from employees e
inner join (
	select avg(salary) ag, department_id
	from employees
	group by department_id
) ag_deg
on e.department_id = ag_deg.department_id
where salary > ag_deg.ag;

select employee_id, last_name, salary
from employees e
inner join (
	select avg(salary) ag, department_id
	from employees
	group by department_id
) ag_deg
on e.department_id = ag_deg.department_id
where salary > ag_deg.ag;






