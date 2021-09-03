# SQL

## 一、MySQL基础

### 1. MySQL服务的登录与退出
登录

* SQL自带客户端（仅限root用户）
+ windows客户端

>mysql -u root -p

退出

>exit

###  2.常用语句
> show databases;
>
> use **database**;
>
> show tables;
>
> select database();
>
> show tables from **database**;
>
> desc **table**;
>
> creat table **table**( </br> **field1**  **type** ，</br>  **field2**   **type**）;
>
> selece * from **table**;
>
> insert into **table(field1, field2)** values(**value1**, **value2**);
>
> update **table** set **field1**=**value1** where **field2**=**value2**;
>
> delete from **table** where **field**=**value**;

### 3.语法规范
1. 不区分大小写,建议关键字大写，表名、列名小写

2. 每条命令分号结尾

3. 每条命令根据需要可以缩进或换行

4. 注释

  + 单行注释：#注释文字
  + 单行注释：--注释文字
  + 多行注释： /* 注释文字 */

</br>

## 二、SQL语言

### 1.SQL语言细分

+ DQL语言(Data Query Language)
+ DML语言(Data Manipulation Language)
+ DDL语言(Data Definition Language)
+ TCL语言(Transaction Control Language)

</br>

### 2.DQL语言

#### (1). 基础查询

> select **查询列表** from **table**；

特点
+ 查询列表可以是：
   + 表中字段
   + 常量值
   + 表达式
   + 函数  
+ 查询结果是虚拟表格

</br>

1. 查询表中单个字段

> select **field** from **table**;

2. 查询表中多个字段

> select **field1**,**field2**,**field3** from **table**;

3. 查询表中所有字段

> select * from **table**;

*注意：··可以区分关键字与字段*

4. 查询常量值

> select **数值or字符串**；

*字符串或日期需用单引号标注*

5. 查询表达式

> select **表达式**；

6. 查询函数

> select **函数**；

7. 为查询值起别名

> select **查询内容** as **别名**;
>
> select **查询内容1** as **别名1**,**查询内容2** as **别名2** from **table**;
>
> select **查询内容1** **别名1**,**查询内容2** **别名2** from **table**;

*好处：便于理解；查询字段有重名的情况，便于区分*

*注意：别名中有关键字或特殊符号，加双引号或单引号区分*

8. 去重

> select distinct **field** from **table**;

9. 字段拼接：concat()函数

> select concat(**field1**,**field2**) as **别名** from **table**;

*有null值的字段拼接：*

> select concat(**field1**,**'空格or逗号'**,ifnull(**field2**,0)) as **别名** from **table**;

</br>

#### (2). 条件查询

> select **查询列表** from **table** where **condition**

1. 按条件表达式查询
  + 条件运算符：'>'  '<' '='  '<>(!=)'  '>='  '<='

> e.g1: SELECT * FROM employees WHERE salary>12000;
>
> e.g2: SELECT last_name,department_id FROM employees WHERE department_id!=90;

2. 按逻辑表达式查询
  + 逻辑运算符：'&&(and)' '||(or)' '!(not)'

> e.g1: SELECT last_name,salary,commission_pct FROM employees WHERE salary>=10000 AND salary<=20000;
>
> e.g2: SELECT * FROM employees WHERE department_id<90 OR department_id>110 OR salary>12000;
>
> e.g2(法二)： SELECT * FROM employees WHERE NOT(department_id>=90 AND department_id<=110) OR salary>12000;


3. 模糊查询
+ like
  + 一般和通配符搭配使用：'%'(任意多个字符) '_'(任意单个字符） ！！使用反斜杠或ESCAPE自定义符号进行转义

> e.g1 筛选名字含有a的员工信息：SELECT * FROM employees WHERE last_name LIKE '%a%';
>
> e.g2 筛选名字第三个字母为n，第五个字母为l的员工信息：SELECT * FROM employees WHERE last_name LIKE '__n_l%';
>
> e.g3 转义 SELECT * FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$';

+ between...and...
  + 等价于>= and <=(包含临界值，且大小数值不能调换位置)

> e.g SELECT * FROM employees WHERE department_id BETWEEN 100 AND 120;

+ in
  + 与连续的OR表达式类似
  + in列表的值必须一致或兼容
  + 不支持通配符使用

> e.g SELECT last_name,job_id FROM employees WHERE job_id IN('IT_PROG','AD_VP','AD_PRES');

+ is null & is not null
  + 不能使用 = NULL类似语句
  + 安全等于号：<=>

> e.g SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NULL;
