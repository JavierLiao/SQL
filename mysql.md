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

> use **database**;

> show tables;

> select database();

> show tables from **database**;

> desc **table**;

> creat table **table**( </br> **field1**  **type** ，</br>  **field2**   **type**）;

> selece * from **table**;

> insert into **table(field1, field2)** values(**value1**, **value2**);

> update **table** set **field1**=**value1** where **field2**=**value2**;

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

### 2.DQL语言

#### (1). 基础查询

> select **查询列表** from **表名**；

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

**注意：··可以区分关键字与字段**

4. 查询常量值

> select **数值or字符串**；

5. 查询表达式

> select **表达式**；

6. 查询函数

> select **函数**；

7. 为查询值起别名

> select **查询内容** as **别名**;

> select **查询内容1** as **别名1**,**查询内容2** as **别名2** from **table**;

> select **查询内容1** **别名1**,**查询内容2** **别名2** from **table**;

**好处：便于理解；查询字段有重名的情况，便于区分**

**注意：别名中有关键字或特殊符号，加双引号或单引号区分**

8. 去重

> select distinct **field** from **table**;

9. +号的作用


