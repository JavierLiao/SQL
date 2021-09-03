# SQL

## MySQL基础

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
