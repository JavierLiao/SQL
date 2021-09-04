# SQL

## 二、SQL语言

### 2.DQL语言

#### (3)排序查询

> SELECT **查询列表** FROM **table** (WHERE **condition**） ORDER BY **排序列表** ASC|DESC；

特点：

+ 不加ASC或DESC默认升序

+ ORDER BY可加单个字段、多个字段、表达式、函数、别名

+ OEDER BY分句一般放在查询语句的最后，LIMIT除外

> e.g1 查询员工信息，工资从高到低排序：SELECT * FROM employees ORDER BY salary ASC;
>
> e.g2 查询员工信息，部门编号>=90，入职先后排序：【添加筛选条件】</br>
> SELECT * FROM employees WHERE department_id>=90 ORDER BY hiredate ASC;
>
> e.g3 查询员工信息，按年薪高低显示:【按表达式排序】</br>
> SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 </br>
> FROM employees </br>
> ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;(可直接ORDER BY 年薪 DESC)
>
> e.g4 按名字长度排序显示员工姓名工资：【按函数排序】</br>
> SELECT last_name,salary,LENGTH(last_name) AS 长度</br>
> FROM employees</br>
> ORDER BY LENGTH(last_name);(可直接ORDER BY 长度)
>
> e.g5 查询信息，先按工资排序，再按员工编号排序:【按多个字段排序】</br>
> SELECT * </br>
> FROM employees </br>
> ORDER BY salary ASC,employee_id DESC;
