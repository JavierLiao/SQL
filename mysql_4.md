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

> e.g2 查询名字中包含e的员工名和工种名</br></br>
> SELECT last_name, job_title</br>
> FROM employees e</br>
> INNER JOIN jobs j</br>
> ON e.job_id = j.job_id</br>
> WHERE last_name LIKE '%e%';

> e.g3 查询部门个数>3的城市名和部门个数</br>
> SELECT city,COUNT(\*)</br>
> FROM departments d</br>
> INNER JOIN locations l</br>
> ON d.location_id = l.location_id</br>
> GROUP BY city</br>
> HAVING COUNT(\*)>3;

> e.g4 查询哪个部门的部门员工个数》3的部门名和员工个数，并按个数降序</br>
> SELECT department_name, COUNT(\*) 员工个数</br>
> FROM employees e</br>
> INNER JOIN departments d</br>
> ON e.department_id = d.department_id</br>
> GROUP BY department_name</br>
> HAVING COUNT(\*)>3</br>
> ORDER BY COUNT(\*) DESC;

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

特点：

+ 外连接查询结果=内连接结果+null表

+ 左外连接中，left join左边为主表；右外连接中，right join右边为主表

+ 左外和右外交换两表顺序，可实现同样的效果

+ 全外连接=内连接结果+表1有表2没有的+表2有但表1没有的

> e.g1 查询没有男朋友的女神名</br>
> select `name`,boyName</br>
> from beauty g</br>
> left join boys b</br>
> on g.boyfriend_id = b.id</br>
> where boyName is null;

> e.g2 查询哪个部门没有员工</br>
> select department_name,e.\*</br>
> from departments d</br>
> left join employees e</br>
> on d.department_id = e.department_id

</br> 

#### 2.2.7子查询

出现在其他与剧中的select语句称为子查询或内查询，外部的查询语句称为主查询或外查询

位置：可以在select、from、where(having)、exists(相关子查询)

结果：标量子查询（结果只有一行一列）、列子查询（结果一列多行）、行子查询（多行多列）、表子查询

(1) 放在where(having)后

特点：

+ 子查询放在小括号内

+ 子查询放在条件右侧

+ 标量子查询，一般搭配单行操作符使用（> < >= <= = <>）；列子查询一般搭配多行操作符使用（in any/some all）

+ 子查询的执行优先于主查询，主查询的条件用到了子查询的结果

1. 标量子查询

> e.g1 谁的工资比Abel高</br> 
> select \*</br> 
> from employees</br> 
> where salary > (</br> 
> 			select salary</br> 
> 			from employees</br> 
> 			where last_name = 'Abel'</br> 
> );

> e.g2 查询与141号工种相同，而工资比143号员工多的员工的姓名，job_id和工资</br> 
> select last_name, job_id, salary</br> 
> from employees</br> 
> where job_id = (</br> 
> 		select job_id</br> 
> 		from employees</br> 
> 		where employee_id = 141</br> 
> ) and salary > (</br> 
> 		select salary</br> 
>         from employees</br> 
>         where employee_id = 143</br> 
> );

> e.g3 查询工资最少的员工的名字，job_id以及工资</br> 
> select last_name, job_id, salary</br> 
> from employees</br> 
> where salary = (</br> 
> 		select min(salary)</br> 
> 		from employees</br> 
> );

> e.g4 查询最低工资>50号部门最低工资的部门ID和其最低工资</br> 
> select min(salary)</br> 
> from employees</br> 
> where department_id = 50;
> 
> select department_id, min(salary)</br> 
> from employees</br> 
> group by department_id</br> 
> having min(salary) > (</br> 
> 		select min(salary)</br> 
> 		from employees</br> 
> 		where department_id = 50</br> 
> );


2. 列子查询

> e.g1 查询location_id是1400或1700的部门中的所有员工姓名</br> 
> select last_name, location_id</br> 
> from employees e</br> 
> join departments d</br> 
> on e.department_id = d.department_id</br> 
> where location_id in (1400,1700);
> 
> select last_name</br> 
> from employees</br> 
> where department_id in (</br> 
> 		select distinct department_id</br> 
> 		from departments</br> 
> 		where location_id in (1400,1700)</br> 
> );

> e.g2 查询其他部门中比job_id为‘IT_PROG’部门任一工资低的员工号、姓名、job_id以及salary</br> 
> select employee_id, last_name, job_id, salary</br> 
> from employees</br> 
> where salary < any(</br> 
> 		select distinct salary</br> 
> 		from employees</br> 
> 		where job_id = 'IT_PROG'</br> 
> )</br> 
> and job_id <> 'IT_PROG';
> 
> select employee_id, last_name, job_id, salary</br> 
> from employees</br> 
> where salary < (</br> 
> 		select max(salary)</br> 
> 		from employees</br> 
> 		where job_id = 'IT_PROG'</br> 
> )</br> 
> and job_id <> 'IT_PROG';


3. 行子查询（较少用）

> e.g 查询员工编号最小并且工资最高的员工信息</br>
> select \*</br>
> from employees</br>
> where employee_id = (</br>
> 	select min(employee_id) from employees</br>
> ) and salary = (</br>
> 	select max(salary) from employees</br>
> );
> 
> select \*</br>
> from employees</br>
> where (employee_id,salary) = (</br>
> 	select min(employee_id),max(salary)</br>
> 	from employees</br>
> )

</br>

(2) 放在select后(仅支持标量子查询)

> e.g1 查询每个部门的员工个数</br>
> select d.\*,(</br>
> select count(\*)</br>
>	from employees e</br>
> 	where e.department_id = d.department_id</br>
> ) 员工个数</br>
> from departments d;
> 
> select d.\*,count(last_name)</br>
> from departments d</br>
> left join employees e</br>
> on e.department_id = d. department_id</br>
> group by d.department_id;
 
> e.g2 查询员工号为102的部门名</br>
> select (</br>
> 	select department_name</br>
> 	from departments d</br>
> 	where e.department_id = d.department_id</br>
> ) 部门名</br>
> from employees e</br>
> where e.employee_id = 102;

</br>

(3) 放在from后面

> e.g 查询每个部门的平均工资的工资等级</br>
> select ag_dep.\*, g.grade_level</br>
> from (</br>
> 	select department_id, avg(salary) ag</br>
> 	from employees e</br>
> 	group by department_id</br>
> ) ag_dep</br>
> inner join job_grades g</br>
> on ag_dep.ag between g.lowest_sal and g.highest_sal

</br>

(4)放在exists后面（相关子查询）

> e.g1 查询有员工的部门名</br> 
> select department_name</br>
> from departments d</br>
> where exists(</br>
> 	select \*</br>
> 	from employees e</br>
> 	where d.department_id = e.department_id</br>
> );
> 
> select distinct department_name</br>
> from departments d</br>
> join employees e</br>
> on d.department_id = e.department_id;</br>
> 
> select department_name</br>
> from departments</br>
> where department_id in (</br>
> 	select department_id</br>
> 	from employees</br>
> );

> e.g2 查询没有女朋友的男神信息</br>
> select boyName</br>
> from boys b</br>
> left join beauty g</br>
> on b.id = g.boyfriend_id</br>
> where g.id is null;
> 
> select boyName</br>
> from boys</br>
> where id not in (</br>
> 	select boyfriend_id</br>
> 	from beauty</br>
> );
> 
> select boyName</br>
> from boys</br>
> where not exists(</br>
> 	select \*</br>
>     from beauty</br>
>     where boys.id = beauty.boyfriend_id</br>
> );








