# SQL

## 2.SQL语言

### 2.2 DQL语言

#### 2.2.7 分页查询

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
> select * from employees</br>
> limit 0,5;

> e.g2 查询第11条到25条</br>
> select * from employees</br>
> limit 10,15;

> e.g3 查询有奖金的员工的信息，工资较高的前10名</br>
> select * from employees</br>
> where commission_pct is not null</br>
> order by salary desc</br>
> limit 10;






