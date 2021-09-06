          
## 分组函数
#sum() 求和、avg() 平均值、max() 最大值、min()最小值、count()计算个数


#1.简单使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

SELECT SUM(salary) 求和, ROUND(AVG(salary),2) 平均值,MAX(salary) 最大值,MIN(salary) 最小值,COUNT(salary) 计数 FROM employees;

 
#2.参数类型

#不可：
SELECT SUM(last_name),AVG(last_name) FROM employees;

#可：
SELECT MAX(last_name),MIN(last_name) FROM employees;
SELECT MAX(hiredate),MIN(hiredate) FROM employees;

SELECT COUNT(commission_pct) FROM employees;


#3.是否忽略null值

#忽略null值
SELECT SUM(commission_pct),AVG(commission_pct),
	SUM(commission_pct)/107,SUM(commission_pct)/35
FROM employees;

SELECT MAX(commission_pct),MIN(commission_pct) FROM employees;

SELECT COUNT(commission_pct) FROM employees;


#4.与distinct搭配使用
SELECT SUM(DISTINCT salary),SUM(salary) FROM employees;

SELECT COUNT(DISTINCT salary) FROM employees;


#5.count 函数
SELECT COUNT(salary) FROM employees;

SELECT COUNT(*) FROM employees;

SELECT COUNT(1) FROM employees;


#效率：
#MYSIAM存储引擎下，count(*)效率高
#INNOB存储引擎下，效率差不多
# 一般使用count(*)


#6. 和分组函数一同查询的字段有限制

SELECT AVG(salary), employee_id FROM employees;



###分组查询

#1.简单分组查询

#查询每个工种的最高工资
SELECT job_id,MAX(salary)
FROM employees
GROUP BY job_id;

#查询每个位置上的部门个数
SELECT location_id,COUNT(*)
FROM departments
GROUP BY location_id;

#2.添加筛选条件
#查询邮箱中包含a字符的每个部门的平均工资
SELECT department_id 部门编号,ROUND(AVG(salary),2) 平均工资
FROM employees
WHERE email LIKE '%a%'
GROUP BY department_id;

#查询有奖金的每个领导手下员工的最高工资
SELECT manager_id 领导编号,MAX(salary) 最高工资
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

#3.添加复杂(分组后)筛选条件(having语句)
#查询哪个部门的员工个数大于2(嵌套筛选)
SELECT department_id,COUNT(*)
FROM employees
GROUP BY department_id;

SELECT department_id,COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*)>2;

#查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT job_id 工种编号,MAX(salary) 最高工资
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY job_id
HAVING 最高工资>12000;

#查询领导编号>102的每个领手下的最低工资>5000的领导编号是哪个及其最低工资
SELECT manager_id 领导编号,MIN(salary) 最低工资
FROM employees
WHERE manager_id>102
GROUP BY manager_id
HAVING 最低工资>5000;


#4.按表达式或函数分组
#按员工姓名长度分组，查询每组员工个数，筛选员工个数>5
SELECT LENGTH(last_name) 姓名长度,COUNT(*) 员工个数
FROM employees
GROUP BY LENGTH(last_name)
HAVING COUNT(*)>5;


#5.按多个字段分组
#查询每个部门每个工种的员工的平均工资
SELECT department_id, job_id,AVG(salary)
FROM employees
GROUP BY department_id,job_id;

#6.添加排序
#查询每个不为空的部门每个工种的员工的平均工资>10000的相关信息，并按平均工资高低显示
SELECT department_id, job_id,AVG(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id,job_id
HAVING AVG(salary)>10000
ORDER BY AVG(salary) DESC;

# 查询各个管理者手下员工的最低工资>=6000,没有管理者的不计算
#正解
SELECT manager_id,MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary)>=6000;

#先筛选6000以上的，再分组效果不同
#多出其最低工资低于6000但也有6000以上的员工的组别
SELECT manager_id,MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL AND salary>=6000
GROUP BY manager_id;
#HAVING MIN(salary)>6000;

SELECT COUNT(DISTINCT manager_id) 
FROM employees
WHERE manager_id IS NOT NULL;



###连接查询
#多个表的连接匹配查询

SELECT `name`,boyName 
FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;

##（1）SQL92标准

#1.等值连接
#查询女神名和对应的男神名
SELECT `name`,boyName 
FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;
 
#查询员工名的对应的部门名
SELECT last_name,department_name
FROM employees, departments
WHERE employees.department_id = departments.department_id;

#为表起别名(起别名后不能使用原表名)
#查询员工名、工种号、工种名
SELECT last_name, e.job_id, job_title
FROM employees AS e, jobs AS j
WHERE e.job_id = j.job_id;

#加筛选条件
#查询有奖金的员工及其部门
SELECT last_name,department_name
FROM employees AS e, departments AS d
WHERE e.department_id = d.department_id
AND e.commission_pct IS NOT NULL;

#查询城市名中第二个字符为o的部门和城市名
SELECT department_name,city
FROM departments AS d,locations AS l
WHERE d.location_id=l.location_id
AND l.city LIKE '_o%';

#查询每个城市的部门个数
SELECT city 城市,COUNT(*) 部门个数
FROM departments AS d, locations AS l
WHERE d.location_id = l.location_id
GROUP BY l.city;

#查询有奖金的每个部门的部门名和部门的领导编号以及该部门的最低工资
SELECT department_name 部门名, d.manager_id 管理编号, MIN(salary)
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND commission_pct IS NOT NULL
GROUP BY department_name;

#查询工种的工种名和员工的个数，并且按员工个数降序
SELECT job_title 工种, COUNT(*)
FROM employees e, jobs j
WHERE e.job_id = j.job_id
GROUP BY job_title
ORDER BY 员工个数 DESC;

#三表连接
#查询员工名，部门名和坐在的城市名
SELECT last_name, department_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id AND d.location_id = l.location_id;


#2.非等值连接
# 查询员工的工资和工资级别
select employee_id,salary,grade_level
from employees e, job_grades j
where salary between lowest_sal and highest_sal
and grade_level='A';

#3.自连接
#查询员工名和上级的名称
select e.employee_id,e.last_name,m.employee_id,m.last_name
from employees e, employees m
where e.manager_id = m.employee_id;










