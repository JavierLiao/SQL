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



