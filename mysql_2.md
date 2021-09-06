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

+ **concat()** 拼接字符串

> SELECT CONCAT(last_name,'_',first_name) FROM employees;

+ **upper(),lower()**

> SELECT UPPER('john');
>
> e.g1 姓大小，名小写并拼接：SELECT CONCAT(UPPER(last_name),LOWER(first_name)) FROM employees;

+ **substr(字符串,起始索引,截取字符长度)** 

> SELECT SUBSTR('我是你爹',4);</br>
> SELECT SUBSTR('我是你爹',1,2); 

>e.g1 姓名首字母大写，其他小写并拼接：</br>
>SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),LOWER(SUBSTR(last_name,2)),LOWER(first_name)) AS 姓名 FROM employees; 

+ **instr(字符串,字符串中一段)** 返回字符串第一次出现的索引，找不到为0

>SELECT INSTR('我是你爹','爹'); 【4】

+ **trim(字符串 FROM 字符串)**： 去掉头尾无意义字符

> SELECT TRIM('   我  是  你   爹  ') AS out_put;</br>
> SELECT LENGTH(TRIM('   我  是  你   爹  ')) AS out_put;
>
> SELECT TRIM('a' FROM 'aaaaaa我aaaaa是aaa你aaaa爹aaaaa') AS out_put;

+ **lpad(字符串,长度,字符),rpad()**: 字符串左边(右边)填充字符以达到长度

>SELECT LPAD('我是你爹',10,'爹');

+ **replace(字符串,被替换字符,替换字符)**

> SELECT REPLACE('张无忌爱上了周芷若','周芷若','赵敏');

</br>

2. 数学函数

+ **round(数字, 保留位数)** 四舍五入

> SELECT ROUND(2.559,2);【2.56】

+ **ceil(数字)** 向上取整

> SELECT CEIL(-1.23);【-1】

+ **floor(数字)** 向下取整

> SELECT FLOOR(-1.23);【-2】

+ **truncate(数字,截断保留位数)**

>SELECT TRUNCATE(1.6655,2);【1.66】

+ **mod(数字,数字)** 

>SELECT MOD(12,5);

</br>

3. 日期函数

+ **now()**：返回当前时间

>SELECT NOW();

+ **curdate()** ： 返回当前日期，不包含时间

+ **curtime()** ：返回当前时间，不包含日期

+ **year(),month(),monthname()**: 获取时间指定的部分

> SELECT YEAR(NOW());</br>
> SELECT YEAR('1998.12.5');</br>
> SELECT YEAR(hiredate) AS 年 FROM employees;
>
> SELECT MONTH(NOW()) 月;
> SELECT MONTHNAME(NOW()) 月;

+ **str_to_date(字符串，解析格式)**

<img src=https://user-images.githubusercontent.com/90008408/132106548-3d06aaff-6233-4a76-adf7-6dae7393a3e6.PNG width='400'>

> SELECT STR_TO_DATE('1998-12-5','%Y-%c-%d') AS out_out;
>
> SELECT * FROM employees WHERE hiredate='1992-4-3';
> SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

+ **date_format(日期，按解析格式转换成字符)**

> SELECT DATE_FORMAT('1998-12-5','%Y年%m月%d日') 生日;
>
> e.g1 查询有奖金员工名和入职日期（..月/..日 ..年）</br>
> SELECT last_name, DATE_FORMAT(hiredate,'%m月/%d日 %y年') </br>
> FROM employees </br>
> WHERE commission_pct IS NOT NULL;

+ **datediff(日期，日期)**： 相差天数

> SELECT DATEDIFF('2021-1-25','2021-9-5');
>
> SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) FROM employees;	

</br>

4.其他函数

> SELECT VERSION();</br>
> SELECT DATABASE();</br>
> SELECT USER();</br>
> SELECT PASSWORD('str');(8.0废弃)</br>
> SELECT MD5('str')

</br>

5.流程控制函数

+ **if函数**

> SELECT IF(10>5,'大','小');
>
> SELECT last_name, commission_pct,</br>
> IF(commission_pct IS NULL,'没奖金，哈哈','有奖金，嘻嘻') 备注 </br>
> FROM employees;

+ **case函数（结构）**

用法一：【类似swithch case，用于等值判断】</br>
> CASE 要判断的字段或表达式</br>
> WHEN 常量1 THEN 要显示的值1或 语句1; </br>
> WHEN 常量2 THEN 要显示的值2或 语句2; </br>
> ...</br>
> ELSE 要显示的值n或语句n; </br>
> END;

> e.g1 查询员工的工资，要求部门分别为30，40，50时工资显示为1.1，1.2，1.3倍，其他不动:</br>
> 
> SELECT salary AS 原始工资,department_id, </br>
> CASE department_id </br>
> WHEN 30 THEN salary\*1.1 </br>
> WHEN 40 THEN salary\*1.2 </br>
> WHEN 50 THEN salary\*1.3 </br>
> ELSE salary </br>
> END AS 最终工资 </br>
> FROM employees </br>
> ORDER BY 最终工资 DESC;

用法二：【类似多重if，用于不等判断】</br>

> CASE </br>
> WHEN 条件1 THEN 要显示的值1或 语句1; </br>
> WHEN 条件2 THEN 要显示的值2或 语句2; </br>
> ...</br>
> ELSE 要显示的值n或 语句n; </br>
> END;

>e.g2 查询员工工资，>20000 A,>15000 B,>10000 C,否则 D </br>
> SELECT salary,</br>
> CASE</br>
> WHEN salary>20000 THEN 'A'</br>
> WHEN salary>15000 THEN 'B'</br>
> WHEN salary>10000 THEN 'C'</br>
> ELSE 'D'</br>
> END AS 工资级别</br>
> FROM employees;





