###2.2.8分页查询

#查询前5条员工信息
SELECT * FROM employees
LIMIT 0,5;

#查询第11条到25条
SELECT * FROM employees
LIMIT 10,15;

#查询有奖金的员工的信息，工资较高的前10名
SELECT * FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC
LIMIT 10;


###练习
#查询工资最低的员工信息：last_name,salary
SELECT last_name, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
    FROM employees
);

#查询平均工资最低的部门信息
SELECT *
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
    ORDER BY AVG(salary)
    LIMIT 1
); 




### 2.2.9联合查询
#查询部门编号>90或者邮箱包含a的员工信息
select * 
from employees
where email like '%a%'
or department_id > 90;

select * from employees where email like '%a%'
union
select * from employees where department_id > 90;


##2.3 DML

### 2.3.1 插入
insert into beauty(id, name, sex, borndate, phone, photo, boyfriend_id)
values (13, '唐艺昕', '女', '1990-4-23', '18988888', null, 2);

insert into beauty(id, name, sex, phone)
values (14, '金星', '女', '18952658');

insert into beauty(id, name, sex, phone)
values (15, '娜扎', '女', '18596592658');

insert into beauty( name, id, sex, phone)
values ('蒋欣', 16 , '女', '1856652658');

insert into beauty( name, id, sex, phone, boyfriend_id)
values ('关晓彤', 17 , '女', '1856652658');


insert into beauty( name, id, sex, phone, boyfriend_id)
values ('关晓彤', 17 , '女', '1856652658');

insert into beauty
values (18 , '张飞', '男', null, '119', null, 1);


#(2)SET插入
insert into beauty
set id=19, name='刘涛', phone='999';

#(3)两方式pk

insert into beauty
values (20, '唐艺昕1', '女', '1990-4-23', '18988888', null, 2)
,(21, '唐艺昕2', '女', '1990-4-23', '18988888', null, 2)
,(22, '唐艺昕3', '女', '1990-4-23', '18988888', null, 2);

insert into beauty(id, name, phone)
select 26, '宋茜', '1115162';



### 2.3.2修改语句
##修改单表
#修改beauty中姓唐的女生的电话为188888888
update beauty 
set phone = '188888888' 
where `name` like '唐%';

#修改2号男神名为张飞，魅力值为10
update boys
set boyname='张飞', usercp=10
where id=2;

##修改多表
#修改张无忌的女朋友的手机号为114
update boys bo
inner join beauty b
on bo.id = b.boyfriend_id
set b.phone = '114'
where bo.boyname = '张无忌';

#修改没有男朋友的女神的男朋友编号都为2
update boys bo
right join beauty b
on bo.id = b.boyfriend_id
set b.boyfriend_id=2
where bo.id is null;

###2.3.3 删除语句
##单表的删除
#删除手机编号以9结尾的女神信息
delete from beauty
where phone like '%9';

##多表删除
#删除张无忌女朋友的信息
delete b
from beauty b
left join boys bo
on b.boyfriend_id = bo.id
where boyName='张无忌';

#删除黄晓明以及他女朋友的信息
delete b,bo
from beauty b
inner join boys bo
on b.boyfriend_id = bo.id
where boyName='黄晓明';


##TRUNCATE删除(整表删除)
truncate table boys;




