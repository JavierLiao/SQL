
##排序查询

#查询员工信息，工资从高到低排序：
SELECT * FROM employees ORDER BY salary ASC;

#查询员工信息，部门编号>=90，入职先后排序：
SELECT * FROM employees WHERE department_id>=90 ORDER BY hiredate ASC;

#查询员工信息，按年薪高低显示:
SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 
FROM employees 
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;

SELECT *,salary*12*(1+IFNULL(commission_pct,0)) AS 年薪 
FROM employees 
ORDER BY 年薪 DESC;

#按名字长度排序显示员工姓名工资：
SELECT last_name,salary,LENGTH(last_name) AS 长度
FROM employees
ORDER BY LENGTH(last_name);

SELECT last_name,salary,LENGTH(last_name) AS 长度
FROM employees
ORDER BY 长度;

#查询信息，先按工资排序，再按员工编号排序:
SELECT *
FROM employees
ORDER BY salary ASC,employee_id DESC;





##常见函数
#1.字符函数

#length()
SELECT LENGTH('John');
SELECT LENGTH('你是sb');

SHOW VARIABLES LIKE '%char%';

#concat()
SELECT CONCAT(last_name,'_',first_name) FROM employees;

#upper(),lower()
SELECT UPPER('john');
SELECT CONCAT(UPPER(last_name),LOWER(first_name)) FROM employees;

#substr(字符串,起始索引,截取字符长度)
SELECT SUBSTR('我是你爹',4);
SELECT SUBSTR('我是你爹',1,2);

SELECT 
CONCAT(UPPER(SUBSTR(last_name,1,1)),
	LOWER(SUBSTR(last_name,2)),
	'_',
	LOWER(first_name)) 
AS 姓名 
FROM employees; 

#instr(字符串,字符串中一段)
SELECT INSTR('我是你爹','爹') out_put;

#trim(字符串)
SELECT TRIM('   我  是  你   爹  ') AS out_put;
SELECT LENGTH(TRIM('   我  是  你   爹  ')) AS out_put;
SELECT TRIM('a' FROM 'aaaaaa我aaaaa是aaa你aaaa爹aaaaa') AS out_put;

#lpad(字符串,长度,字符),rpad()
SELECT LPAD('我是你爹',10,'爹');

#replace()
SELECT REPLACE('张无忌爱上了周芷若','周芷若','赵敏');



#2.数学函数

#round(数字, 保留位数)
SELECT ROUND(2.559,2);

#ceil(数字)
SELECT CEIL(-1.23);

#floor(数字)
SELECT FLOOR(-1.23);

#truncate(数字,截断保留位数)
SELECT TRUNCATE(1.6655,2);

#mod(数字,数字)
SELECT MOD(12,5);
SELECT 12%5;


#3.日期函数

#now() 返回当前时间
SELECT NOW();

#curdate() 返回当前日期，不包含时间
SELECT CURDATE();

#curtime() ：返回当前时间，不包含日期
SELECT CURTIME();

#获取时间指定部分：year(),mongth(),monthname()，
#                  day(),hour(),minute(),second()
SELECT YEAR(NOW());
SELECT YEAR('1998.12.5')
SELECT YEAR(hiredate) AS 年 FROM employees;

SELECT MONTH(NOW()) 月;
SELECT MONTHNAME(NOW()) 月;

#str_to_date(日期字符串，解析格式)
SELECT STR_TO_DATE('1998-12-5','%Y-%c-%d') AS out_out;

SELECT * FROM employees WHERE hiredate='1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y');

#date_format(日期，按解析格式转换成字符)
SELECT DATE_FORMAT('1998-12-5','%Y年%m月%d日') 生日;

SELECT last_name, DATE_FORMAT(hiredate,'%m月/%d日 %y年') AS 入职日期 
FROM employees 
WHERE commission_pct IS NOT NULL;



#3.其他函数
SELECT VERSION();
SELECT DATABASE();
SELECT USER();


#4.流程控制函数

#if函数
SELECT IF(10>5,'大','小');

SELECT last_name, commission_pct,
IF(commission_pct IS NULL,'没奖金，哈哈','有奖金，嘻嘻') 备注 
FROM employees;


#case结构
#用法一
SELECT salary AS 原始工资,department_id,
CASE department_id
WHEN 30 THEN salary*1.1
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END
AS 最终工资
FROM employees
ORDER BY 最终工资 DESC;

#用法二
SELECT salary,
CASE
WHEN salary>20000 THEN 'A'
WHEN salary>15000 THEN 'B'
WHEN salary>10000 THEN 'C'
ELSE 'D'
END AS 工资级别
FROM employees;




















