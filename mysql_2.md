# SQL

## 2 SQL语言

### 2.2 DQL语言

#### 2.2.3 排序查询

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

</br>

#### 2.2.4 常见函数

> select **函数名(实参列表)** 【from **table**】

分类

+ 单行函数
  + 字符函数
  + 数学函数
  + 日期函数
  + 其他函数
  + 流程控制函数

+ 分组函数（统计函数、聚合函数）
  + 做统计使用

(1). 单行函数

1. 字符函数
+ **length()** 获取参数值的字节个数

> SELECT LENGTH('John');【4】
>
> SELECT LENGTH('你是sb');【8】

2. **concat()** 拼接字符串

> SELECT CONCAT(last_name,'_',first_name) FROM employees;

3. **upper(),lower()**

> SELECT UPPER('john');
>
> e.g1 姓大小，名小写并拼接：SELECT CONCAT(UPPER(last_name),LOWER(first_name)) FROM employees;

4. **substr(字符串,起始索引,截取字符长度)** 

> SELECT SUBSTR('我是你爹',4);</br>
> SELECT SUBSTR('我是你爹',1,2); 

>e.g1 姓名首字母大写，其他小写并拼接：</br>
>SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),LOWER(SUBSTR(last_name,2)),LOWER(first_name)) AS 姓名 FROM employees; 

5. **instr(字符串,字符串中一段)** 返回字符串第一次出现的索引，找不到为0

>SELECT INSTR('我是你爹','爹'); 【4】

6. **trim(字符串 FROM 字符串)**： 去掉头尾无意义字符

> SELECT TRIM('   我  是  你   爹  ') AS out_put;</br>
> SELECT LENGTH(TRIM('   我  是  你   爹  ')) AS out_put;
>
> SELECT TRIM('a' FROM 'aaaaaa我aaaaa是aaa你aaaa爹aaaaa') AS out_put;

7. **lpad(字符串,长度,字符)**: 字符串左边填充字符以达到长度

>SELECT LPAD('我是你爹',10,'爹');
