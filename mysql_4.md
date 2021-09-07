# SQL

## 2.SQL语言

### 2.2DQL语言

#### 2.2.6连接查询

(2). SQL99标准

> SELECT **查询列表**</br>
> FROM **table1 别名** </br>
> [**连接类型**] JOIN **table2 别名** </br>
> ON **连接条件**</br>
> [WHERE **筛选条件**]</br>
> [GROUP BY **分组字段**]</br>
> [HAVING **筛选条件**]</br>
> [ORDER BY **排序字段**]；


1.内连接（**连接类型：INNER**）

特点：添加排序、分组、筛选；inner可省略；可读性较高;inner join连接与SQL92结果相同

+ 等值连接

> e.g1 查询员工名，部门名</br>
> SELECT last_name,department_name</br>
> FROM employees e</br>
> INNER JOIN departments d</br>
> ON e.department_id = d.department_id;
> 
> e.g2 查询名字中包含e的员工名和工种名</br></br>
> SELECT last_name, job_title</br>
> FROM employees e</br>
> INNER JOIN jobs j</br>
> ON e.job_id = j.job_id</br>
> WHERE last_name LIKE '%e%';
> 
> e.g3 查询部门个数>3的城市名和部门个数</br>
> SELECT city,COUNT(\*)</br>
> FROM departments d</br>
> INNER JOIN locations l</br>
> ON d.location_id = l.location_id</br>
> GROUP BY city</br>
> HAVING COUNT(\*)>3;
> 
> e.g4 查询哪个部门的部门员工个数》3的部门名和员工个数，并按个数降序</br>
> SELECT department_name, COUNT(\*) 员工个数</br>
> FROM employees e</br>
> INNER JOIN departments d</br>
> ON e.department_id = d.department_id</br>
> GROUP BY department_name</br>
> HAVING COUNT(\*)>3</br>
> ORDER BY COUNT(\*) DESC;
>
> e.g5 查询员工名、部门名、工种名，并按部门名降序</br>
> SELECT last_name, department_name, job_title</br>
> FROM employees e</br>
> INNER JOIN departments d</br>
> ON e.department_id = d.department_id</br>
> INNER JOIN jobs j</br>
> ON e.job_id = j.job_id</br>
> ORDER BY d.department_name DESC

</br>

+ 非等值连接

> e.g1 查询员工的工资级别</br>
> SELECT salary,grade_level</br>
> FROM employees e</br>
> INNER JOIN job_grades g</br>
> ON e.salary BETWEEN g.lowest_sal AND g.highest_sal;
> 
> e.g2 查询每个工资级别的个数>2的个数，按级别降序</br>
> SELECT grade_level,COUNT(\*)</br>
> FROM employees e</br>
> INNER JOIN job_grades g</br>
> ON e.salary BETWEEN g.lowest_sal AND g.highest_sal</br>
> GROUP BY grade_level</br>
> HAVING COUNT(\*)>20</br>
> ORDER BY grade_level DESC;

</br>

+ 自连接

> e.g 查询员工名字及上级名字,包含k</br>
> SELECT e.last_name,m.last_name</br>
> FROM employees e</br>
> INNER JOIN employees m</br>
> ON e.manager_id = m.employee_id</br>
> WHERE e.last_name LIKE '%k%';

</br>

2.外连接（**连接类型：LEFT/RIGHT(OUTTER)**）

应用场景：查询一个表中有，另一个表没有的记录
接null表
外连接中，right join右边为主表

+ 左外和右外交换两表顺序，可实现同样的效果、

+ 全外连接=内连接结果+表1有表2没有的+表2有但表1没有的

> e.g1 查询没有男朋友的女神名</br>
> select `name`,boyName</br>
> from beauty g</br>
> left join boys b</br>
> on g.boyfriend_id = b.id</br>
> where boyName is null;
> 
> e.g2 查询哪个部门没有员工</br>
> select department_name,e.\*</br>
> from departments d</br>
> left join employees e</br>
> on d.department_id = e.department_id

</br> 
