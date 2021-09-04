SELECT * FROM employees WHERE department_id<90 OR department_id>110 OR salary>12000;

SELECT * FROM employees WHERE NOT(department_id>=90 AND department_id<=110) OR salary>12000;

SELECT * FROM employees WHERE last_name LIKE '%a%';

SELECT * FROM employees WHERE last_name LIKE '__n_l%';

SELECT last_name,job_id FROM employees WHERE job_id IN('IT_PROG','AD_VP','AD_PRES');

SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NULL;

#-------------------------------

SELECT 
	last_name,
	department_id,
	salary *12*(1+IFNULL(commission_pct,0)) AS 年薪
FROM 
	employees 
WHERE 
	employee_id=176;
	
#--------------------------------

SELECT 
	salary,
	last_name
FROM
	employees
WHERE 
	commission_pct IS NULL AND salary<18000;
	
#----------------------------------

SELECT
	*
FROM
	employees
WHERE
	job_id <>'IT' OR salary=12000;
	
#----------------------------------

SELECT DISTINCT location_id FROM departments;