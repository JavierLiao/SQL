# SQL

## 2.SQL语言

### 2.2 DQL语言

#### 2.2.8 分页查询

应用场景：要显示的数据一页显示不全，需要分页提交SQL请求

> SELECT **查询列表**</br>
> FROM **table1**</br>
> [JOIN TYPE] JOIN **table2**</br>
> ON **连接条件**</br>
> WHERE **筛选条件**</br>
> GROUP BY **分组字段**</br>
> HAVING **分组后筛选**</br>
> ORDER BY **排序字段**</br>
> LIMIT **offset，size**;

offset要显示条目的起始索引（起始索引从0开始），size要显示的条目个数

> e.g1 查询前5条员工信息</br>
```sql
SELECT * FROM employees
LIMIT 0,5;
```

> e.g2 查询第11条到25条</br>
```sql
SELECT * FROM employees
LIMIT 10,15;
```

> e.g3 查询有奖金的员工的信息，工资较高的前10名</br>
```sql
SELECT * FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC
LIMIT 10;
```

</br>

#### 2.2.9 联合查询

将多条查询语句的结果合并成一个结果

> **查询语句1**</br>
> UNION</br>
> **查询语句2**

应用场景：要查询的结果来自于多个表，但没有连接条件，且查询内容一样

特点：

- 要求多条查询语句的查询列数是一致的
- 要求多条查询语句查询的每一列的类型和顺序最好一致
- UNION关键字默认去重，UNION ALL可以包含重复项

</br>

### 2.3 DML语言

数据操作语言
- 插入：INSERT
- 修改：UPDATE
- 删除：DELETE

</br>

#### 2.3.1 插入语句

(1) VALUES插入

>INSERT INTO **表名（列名,...）**</br>
>VALUES(**值1,...**)


- 插入的值类型要与列的类型一致或兼容
```sql
insert into beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
values (13, '唐艺昕', '女', '1990-4-23', '18988888', null, 2);
```

- 可以为null的列如何插入值
  - 方法一：直接写NULL
  - 方法二：列名与插入值都不写
```sql
insert into beauty(id, name, sex, phone)
values (15, '娜扎', '女', '18596592658');
```

- 列的顺序是否可以调换
```sql
insert into beauty( name, id, sex, phone)
values ('蒋欣', 16 , '女', '1856652658');
```

- 列数和值的个数必须一致
```sql
insert into beauty( name, id, sex, phone, boyfriend_id)
values ('关晓彤', 17 , '女', '1856652658');
```

- 可以省略列名，默认所有列，但顺序必须一致
```sql
insert into beauty
values (18 , '张飞', '男', null, '119', null, 1);
```

(2) SET插入

> INSERT INTO **表名**
> SET **列名=值**,**列名=值**,...

```sql
insert into beauty
set id=19, name='刘涛', phone='999';
```

(3)两种方式pk

- VALUES插入支持插入多行，SET不支持
```sql
insert into beauty
values (20, '唐艺昕1', '女', '1990-4-23', '18988888', null, 2)
,(21, '唐艺昕2', '女', '1990-4-23', '18988888', null, 2)
,(22, '唐艺昕3', '女', '1990-4-23', '18988888', null, 2);
```

- VALUES支持子查询，SET不支持

</br>

#### 2.3.2 修改语句

(1) 修改单表的记录

> UPDETE **表名**</br>
> SET **列=新值**, **列=新值**, ...</br>
> WHERE **筛选条件**;

> e.g1 修改beauty中姓唐的女生的电话为188888888
```sql
update beauty 
set phone = '188888888' 
where `name` like '唐%';
```

> e.g2 修改2号男神名为张飞，魅力值为10
```sql
update boys
set boyname='张飞', usercp=10
where id=2;
```

(2)修改多表的记录

SQL92语法
> UPDATE **表1 别名**, **表2 别名**,...</br>
> SET **列=值**,**列=值**,...</br>
> WHERE **连接条件**</br>
> AND **筛选条件**;

SQL99语法
> UPDATE **表1 别名**</br>
> **连接类型** JOIN **表2 别名**</br>
> ON **连接条件**</br>
> SET **列=值**,**列=值**,...</br>
> WHERE **筛选条件**;

> e.g1 修改张无忌的女朋友的手机号为114
```sql
update boys bo
inner join beauty b
on bo.id = b.boyfriend_id
set b.phone = '114'
where bo.boyname = '张无忌';
```

> e.g2 修改没有男朋友的女神的男朋友编号都为2
```sql
update boys bo
right join beauty b
on bo.id = b.boyfriend_id
set b.boyfriend_id=2
where bo.id is null;
```

</br>

#### 2.3.3 删除语句

(1)DELETE删除
- 单表删除
> DELETE FROM **表名**</br>
> WHERE **筛选条件**

> e.g 删除手机编号以9结尾的女神信息
```sql
delete from beauty
where phone like '%9';
```

- 多表删除

SQL92语法
> DELETE **表1或表2别名**</br>
> FROM **表1 别名**, **表2 别名**</br>
> WHERE **连接条件**</br>
> AND **筛选条件**

SQL99语法
> DELETE **表1或表2别名**</br>
> FROM **表1 别名**</br>
> **连接类型** JOIN **表2 别名**</br>
> ON **连接条件**</br>
> WHERE **筛选条件**

> e.g1 删除张无忌女朋友的信息
```sql
delete b
from beauty b
inner join boys bo
on b.boyfriend_id = bo.id
where boyName='张无忌';
```

> e.g2 删除黄晓明以及他女朋友的信息
```sql
delete b,bo
from beauty b
inner join boys bo
on b.boyfriend_id = bo.id
where boyName='黄晓明';
```

(2) TRUNCATE删除(全部删除)
> TRUNCATE **表名**

(3)DELEDE&TURNCATE比较

- 删除的表中有自增长列，用DELETE删除后，自增长列从断点开始；TRUNCATE删除后，从1开始
- TRUNCATE删除后无返回值，DEOELTE删除后有返回值
- TRUNCATE删除不能回滚，DELETE删除可以回滚









