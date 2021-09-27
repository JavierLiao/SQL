# SQL

## 2.SQL语言

### 2.4 DDL语言

#### 2.4.1 库的管理

(1) 库的创建
```sql
create database if not exists books;
```
(2)库的修改
```sql
alter database books character set gbk;
```
(3)库的删除
```sql
drop database if exists books;
```
</br>

#### 2.4.2 表的管理

(1)表的创建

> CREAT TABLE **表名**(</br>
>     **列名 列类型 [长度 约束],**</br>
>     **列名 列类型 [长度 约束],**</br>
>     **列名 列类型 [长度 约束],**</br>
>     ...</br>
> )

```sql
create table book(
        id int, 
        bname varchar(20),
        price double,
        authorId int,
        publishDate datetime
);

create table author(
        id int, 
        au_name varchar(20),
        nation varchar(20)
);
```

(2)表的修改

> ALTER TABLE **表名**</br>
> [CHANGE/MODIFY/ADD/DROP/RENAME TO] COLUMN **列名 [列类型 约束]**;

- 修改列名
- 修改列的类型或约束
- 删除添加列
- 修改表名

```sql
alter table book 
change column publishDate pubDate datetime;

alter table book modify column pubDate timestamp;

alter table author add column annual double;

alter table author drop column annual;

alter table author rename to book_author;
```

(3)表的删除
```sql
drop table if exists book_author;
```

**通用写法**
```sql
drop database if exists 旧库名
create database 新库名

drop table if exists 旧表名
create table 表名()
```

(4)表的复制
- 仅复制表的结构
```sql
create table copy like author;
```
- 复制表的结构以及数据
```sql
create table copy2
select * from author;

create table copy3
select * from author
where nation='中国';
```
- 复制表的某些字段结构
```sql
create table copy4
select id,au_name from author
where 0;
```



