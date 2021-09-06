# SQL

## 2 SQL语言

### 2.2 DQL语言

#### 2.2.4 常见函数

(2). 分组函数

功能：用作统计使用

常用函数:sum() 求和、avg() 平均值、max() 最大值、min()最小值、count()计算非空个数

特点：

+ sum、avg用于处理数值型，max、min、count处理任意类型

+ 以上分组函数均忽略null值

+ 与distinct搭配使用

+ 一般使用count(\*)统计行数

+ 和分组函数一同查询的字段要求是group by后的字段

</br>

1. 简单使用

> SELECT SUM(salary) FROM employees;</br>
> SELECT AVG(salary) FROM employees;</br>
> SELECT MAX(salary) FROM employees;</br>
> SELECT MIN(salary) FROM employees;</br>
> SELECT COUNT(salary) FROM employees;
> 
> SELECT SUM(salary) 求和, ROUND(AVG(salary),2) 平均值,MAX(salary) 最大值,MIN(salary) 最小值,COUNT(salary) 计数 </br>
> FROM employees;

</br>

2.参数类型

> #不可：</br>
> SELECT SUM(last_name),AVG(last_name) FROM employees;</br>
> 
> #可：</br>
> SELECT MAX(last_name),MIN(last_name) FROM employees;</br>
> SELECT MAX(hiredate),MIN(hiredate) FROM employees;</br>
> 
> SELECT COUNT(commission_pct) FROM employees;

</br>

3. 是否忽略null值

> SELECT SUM(commission_pct),AVG(commission_pct),</br>
> SUM(commission_pct)/107,SUM(commission_pct)/35</br>
> FROM employees;
> 
> SELECT MAX(commission_pct),MIN(commission_pct) FROM employees;</br>
> 
> SELECT COUNT(commission_pct) FROM employees;

</br>

4. 与distinct搭配使用

> SELECT SUM(DISTINCT salary),SUM(salary) FROM employees;
> 
> SELECT COUNT(DISTINCT salary) FROM employees;

</br>

5. count 函数

> SELECT COUNT(salary) FROM employees;
> 
> SELECT COUNT(\*) FROM employees;
> 
> SELECT COUNT(1) FROM employees;

效率：
MYSIAM存储引擎下，count(\*)效率高
INNOB存储引擎下，效率差不多
 一般使用count(\*)

</br>

6. 和分组函数一同查询的字段有限制

> SELECT AVG(salary), employee_id FROM employees;

</br>

#### 2.2.5分组查询

> SELECT **field,group_function**</br>
> FROM **table**</br>
> [WHERE **CONDITION**]</br>
> GROUP BY **group_by_expression**</br>
> [ORDER BY **column**];

 注意：查询列表要求是分组函数和group by后出现的字段
 
 (1).添加筛选条件
 
1. 原始表中有的字段添加筛选条件

> e.g1 查询邮箱中包含a字符的每个部门的平均工资</br>
> SELECT department_id 部门编号,ROUND(AVG(salary),2) 平均工资</br>
> FROM employees</br>
> WHERE email LIKE '%a%'</br>
> GROUP BY department_id;

2. 先分组统计后再进行筛选(分组函数做筛选条件肯定是放在having子句中)

> SELECT **field,group_function**</br>
> FROM **table**</br>
> [WHERE **CONDITION**]</br>
> GROUP BY **group_by_expression**</br>
> HAVING **group_function condition**</br>
> [ORDER BY **column**];

> e.g2 查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资</br>
> SELECT job_id 工种编号,MAX(salary) 最高工资</br>
> FROM employees</br>
> WHERE commission_pct IS NOT NULL</br>
> GROUP BY job_id</br>
> HAVING 最高工资>12000;

</br>

(2). 按表达式或函数分组

> e.g 按员工姓名长度分组，查询每组员工个数，筛选员工个数>5</br>
> SELECT LENGTH(last_name) 姓名长度,COUNT(\*) 员工个数</br>
> FROM employees</br>
> GROUP BY LENGTH(last_name)</br>
> HAVING COUNT(*)>5;

</br>

(3). 按多个字段分组

>e.g 查询每个部门每个工种的员工的平均工资</br>
> SELECT department_id, job_id,AVG(salary)</br>
> FROM employees</br>
> GROUP BY department_id,job_id;

</br>

(4). 添加排序

> e.g 查询每个不为空的部门每个工种的员工的平均工资>10000的相关信息，并按平均工资高低显示</br>
> SELECT department_id, job_id,AVG(salary)</br>
> FROM employees</br>
> WHERE department_id IS NOT NULL</br>
> GROUP BY department_id,job_id</br>
> HAVING AVG(salary)>10000</br>
> ORDER BY AVG(salary) DESC;

</br>

#### 2.2.6连接查询（多表查询）

涉及多个表的查询

分类：

+ 内连接
  + 等值连接
  + 非等值连接
  + 自连接
+ 外连接  
  + 左外连接
  + 右外连接
  + 全外连接（SQL99标准不支持）
+ 交叉连接


(1).SQL92标准

1.等值连接

特点：

+ 多表等值连接结果为多表的交集部分

+ n表连接，至少需要n-1个连接条件

+ 一般为表起别名

+ 可以搭配所有查询子句使用，如排序，分组，筛选


> e.g1 查询女神名和对应的男神名</br>
> select `name`,boyName </br>
> from beauty, boys</br>
> where beauty.boyfriend_id = boys.id;
>  
> e.g2 查询员工名的对应的部门名</br>
> select last_name,department_name</br>
> from employees, departments</br>
> where employees.department_id = departments.department_id;

> e.g3 查询员工名、工种号、工种名(为表起别名,起别名后不能使用原表名)</br>
> select last_name, e.job_id, job_title</br>
> from employees as e, jobs as j</br>
> where e.job_id = j.job_id;

> e.g4 查询有奖金的员工及其部门（加筛选条件）</br>
> select last_name,department_name</br>
> from employees as e, departments as d</br>
> where e.department_id = d.department_id</br>
> and e.commission_pct is not null;
> 
> e.g5 查询城市名中第二个字符为o的部门和城市名</br>
> select department_name,city</br>
> from departments as d,locations as l</br>
> where d.location_id=l.location_id</br>
> and l.city like '\_o%';

> e.g6 查询每个城市的部门个数（加分组条件）</br>
> select city 城市,count(\*) 部门个数</br>
> from departments as d, locations as l</br>
> where d.location_id = l.location_id</br>
> group by l.city;

> e.g7 查询有奖金的每个部门的部门名和部门的领导编号以及该部门的最低工资</br>
> select department_name 部门名, d.manager_id 管理编号, min(salary)</br>
> from employees e, departments d</br>
> where e.department_id = d.department_id</br>
> and commission_pct is not null</br>
> group by department_name;

> e.g8 查询每工种的工种名和员工的个数，并且按员工个数降序(加排序条件)</br>
> select job_title 工种, count(\*) 员工个数</br>
> from employees e, jobs j</br>
> where e.job_id = j.job_id</br>
> group by job_title</br>
> order by 员工个数 desc;

> e.g9 查询员工名，部门名和坐在的城市名(三表连接)</br>
> select last_name, department_name, city</br>
> from employees e, departments d, locations l</br>
> where e.department_id = d.department_id and d.location_id = l.location_id

</br>

2. 非等值连接

> e.g 查询员工的工资和工资级别</br>
> select employee_id,salary,grade_level</br>
> from employees e, job_grades j</br>
> where salary between lowest_sal and highest_sal</br>
> and grade_level='A';

</br>

3. 自连接

> e.g 查询员工名和上级的名称</br>
> select e.employee_id,e.last_name,m.employee_id,m.last_name</br>
> from employees e, employees m</br>
> where e.manager_id = m.employee_id;

