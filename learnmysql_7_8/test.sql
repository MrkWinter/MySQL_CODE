#删除数据库指令
DROP DATABASE db02
#创建一个数据库指令
CREATE DATABASE IF NOT EXISTS db01
#创建指定字符集的数据库 默认校对规则为utf8_general_ci 不区分大小写
CREATE DATABASE db02 CHARACTER SET utf8
#创建指定校对规则的数据库 校对规则 utf8_bin区分大小写 
CREATE DATABASE db03 CHARACTER SET utf8 COLLATE utf8_bin
#规定数据库的字符集和校验规则在创建表时对应的为默认
#区分大小写和不区分大小写就是表中数据是否当成一个看
#搜索db02表中数据 name值为tom的 不区分大小写
SELECT * FROM user01 WHERE NAME = 'tom'
#搜索db03表中数据 name值为tom的 不区分大小写
SELECT * FROM user01 WHERE NAME = 'tom'


#查看所有数据库
SHOW DATABASES
#查看指定创建的数据库详细信息
SHOW CREATE DATABASE db03
#``可以规避关键字
CREATE DATABASE `int` CHARACTER SET utf8 COLLATE utf8_bin
#删除数据库
DROP DATABASE `int`

#备份数据库 cmd下
mysqldump -u root -p -B db03 db02 > D:\VS项目\MySQL\learnmysql_7_8\source\bf.sql
#恢复数据库 mysql下
source D:\VS项目\MySQL\learnmysql_7_8\source\bf.sql

#在db01下创建表
CREATE TABLE user01 (id INT,`name` VARCHAR(255),`password` VARCHAR(20),birthday DATE) CHARACTER SET utf8 COLLATE utf8_bin
#在db02下创建表
CREATE TABLE user02 (id INT,NAME VARCHAR(255),birstday VARCHAR(30)) CHARACTER SET utf8 COLLATE utf8_bin ENGINE INNODB


INSERT INTO user01 VALUE(123,'li','23',NULL);

#演示时间相关的数据类型  创建表
CREATE TABLE user02 (birthday DATE,job_time DATETIME,login_time TIMESTAMP 
	NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);
#not null default current_timestamp on update current_timestamp 该语句是设置时间为当前时间或更新时间
#插入表中数据
INSERT INTO user02(birthday,job_time) VALUES('2022-11-11','2022-11-11 10:10:10');
#如果更新新表中某条信息 (包含插入和更新) login_time 会自动的以当前时间进行更新
SELECT * FROM user02

#创建表练习
CREATE TABLE user03 (id INT , `name` VARCHAR(50) , sex CHAR(4),birthday DATE,entry_date DATETIME,
	job TEXT,salary DOUBLE,`resume`LONG) CHARACTER SET utf8 COLLATE utf8_bin ENGINE INNODB;
#插入表中数据
INSERT INTO user03 VALUES(1234,'王五','男','2023-2-2','2023-4-4 3:23:22','自由职业',1433.452,'ddddd');
SELECT * FROM user03
#备份表
mysqldump -u root -p db01 user03 > C:\Mysoftware\MySQL\MySQLSource\biao2.sql
#删除表
DROP TABLE user03
#恢复表
source C:\Mysoftware\MySQL\MySQLSource\biao2.sql

#显示所有列信息
DESC user03
#1. 添加列
ALTER TABLE user03 ADD imange VARCHAR(30) NOT NULL DEFAULT '' AFTER RESUME
#2. 修改列
ALTER TABLE user03 MODIFY imange VARCHAR(20) NOT NULL DEFAULT ''
#3. 删除列
ALTER TABLE user03 DROP imange
#4. 修改表名
RENAME TABLE user03 TO user04
RENAME TABLE user04 TO user03
#5. 修改字符集
ALTER TABLE user03 CHARACTER SET utf8
ALTER TABLE user03 COLLATE utf8_general_ci
ALTER TABLE user03 ENGINE INNODB
#6. 修改列名 有修改列的功能
ALTER TABLE user03 CHANGE `name` username VARCHAR(32) NOT NULL DEFAULT ''
DESC user03 


#insert语句
DESC user04
DROP TABLE user04
CREATE TABLE user04 (id INT,`name` VARCHAR(30),sex CHAR(3)) CHARACTER SET utf8 COLLATE utf8_bin ENGINE INNODB
INSERT INTO user04 (id,`name`,sex) VALUES(21231,'王维','男')
INSERT INTO user04 VALUES(2321,'李白','女')
SELECT * FROM user04
#update 语句
UPDATE user04 SET id = 12345
SELECT * FROM user04
UPDATE user04 SET id = id + 1000 WHERE NAME = '王维'
#delete 语句
DELETE FROM user04
DELETE FROM user04 WHERE NAME = '王维'
SELECT* FROM user04

#创建学生表
CREATE TABLE student (id INT NOT NULL DEFAULT 1,NAME VARCHAR(20) NOT NULL DEFAULT '',
	chinese FLOAT NOT NULL DEFAULT 0.0, english FLOAT NOT NULL DEFAULT 0.0,math FLOAT NOT NULL DEFAULT 0.0)  
	CHARACTER SET utf8 COLLATE utf8_bin ENGINE INNODB;
INSERT INTO student(id,NAME,chinese,english,math) VALUES(1,'韩顺平',89,78,90);
INSERT INTO student(id,NAME,chinese,english,math) VALUES(2,'张飞',67,98,56);
INSERT INTO student(id,NAME,chinese,english,math) VALUES(3,'宋江',87,78,77);
INSERT INTO student(id,NAME,chinese,english,math) VALUES(4,'关羽',88,98,90);
INSERT INTO student(id,NAME,chinese,english,math) VALUES(5,'赵云',82,84,67);
INSERT INTO student(id,NAME,chinese,english,math) VALUES(6,'欧阳锋',55,85,45);
INSERT INTO student(id,NAME,chinese,english,math) VALUES(7,'黄蓉',75,65,30);
#select 语句
#查询表中所有列信息
SELECT * FROM student
#查询表中所有学生姓名和英语成绩信息
SELECT NAME,english FROM student
#过滤查询得到表中行信息相同的信息内容
SELECT DISTINCT english FROM student
#查询的记录 每个字段都相同 才判定位相同

#查询所有同学的总分
SELECT NAME,(chinese+english+math) AS total FROM student
#查询给所有同学总分加10分的情况
SELECT NAME, chinese+english+math +10 AS total FROM student

#where 子句的运算符
#查询姓名为赵云的同学信息
SELECT * FROM student WHERE NAME = '赵云'
#查询英语成绩大于90 分的同学
SELECT * FROM student WHERE english>90
#查询总分大于200分的同学 
SELECT * FROM student WHERE chinese + math + english > 200
SELECT * FROM student WHERE math > 60 AND math<90
SELECT * FROM student WHERE english > chinese
#模糊查询%表示0-多个 表示以韩开头的
SELECT * FROM student WHERE chinese + math +english>200 AND math<chinese AND NAME LIKE '赵%'
#between and 表示闭区间
SELECT * FROM student WHERE chinese BETWEEN 50 AND 60
#in 查询表示等于()中的内容的
SELECT * FROM student WHERE math IN(89,90,91)

#order by排序
SELECT * FROM student ORDER BY chinese ASC
SELECT NAME ,(chinese + math + english) AS total FROM student ORDER BY total DESC
SELECT * FROM student ORDER BY (chinese + math)
#count函数
SELECT COUNT(*) FROM student WHERE math > 60 
SELECT COUNT(NAME) FROM student WHERE math > 60
#sum函数
SELECT SUM(math) FROM student
SELECT SUM(NAME) FROM student
#avg函数
SELECT AVG(math) FROM student
SELECT AVG(NAME) FROM student
#max min 函数 
SELECT MAX(english) FROM student
SELECT MIN(english) FROM student


CREATE TABLE dept( /*部门表*/
deptno MEDIUMINT   UNSIGNED  NOT NULL  DEFAULT 0, 
dname VARCHAR(20)  NOT NULL  DEFAULT "",
loc VARCHAR(13) NOT NULL DEFAULT ""
);

INSERT INTO dept VALUES(10, 'ACCOUNTING', 'NEW YORK'), (20, 'RESEARCH', 'DALLAS'), (30, 'SALES', 'CHICAGO'), (40, 'OPERATIONS', 'BOSTON');




#创建表EMP雇员
CREATE TABLE emp
(empno  MEDIUMINT UNSIGNED  NOT NULL  DEFAULT 0, /*编号*/
ename VARCHAR(20) NOT NULL DEFAULT "", /*名字*/
job VARCHAR(9) NOT NULL DEFAULT "",/*工作*/
mgr MEDIUMINT UNSIGNED ,/*上级编号*/
hiredate DATE NOT NULL,/*入职时间*/
sal DECIMAL(7,2)  NOT NULL,/*薪水*/
comm DECIMAL(7,2) ,/*红利*/
deptno MEDIUMINT UNSIGNED NOT NULL DEFAULT 0 /*部门编号*/
);

 
 INSERT INTO emp VALUES(7369, 'SMITH', 'CLERK', 7902, '1990-12-17', 800.00,NULL , 20), 
(7499, 'ALLEN', 'SALESMAN', 7698, '1991-2-20', 1600.00, 300.00, 30),  
(7521, 'WARD', 'SALESMAN', 7698, '1991-2-22', 1250.00, 500.00, 30),  
(7566, 'JONES', 'MANAGER', 7839, '1991-4-2', 2975.00,NULL,20),  
(7654, 'MARTIN', 'SALESMAN', 7698, '1991-9-28',1250.00,1400.00,30),  
(7698, 'BLAKE','MANAGER', 7839,'1991-5-1', 2850.00,NULL,30),  
(7782, 'CLARK','MANAGER', 7839, '1991-6-9',2450.00,NULL,10),  
(7788, 'SCOTT','ANALYST',7566, '1997-4-19',3000.00,NULL,20),  
(7839, 'KING','PRESIDENT',NULL,'1991-11-17',5000.00,NULL,10),  
(7844, 'TURNER', 'SALESMAN',7698, '1991-9-8', 1500.00, NULL,30),  
(7900, 'JAMES','CLERK',7698, '1991-12-3',950.00,NULL,30),  
(7902, 'FORD', 'ANALYST',7566,'1991-12-3',3000.00, NULL,20),  
(7934,'MILLER','CLERK',7782,'1992-1-23', 1300.00, NULL,10);



#工资级别表
CREATE TABLE salgrade
(
grade MEDIUMINT UNSIGNED NOT NULL DEFAULT 0,
losal DECIMAL(17,2)  NOT NULL,
hisal DECIMAL(17,2)  NOT NULL
);

INSERT INTO salgrade VALUES (1,700,1200);
INSERT INTO salgrade VALUES (2,1201,1400);
INSERT INTO salgrade VALUES (3,1401,2000);
INSERT INTO salgrade VALUES (4,2001,3000);
INSERT INTO salgrade VALUES (5,3001,9999);

# 查询部门中工资平均数和最大数
SELECT * FROM emp
SELECT AVG(sal),MAX(sal),deptno FROM emp GROUP BY deptno
#查询每个部门目的每种岗位的平均工资和最低工资
SELECT deptno,job,AVG(sal),MIN(sal)FROM emp GROUP BY deptno,job
#显示平均工资低于2000的部门号和它的平均工资
SELECT deptno,AVG(sal) AS avgsal FROM emp GROUP BY deptno HAVING avgsal<2000 

#演示字符串相关函数的使用 
#1. charset(str) 返回字符串集
SELECT CHARSET(ename) FROM emp
#2. concat(字段) 连接子串 将多个列拼成一列
SELECT CONCAT(ename,'工作是',job) FROM emp
#3. instr(str,sub) 返回sub在str中的出现位置从1开始 没有出现返回0
#dual 亚元表 系统表 可以作为测试表使用
SELECT INSTR('abcdef','def') FROM DUAL 
#4. ucaee(字段) 转成大写
SELECT UCASE(ename) FROM emp
#5. lcaee(字段) 转成小写
SELECT LCASE(ename) FROM emp
#6. left(str,len) 从左边取len个字符
SELECT LEFT('hhh',2) FROM DUAL
SELECT LEFT(ename,2) FROM emp
#7. right(str,len) 从左边取len个字符
SELECT RIGHT(ename,2) FROM emp
#8. length(str) 返回str的字节长度
SELECT LENGTH(ename) FROM emp
#9. replace(字段,search_str,replace_str) 查询字段 如果是search_str 替换成replace_str 就是查询时的update替换
SELECT ename,REPLACE(job,'MANAGER','经理') FROM emp
#10. strcmp(str1,str2) 判断字符是否相同 返回值和java中字符串equals相同 比较按表的校验规则计算来看是否区分大小写
SELECT STRCMP('hh','hh') FROM DUAL
SELECT STRCMP(job,'hh') FROM emp
#11. substring(str,start,end) 从str的第start位置 取到第end个位置若end不写则取到最后所有的字符 闭区间 并且字符串下标从1开始
SELECT SUBSTRING('abcd',1,3) FROM DUAL
SELECT SUBSTRING(ename,1,3) FROM emp 
#12. ltrim() rtrim()  trim() 去掉 左 右 两边的空格
SELECT LTRIM('  hh') FROM DUAL
SELECT RTRIM('hh  ') FROM DUAL
SELECT TRIM('  hh  ') FROM DUAL
#以首字母小写的形式显示所有员工表的姓名
SELECT CONCAT(LCASE(SUBSTRING(ename,1,1)),SUBSTRING(ename,1)) FROM emp
SELECT CONCAT(LCASE(LEFT(ename,1)),SUBSTRING(ename,1,100)) FROM emp

#数学相关函数
#1. abs(num) 求num的绝对值
SELECT ABS(-2) FROM DUAL 
#2. bin(num) num十进制转二进制
SELECT BIN(34) FROM DUAL
#3. ceiling 向上取整
SELECT CEILING(3.2) FROM DUAL
#4. floor 向下取整
SELECT FLOOR(4.9) FROM DUAL
#5. conv(num,form_base,to_base) num 是 from_base进制的数 转换成 to_base进制的数
SELECT CONV(32,16,10) FROM DUAL
#6. format(num,decimal_num) num 保留 decima_num位的小数
SELECT FORMAT(3.223123,3) FROM DUAL
#7. hex(num) num 转十六进制
SELECT HEX(89) FROM DUAL
#8. least(num1,num2,num3...) 求最小值
SELECT LEAST(2,56,782,1,4) FROM DUAL
#9. mod(num,deom) num%deom 的值
SELECT MOD(5,2) FROM DUAL
#10. rand(num) 返回随机数 范围是0-1.0 num为种子 给定始终返回固定值
SELECT RAND() FROM DUAL

#时间日期类
#1. current_date() 当前日期
SELECT CURRENT_DATE() FROM DUAL
#2. current_time() 当前时间
#   now() 当前时间
SELECT CURRENT_TIME() FROM DUAL
#3. current_timestamp() 当前时间戳
SELECT CURRENT_TIMESTAMP() FROM DUAL
DROP TABLE news
CREATE TABLE news(id INT, `position` VARCHAR(255), times DATETIME)
INSERT INTO news VALUE(1,'北京新闻',NOW());
INSERT INTO news VALUE(1,'天京新闻',NOW());
INSERT INTO news VALUE(1,'湖北新闻',NOW());


#1. date(datetime) 函数可以返回日期部分 年月日
#   year() month() day() 返回 年 月 日
#显示所有新闻信息 发布日期值显示 日期 不显示时间
SELECT id,`position`,DATE(times) FROM news

#2. date_add(time,interval_time) 返回time加上intervar_time后的时间
#   date_sub(time,interval_time) 返回time减去intervar_time后的时间
#   time 可以是 year month day hour minute second
#time类型可以的date类型 或者是datetime类型  timestamp类型
#查询10分钟内发布的信息
SELECT * FROM news WHERE DATE_ADD(times,INTERVAL 10 MINUTE) >= NOW()
SELECT * FROM news WHERE DATE_SUB(NOW(),INTERVAL 10 MINUTE) <= times


#3. datediff(date1,date2) date1 和 date2 所差的天数
#   timediff(time1,time2) time1 和 time2 所差的时分秒数
#   time类型可以的date类型 或者是datetime类型  timestamp类型
#   求出2011-11-11 和 19909-1-1 相减的天数
SELECT DATEDIFF('2011-11-11','1990-1-1') FROM DUAL
SELECT DATEDIFF('10:11:11','10:11:10') FROM DUAL


#用sql语句求出你活了多少天
SELECT DATEDIFF(CURRENT_DATE(),'2003-9-23') FROM DUAL
#如果你能活80岁 还能活多少天
SELECT DATEDIFF(DATE_ADD('2003-9-23',INTERVAL 80 YEAR),CURRENT_DATE()) FROM DUAL

#4. unix_timestamp() 返回距离1970-1-1 到现在的秒数
SELECT UNIX_TIMESTAMP() FROM DUAL 
#5. from_unixtime() 可以把一个unixtime秒数 转换成指定格式的日期
#   意义为可以将时间同一按成秒数存储 采用此方法来获取具体日期
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(),'%Y-%m-%d-%H-%i-%s') FROM DUAL

#用户密码函数
#1. user() 查询用户 可以查看登录mysql有哪些用户 以及登录的ip  用户名@ip地址
SELECT USER() FROM DUAL
#2. database() 查询当前使用数据库的名称
SELECT DATABASE() FROM DUAL
#3. md5(str) 为字符串算出一个md5 32 的字符串 常用(用户密码)加密
#生成的密码为char(32)的字符串
SELECT MD5('xing123456') FROM DUAL
CREATE TABLE user05 (NAME VARCHAR(32),passwd CHAR(32));
INSERT INTO user05 VALUES('ll',MD5('xing123456'));
SELECT * FROM user05 WHERE passwd = MD5('xing123456');
#4. password(str) 加密函数 mysql数据库的密码就是用该函数加密
#库名 + 表名 可以不更改所在数据库位置 直接查询数据库对应的表
SELECT * FROM mysql.user 
SELECT PASSWORD('xing123456') FROM DUAL


#流程控制函数

#1. if(expr1,expr2,expr2) 三元运算符
SELECT IF(TRUE,'背景','上海') FROM DUAL
#2. ifnull(expr1,expr2) 如果expr1为空返回expr2 否则返回expr1
SELECT IFNULL(NULL,'hh') FROM DUAL
#3. (select case when expr1 then expr2 when expr3 then expr4 else expr5 end)  
#多分支语句 if(expr1) expr2 else if(expr3) expr4 else expr5

#查询emp表 如果comm为空 (判断为为空使用is 不为空 isnot 其他判断相等用 = 不等使用!= 没有==符号的使用) 则显示0.0
SELECT ename, IF(comm IS NULL,0.0,comm) AS comm FROM emp 
SELECT ename, IFNULL(comm,0.0) AS comm FROM emp
#查询表 如果job 是clerk 显示职员 如果是manager 显示经理 如果salesman 显示销售人员
SELECT ename, job,(SELECT CASE 
		WHEN job = 'CLERK' THEN '职员' 
		WHEN job = 'MANAGER' THEN '经理' 
		WHEN job = 'SALESMAN' THEN '销售人员' 
		ELSE job END) AS job FROM emp;
		
		
# 查询加强
# 如何查找 1992.1.1 后入职的员工
SELECT * FROM emp WHERE hiredate > '1992-01-01';
#如何使用 like 操作符(模糊)
#%: 表示 0 到多个任意字符 _: 表示单个任意字符
#  显示首字符为 S 的员工姓名和工资
SELECT ename, sal FROM emp WHERE ename LIKE 'S%';
#  显示第三个字符为大写 O 的所有员工的姓名和工资
SELECT ename, sal FROM emp WHERE ename LIKE '__O%';
#  如何显示没有上级的雇员的情况
SELECT ename, sal FROM emp WHERE mgr IS NULL;
#查询表结构
DESC emp

#使用 order by 子句
#按照工资的从低到高的顺序[升序]，显示雇员的信息
SELECT * FROM emp ORDER BY sal ASC
#按照部门号升序而雇员的工资降序排列 , 显示雇员信息
SELECT * FROM emp ORDER BY deptno ASC , sal DESC;


-- 分页查询
-- 按雇员的 id 号升序取出， 每页显示 3 条记录，请分别显示 第 1 页，第 2 页，第 3 页
-- 第 1 页
SELECT * FROM emp
ORDER BY empno
LIMIT 0, 3;
-- 第 2 页
SELECT * FROM emp
ORDER BY empno
LIMIT 3, 3;
-- 第 3 页
SELECT * FROM emp
ORDER BY empno
LIMIT 6, 3;
-- 推导一个公式
SELECT * FROM emp
ORDER BY empno
LIMIT 每页显示记录数 * (第几页-1) , 每页显示记录数

#按雇员的empno号降序取出 每页有5条记录  显示第3页 第5页
SELECT * FROM emp ORDER BY empno DESC LIMIT 10,5;
SELECT * FROM emp ORDER BY empno DEC LIMIT 20,5;



#增强 group by 的使用
-- (1) 显示每种岗位的雇员总数、平均工资。
SELECT COUNT(*), AVG(sal), job FROM emp GROUP BY job;
-- (2) 显示雇员总数，以及获得补助的雇员数。

-- 思路: 获得补助的雇员数 就是 comm 列为非 null, 就是 count(列)，如果该列的值为 null, 是
-- 不会统计 , SQL 非常灵活，需要我们动脑筋.
SELECT COUNT(*), COUNT(comm) FROM emp
-- 老师的扩展要求：统计没有获得补助的雇员数
SELECT COUNT(*), COUNT(IF(comm IS NULL, 1, NULL))
FROM emp
SELECT COUNT(*), COUNT(*) - COUNT(comm)
FROM emp
-- (3) 显示管理者的总人数。小技巧:尝试写->修改->尝试[正确的]
SELECT COUNT(DISTINCT mgr)
FROM emp;
-- (4) 显示雇员工资的最大差额。
-- 思路： max(sal) - min(sal)
SELECT MAX(sal) - MIN(sal)
FROM emp;
SELECT * FROM emp;
SELECT * FROM dept;
-- 应用案例：请统计各个部门 group by 的平均工资 avg，
-- 并且是大于 1000 的 having，并且按照平均工资从高到低排序， order by
-- 取出前两行记录 limit 0, 2
SELECT AVG(sal) AS sal,deptno FROM emp GROUP BY deptno HAVING sal>1000 ORDER BY sal ASC
LIMIT 0,2;


-- 多表查询
-- ?显示雇员名,雇员工资及所在部门的名字 【笛卡尔集】
/*
老韩分析
1. 雇员名,雇员工资 来自 emp 表
2. 部门的名字 来自 dept 表
3. 需求对 emp 和 dept 查询 ename,sal,dname,deptno
4. 当我们需要指定显示某个表的列是，需要 表.列表
*/
SELECT ename,sal,dname,emp.deptno FROM emp, dept WHERE emp.deptno = dept.deptno
SELECT * FROM emp,dept;
SELECT * FROM salgrade,emp;
-- 小技巧：多表查询的条件不能少于 表的个数-1, 否则会出现笛卡尔集
#如何显示部门号为 10 的部门名、员工名和工资
SELECT dname,ename,sal FROM emp,dept WHERE emp.deptno = dept.deptno AND dept.deptno = 10
#显示各个员工的姓名，工资，及其工资的级别
SELECT ename,sal,grade FROM emp,salgrade WHERE sal BETWEEN losal AND hisal
#显示雇员名 雇员工资 也所在部门的名字 并按部门排序
SELECT ename,sal,dname FROM emp,dept WHERE emp.deptno = dept.deptno ORDER BY dname DESC

#自连接
#显示公司员工名字和他的上级的名字
SELECT worker.ename,boss.ename FROM emp worker,emp boss WHERE worker.mgr = boss.empno

#子查询
#显示与 SMITH 同一部门的所有员工
SELECT * FROM emp WHERE deptno = (SELECT deptno FROM emp WHERE ename='SMITH')

#显示部门编号为10的员工的工作相同的员工信息 但不含10 号部门自己的
SELECT * FROM emp WHERE job IN(SELECT DISTINCT job FROM emp WHERE deptno = 10) AND deptno != 10

SELECT * FROM ecs_goods;

SELECT * FROM (SELECT * FROM ecs_goods) tab
#查询各个类别中价格最高的商品
#1. 查最高价和种类
#2. 根据自连接得出结果
#显示商品类比中最高价的临时表1
SELECT cat_id,MAX(shop_price) AS max_price FROM ecs_goods GROUP BY cat_id
#根据临时表查询
SELECT goods_name,shop_price FROM (SELECT cat_id,MAX(shop_price) AS max_price FROM ecs_goods GROUP BY cat_id) max_price_table,ecs_goods
	WHERE max_price_table.cat_id = ecs_goods.cat_id AND 
	max_price_table.max_price = ecs_goods.shop_price; 

SELECT * FROM emp
#all的使用
#显示工资比部门 30 的其中所有员工的工资高的员工的姓名、工资和部门号
SELECT ename,sal,deptno FROM emp WHERE sal > 
		ALL(SELECT sal FROM emp WHERE deptno = 30 )
SELECT ename,sal,deptno FROM emp WHERE sal > 
		(SELECT MAX(sal) FROM emp WHERE deptno = 30 )

#any的使用
#显示工资比部门 30 的其中一个的工资高的员工的姓名、工资和部门号
SELECT ename,sal,deptno FROM emp WHERE sal > 
		ANY(SELECT sal FROM emp WHERE deptno = 30 )
SELECT ename,sal,deptno FROM emp WHERE sal > 
		(SELECT MIN(sal) FROM emp WHERE deptno = 30 )
		
#查询与 allen 的部门和岗位完全相同的所有雇员(并且不含 allen 本人)
SELECT * FROM emp WHERE 
	(deptno,job) = (SELECT deptno,job FROM emp WHERE ename = 'ALLEN') 
	AND ename !='ALLEN';
SELECT * FROM student WHERE (math,english,chinese) =
	(SELECT math,english,chinese FROM student WHERE NAME = '宋江')
	AND NAME != '宋江';
	
SELECT * FROM emp
SELECT * FROM dept
#查找每个部门工资高于本部门平均工资的人的资料
SELECT AVG(sal) AS avg_sal,deptno FROM emp GROUP BY deptno
SELECT empno,job,mgr,hiredate,sal,comm,emp.deptno FROM emp, (SELECT AVG(sal) AS avg_sal,deptno FROM emp GROUP BY deptno) avg_emp
		WHERE sal>avg_sal AND avg_emp.deptno = emp.deptno;
		
#查找每个部门工资最高的人的向详细信息
SELECT deptno , MAX(sal) AS max_sal FROM emp GROUP BY deptno
SELECT empno,job,mgr,hiredate,sal,comm,emp.deptno FROM emp,(SELECT deptno , MAX(sal) AS max_sal FROM emp GROUP BY deptno) max_emp
		WHERE max_emp.deptno = emp.deptno AND max_sal = sal;
		
SELECT deptno,COUNT(*) AS numb FROM emp GROUP BY deptno
SELECT dname,loc,dept.deptno,numb FROM dept,(SELECT deptno,COUNT(*) AS numb FROM emp GROUP BY deptno) num_table
	WHERE dept.deptno = num_table.deptno;
	
DESC emp
DROP TABLE tab01
#表的自我复制(蠕虫复制)
CREATE TABLE tab01 (NAME VARCHAR(32), job VARCHAR(32),sal DOUBLE,deptno INT)
#这里是将emp表中的每一条字段插入tab01表中  省去了values() 
#这里select字句看做是多行的是单行多列子查询
INSERT INTO tab01 SELECT ename,job,sal,deptno FROM emp
INSERT INTO tab01 SELECT * FROM tab01
SELECT * FROM tab01	


#表的去重
#使用like可以创建一个和指定表结构相同的表
CREATE TABLE temp_tab LIKE tab01;
INSERT INTO temp_tab SELECT DISTINCT * FROM tab01;
DELETE FROM tab01;
INSERT INTO tab01 SELECT * FROM temp_tab;
DROP TABLE temp_tab;
SELECT * FROM tab01

#表的联合
SELECT ename,sal,job FROM emp WHERE sal>2500 -- 5
SELECT ename,sal,job FROM emp WHERE job='MANAGER' -- 3
-- union all 就是将两个查询结果合并，不会去重
SELECT ename,sal,job FROM emp WHERE sal>2500 -- 5
UNION ALL
SELECT ename,sal,job FROM emp WHERE job='MANAGER' -- 3
-- union 就是将两个查询结果合并，会去重
SELECT ename,sal,job FROM emp WHERE sal>2500 -- 5
UNION
SELECT ename,sal,job FROM emp WHERE job='MANAGER' -- 3


#
-- 创建 stu
/*
id name
1 Jack
2 Tom
3 Kity
4 nono
*/
CREATE TABLE stu (id INT,`name` VARCHAR(32));
INSERT INTO stu VALUES(1, 'jack'),(2,'tom'),(3, 'kity'),(4, 'nono');
SELECT * FROM stu;
-- 创建 exam
/*
id grade
1 56
2 76
11 8
*/
CREATE TABLE exam(
id INT,
grade INT);
INSERT INTO exam VALUES(1, 56),(2,76),(11, 8);
SELECT * FROM exam;

#左外连接
SELECT NAME,stu.id, grade FROM stu LEFT JOIN exam ON stu.id = exam.id;
#右外连接
SELECT NAME,exam.id, grade FROM stu RIGHT JOIN exam ON stu.id = exam.id;

#列出部门名称和这些部门的员工信息(名字和工作)，
#同时列出那些没有员工的部门名
SELECT * FROM dept
SELECT * FROM emp
#左连接
SELECT ename, job,sal,dept.deptno,dname,loc FROM dept LEFT JOIN emp ON emp.deptno = dept.deptno
#右连接
SELECT ename, job,sal,dept.deptno,dname,loc FROM emp RIGHT JOIN dept ON emp.deptno = dept.deptno


#mysql 约束
#主键使用
CREATE TABLE t17(id INT PRIMARY KEY,`name` VARCHAR(32), email VARCHAR(32));
-- 主键列的值是不可以重复
INSERT INTO t17 VALUES(1, 'jack', 'jack@sohu.com');
INSERT INTO t17 VALUES(2, 'tom', 'tom@sohu.com');
#主键使用的细节讨论
#1. primary key 不能重复而且不能为 null。
INSERT INTO t17 VALUES(NULL, 'hsp', 'hsp@sohu.com');
#2. 一张表最多只能有一个主键, 但可以是复合主键(比如 id+name 不允许两个值同时相同 并且定义主键式采用第二种方式) 
CREATE TABLE t18 (id INT ,`name` VARCHAR(32), email VARCHAR(32),PRIMARY KEY(id,NAME));
#3. 主键的指定方式 有两种
-- 1. 直接在字段名后指定：字段名 primakry key
-- 2. 在表定义最后写 primary key(列名);
CREATE TABLE t19 (id INT ,`name` VARCHAR(32) PRIMARY KEY, email VARCHAR(32));
CREATE TABLE t20 (id INT ,`name` VARCHAR(32) ,email VARCHAR(32),PRIMARY KEY(`name`)); # 在表定义最后写 primary key(列名)

#4. 使用 desc 表名，可以看到 primary key 的情况
#5. 实际开发时 每个表中往往都会设计一个主键


#-- unique 的使用
#unqiue 使用细节
#1. 如果没有指定 not null , 则 unique 字段可以有多个 null
#   如果一个列(字段)， 是 unique not null 使用效果类似 primary key
INSERT INTO t21 VALUES(NULL, 'tom', 'tom@sohu.com');
SELECT * FROM t21;
#2. 一张表可以有多个 unique 字段
CREATE TABLE t22 (id INT UNIQUE , `name` VARCHAR(32) UNIQUE , email VARCHAR(32));
DESC t2

#外键约束
#创建主表
CREATE TABLE tab_class (class_id INT PRIMARY KEY,class_type VARCHAR(32),loc VARCHAR(32))
#创建从表
CREATE TABLE tab_stu (id INT, NAME VARCHAR(32),stu_id INT ,FOREIGN KEY (stu_id) REFERENCES tab_class(class_id)) 
INSERT INTO tab_class VALUES(100,'java','北京')
INSERT INTO tab_class VALUES(200,'php','天津')
INSERT INTO tab_stu VALUES(1,'王五',100)
# 300因外键约束无法添加
INSERT INTO tab_stu VALUES(2,'李四',300)
#外键约束细节
#1. 外键指向的的主表的字段必须是primary key 或者是 unique 保证指向唯一
#2. 外键字段的类型要和主表中联系的字段类型相同(长度可以不同)
#3. 实现外键约束的表的存储引擎必须是innodb
#4. 一旦从表外键和主表建立联系 主表中建立联系的行不能删除 除非将从表中与该行有联系的行全部删除
#5. 从表添加数据的外键字段必须在主表中的联系字段存在 不然无法添加
#6. 从表中添加数据的外键字段可以为null 前提是该字段允许为空


#check
CREATE TABLE t23 (id INT PRIMARY KEY,`name` VARCHAR(32) ,
sex VARCHAR(6) CHECK (sex IN('man','woman')),
sal DOUBLE CHECK ( sal > 1000 AND sal < 2000));
-- 添加数据 不生效
INSERT INTO t23 VALUES(1, 'jack', 'mid', 1);
SELECT * FROM t23;

#商店售货系统表练习
CREATE DATABASE shop_db CHARACTER SET utf8 COLLATE utf8_bin;
USE shop_db
DROP TABLE goods
CREATE TABLE goods (good_id INT PRIMARY KEY , good_name VARCHAR(128), unitprice DOUBLE CHECK (unitprice BETWEEN 1.0 AND 9999.99),
	category VARCHAR(64),provider VARCHAR(64));
CREATE TABLE customer (customer_id INT PRIMARY KEY,`name` VARCHAR(32) NOT NULL,address VARCHAR(64),email VARCHAR(64) UNIQUE ,sex
	VARCHAR(4) CHECK (sex IN('男','女')),card_id INT);
CREATE TABLE purchase (order_id INT PRIMARY KEY, customer_id INT ,FOREIGN KEY(customer_id) REFERENCES customer(customer_id),good_id INT,
	FOREIGN KEY(good_id) REFERENCES goods(good_id),nums INT);
	
	
	
#自增长
CREATE TABLE user06 (id INT PRIMARY KEY AUTO_INCREMENT,NAME VARCHAR(32))
INSERT INTO user06 VALUES(NULL,'wang');
INSERT INTO user06 (NAME) VALUES('ying');
ALTER TABLE user06 AUTO_INCREMENT = 9;
SELECT * FROM user06

#创建索引
CREATE TABLE t1 (id INT UNIQUE ,NAME VARCHAR(32))
#主键索引 可以直接在字段后加上primary key 也可以用以下方式创建
ALTER TABLE t1 ADD PRIMARY KEY (id)
#唯一索引 唯一索引可以直接在字段后加上 unique 也可以用以下方式创建
CREATE UNIQUE INDEX unique_index ON t1 (id)
#普通索引 使用主键索引和唯一索引 字段应都是唯一性
CREATE INDEX id_index ON t1 (id)
ALTER TABLE t1 ADD INDEX (id)
#索引的选取 如果某列的值，是不会重复的
#则优先考虑使用 unique(primary key)索引, 否则使用普通索引
#显示表的索引信息
SHOW INDEX FROM t1

#索引的删除
#删除索引方式(任何索引应该都能删除)
DROP INDEX `primary` ON t1
#删除主键索引
ALTER TABLE t1 DROP PRIMARY KEY

#索引的修改
#ps 删除 + 添加 = 修改

#索引的查询
SHOW INDEX FROM t1
SHOW INDEXES FROM t1
SHOW KEYS FROM t1
DESC t1

#练习 建立主键索引
CREATE TABLE order1 (id INT PRIMARY KEY, goods_name VARCHAR(64),
	goods_num INT);
CREATE TABLE order2 (id INT ,goods_name VARCHAR(64),
	goods_num INT);
ALTER TABLE order2 ADD PRIMARY KEY (id)
#练习 创建唯一索引
CREATE TABLE menu1 (id INT PRIMARY KEY,menu_name VARCHAR(32),cooker VARCHAR(32),
	costomer_id INT UNIQUE,price DOUBLE);
CREATE TABLE menu2 (id INT PRIMARY KEY,menu_name VARCHAR(32),cooker VARCHAR(32),
	costomer_id INT,price DOUBLE);
CREATE UNIQUE INDEX costomer_id_index ON menu2 (costomer_id);
#练习 建立普通索引
CREATE TABLE sportman1 (id INT PRIMARY KEY, `name` VARCHAR(32), hobity VARCHAR(32));
ALTER TABLE sportman1 ADD INDEX (`name`);
CREATE INDEX name_index ON sportman1 (`name`);
SHOW INDEX FROM sportman1

#事物基本使用 依次执行
CREATE TABLE t1 (id INT)
START TRANSACTION #开启事物
SAVEPOINT a1 #记录点 可以返回
INSERT INTO t1 VALUES(1); #添加一条数据
ROLLBACK TO a1 #回到记录点 添加的数据操作清除
COMMIT #提交事物 表示事物完成

#查看当前会话级别
SELECT @@tx_isolation;
#查看系统当前隔离级别
SELECT @@global.tx_isolation;
#设置当前会话隔离级别
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
#设置系统当前隔离级别
SET GLOBAL TRANSACTION ISOLATION  LEVEL REPEATABLE READ;
#mysql 默认隔离级别是repeatable read 一般情况下 没有特殊要求 不必要修改
#可用以下方式修改默认隔离级别 修改my.ini 配置文件
TRANSACTION-ISOLATION = 隔离-级别 如 REPEATABLE-READ

COMMIT

#
#表类型和存储引擎
#查看所有的存储引擎
SHOW ENGINES
#1. innodb 存储引擎
#  1. 支持事务 2. 支持外键 3. 支持行级锁
#2. myisam 存储引擎
#  1. 添加速度快 2. 不支持外键和事务 3. 支持表级锁
#3. memory 存储引擎
#  1. 数据存储在内存中[关闭了 Mysql 服务，数据丢失, 但是表结构还在] 2. 执行速度很快(没有 IO 读写) 3. 默认支持索引(hash 表)
#  指令修改存储引擎
ALTER TABLE `t29` ENGINE = INNODB



# 视图的使用
#1. 创建视图
CREATE VIEW emp_view01 AS SELECT empno, ename, job, deptno FROM emp;
#2. 查看视图
DESC emp_view01
SELECT * FROM emp_view01;
SELECT empno, job FROM emp_view01;
#   查看创建的视图
SHOW CREATE VIEW emp_view01
#3. 删除视图
DROP VIEW emp_view01;
#4. 修改视图
UPDATE emp_view01 SET job = 'MANAGER' WHERE empno = 7369
-- 视图的细节
#1. 创建视图后，到数据库去看，对应视图只有一个视图结构文件(形式: 视图名.frm)
#2. 视图的数据变化会影响到基表，基表的数据变化也会影响到视图[insert update delete ]
#3. 修改视图 会影响到基表
#4. 视图中可以再使用视图 , 比如从 emp_view01 视图中，选出 empno,和 ename 做出新视图
DESC emp_view01
CREATE VIEW emp_view02 AS SELECT empno, ename FROM emp_view01
SELECT * FROM emp_view02

#视图的练习 映射到多个基表
SELECT* FROM emp  empno ename deptno   IDENTIFIED
SELECT* FROM dept deptno dname
SELECT * FROM salgrade  grade losal hisal
CREATE VIEW view01 AS SELECT emp.deptno,ename,dname,grade FROM emp,dept,salgrade WHERE
	emp.deptno = dept.deptno AND emp.sal BETWEEN losal AND hisal;
SELECT * FROM view01


#创建用户 (root 用户操作)
CREATE USER 'xing'@'localhost' IDENTIFIED BY '123456';
SELECT * FROM mysql.user
#删除用户 (root 用户操作)
DROP USER 'xing'@'localhost';
#修改自己密码
SET PASSWORD = PASSWORD('xing123456');
#修改别人密码 (需要权限)
SET PASSWORD FOR 'xing'@'localhost' = PASSWORD('123456');
#
#用户权限的管理
#1. 创建用户
CREATE USER 'xing'@'localhost' IDENTIFIED BY '123456';
#使用 root 用户创建 testdb ,表 news
CREATE DATABASE testdb 
CREATE TABLE news (id INT ,content VARCHAR(32));
-- 添加一条测试数据
INSERT INTO news VALUES(100, '北京新闻');
SELECT * FROM news;
#2. 授予权限 
GRANT SELECT,INSERT,DELETE ON news TO 'xing'@'localhost';
# 授予权限同时修改密码
GRANT UPDATE ON news TO 'xing'@'localhost' IDENTIFIED BY '123456'
# 当用户未存在时 结尾用identified by 密码 可以创建用户的同时赋予权限
#3. 回收权限
REVOKE SELECT,UPDATE,INSERT,DELETE ON testdb.news FROM 'xing'@'localhost'
REVOKE ALL ON testdb.news FROM 'xing'@'localhost'
-- 删除用户
DROP USER 'xing'@'localhost'


#用户管理细节
#1. 在创建用户的时候，如果不指定 Host, 则为% , %表示表示所有 IP 都有连接权限
-- create user xxx;
CREATE USER jack
SELECT `host`, `user` FROM mysql.user
#2. 也可以这样指定
-- create user 'xxx'@'192.168.1.%' 表示 xxx 用户在 192.168.1.*的 ip 可以登录 mysql
CREATE USER 'smith'@'192.168.1.%'
#3. 在删除用户的时候，如果 host 不是 %, 需要明确指定 '用户'@'host 值'
DROP USER jack -- 默认就是 DROP USER 'jack'@'%'
DROP USER 'smith'@'192.168.1.%'


SELECT * FROM emp;
SELECT * FROM dept;
#练习
DESC emp
DESC dept

SELECT dname FROM dept;
SELECT ename, sal*12 + IFNULL(comm,0) "年收入" FROM emp;

SELECT ename,sal FROM emp WHERE sal>2850;
SELECT ename,sal FROM emp WHERE sal BETWEEN 1500 AND 2850;
SELECT ename,deptno FROM emp WHERE empno = 7566;
SELECT ename,sal FROM emp WHERE deptno IN(10,30) AND sal>1500;
SELECT ename,job FROM emp WHERE mgr IS NULL;

SELECT ename,job,hiredate FROM emp WHERE hiredate BETWEEN 
	'1991-02-01' AND '1991-05-01' ORDER BY hiredate ASC;
SELECT ename,sal,comm FROM emp WHERE comm IS NOT NULL ORDER BY sal DESC;

SELECT * FROM emp;
#作业
SELECT * FROM emp WHERE deptno = 30;
SELECT ename,empno,deptno FROM emp WHERE job = 'CLERK';
SELECT * FROM emp WHERE IFNULL(comm,0) > sal;
SELECT * FROM emp WHERE IFNULL(comm,0) > sal * 0.3;
SELECT * FROM emp WHERE (deptno = 10 AND job = 'MANAGER') OR
	(deptno = 20 AND job ='CLERK');
SELECT * FROM emp WHERE (deptno = 10 AND job = 'MANAGER') OR
	(deptno = 20 AND job ='CLERK') OR 
	(job NOT IN('MANAGER','CLERK') AND sal >=2000);
SELECT DISTINCT job FROM emp WHERE comm IS NOT NULL;
SELECT * FROM emp WHERE comm IS NULL OR (comm IS NOT NULL AND comm<400);
SELECT * FROM emp WHERE DAY(DATE_ADD(hiredate,INTERVAL 3 DAY)) = 1;
SELECT * FROM emp WHERE YEAR(hiredate) <2012;
SELECT CONCAT(LCASE(LEFT(ename,1)),SUBSTRING(ename,1)) NAME FROM emp;
SELECT ename FROM emp WHERE LENGTH(ename)= 5; 


SELECT ename FROM emp WHERE INSTR(ename,'R') = 0;
SELECT LEFT(ename,3) FROM emp;
SELECT REPLACE(ename,'A','a') FROM emp;
SELECT ename,hiredate FROM emp WHERE DATE_ADD(hiredate,INTERVAL 10 YEAR) < CURRENT_DATE();
SELECT * FROM emp ORDER BY ename ASC;
SELECT ename,hiredate FROM emp ORDER BY hiredate ASC;
SELECT ename,job,sal FROM emp ORDER BY job,sal ASC;
SELECT ename,YEAR(hiredate) `year`,MONTH(hiredate) `month` FROM emp 
	ORDER BY `month`,`year` ASC;
SELECT ename,FORMAT(sal/30,0) AS day_sal FROM emp;
SELECT * FROM emp WHERE MONTH(hiredate) = 2;
SELECT ename, DATEDIFF(NOW(),hiredate) AS join_day FROM emp;
SELECT ename FROM emp WHERE INSTR(ename,'A') <> 0;
SELECT ename,DATE_SUB(DATE_SUB(DATE_SUB(NOW(),INTERVAL YEAR(hiredate) YEAR),INTERVAL MONTH(hiredate) MONTH),INTERVAL DAY(hiredate) DAY) AS join_date FROM emp;

SELECT* FROM emp
SELECT* FROM dept
#练习
SELECT COUNT(*) AS c,deptno FROM emp GROUP BY deptno HAVING c>1;
SELECT DISTINCT dname FROM emp,dept WHERE emp.deptno = dept.deptno;
SELECT ename FROM emp WHERE sal > (SELECT sal FROM emp WHERE ename = 'SMITH');
SELECT emp1.ename FROM emp emp1,emp emp2 WHERE emp1.mgr = emp2.empno AND
	emp1.hiredate > emp2.hiredate;
SELECT * FROM dept LEFT JOIN emp ON emp.deptno = dept.deptno;
SELECT ename,dname FROM emp,dept WHERE job='CLERK' AND emp.deptno = dept.deptno;
SELECT job FROM emp WHERE sal > 1500;
SELECT MIN(sal) AS min_sal, job FROM emp GROUP BY job HAVING min_sal<1500 
SELECT ename FROM emp,dept WHERE dname='SALES' AND emp.deptno = dept.deptno;
SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp);


#练习
SELECT ename FROM emp WHERE job= (SELECT job FROM emp WHERE ename ='SCOTT');
SELECT ename,sal FROM emp WHERE sal >  (SELECT MAX(sal) FROM emp WHERE deptno = 30);
SELECT COUNT(*),AVG(sal),AVG(DATEDIFF(NOW(),hiredate)) FROM emp GROUP BY deptno;
SELECT ename,dname,sal FROM emp,dept WHERE emp.deptno = dept.deptno;
SELECT co,dept.* FROM dept,(SELECT COUNT(*) AS co,deptno FROM emp GROUP BY deptno) emp_co 
	WHERE dept.deptno = emp_co.deptno;
SELECT COUNT(*) AS co,deptno FROM emp GROUP BY deptno;
SELECT MIN(sal),job FROM emp GROUP BY job;
SELECT MIN(sal) FROM emp WHERE job = 'MANAGER';
SELECT (sal+IFNULL(comm,0))* 12 AS ann_sal FROM emp ORDER BY ann_sal ASC;


#大作业练习
CREATE DATABASE school_db CHARACTER SET utf8 COLLATE utf8_bin;
CREATE TABLE class (classid INT PRIMARY KEY,`subject` VARCHAR(32),deptname VARCHAR(32),FOREIGN KEY(deptname) REFERENCES department(deptname),
	enrolltime DATE,num INT);
CREATE TABLE student (studentid INT PRIMARY KEY,`name` VARCHAR(32) NOT NULL DEFAULT '',age INT,classid INT,FOREIGN KEY(classid) REFERENCES class(classid));
CREATE TABLE department (departmentid INT PRIMARY KEY,deptname VARCHAR(32) UNIQUE);
INSERT INTO department VALUES(001,'数学'),(002,'计算机'),(003,'化学'),(004,'中文'),(005,'经济');
ALTER TABLE class CHANGE enrolltime enrolltime YEAR; 

INSERT INTO class VALUES(101,'软件','计算机',1995,20);
INSERT INTO class VALUES(102,'微电子','计算机',1996,30);
INSERT INTO class VALUES(111,'无机化学','化学',1995,29);
INSERT INTO class VALUES(112,'高分子化学','化学',1996,25);
INSERT INTO class VALUES(121,'统计数学','数学',1995,20);
INSERT INTO class VALUES(131,'现代语言','中文',1996,20);
INSERT INTO class VALUES(141,'国际贸易','经济',1997,30);
INSERT INTO class VALUES(142,'国际金融','经济',1996,14);
INSERT INTO student VALUES(8101,'张三',18,101);
INSERT INTO student VALUES(8102,'钱四',16,121);
INSERT INTO student VALUES(8103,'王玲',17,131);
INSERT INTO student VALUES(8105,'李飞',19,102);
INSERT INTO student VALUES(8109,'赵四',18,141);
INSERT INTO student VALUES(8110,'李可',20,142);
INSERT INTO student VALUES(8201,'张飞',18,111);
INSERT INTO student VALUES(8302,'周瑜',16,112);
INSERT INTO student VALUES(8203,'王亮',17,111);
INSERT INTO student VALUES(8305,'董庆',19,102);
INSERT INTO student VALUES(8409,'赵龙',18,101);
INSERT INTO student VALUES(8510,'李丽',20,142);

SELECT* FROM department;
SELECT* FROM class;
SELECT* FROM student;

SELECT* FROM student WHERE `name` LIKE '李%';
SELECT COUNT(*) AS `count`,deptname FROM class GROUP BY deptname HAVING `count`>1;
SELECT COUNT(*),deptname FROM (SELECT deptname,student.classid FROM student,class WHERE student.classid = class.classid) tab1
	GROUP BY deptname;
	
SELECT departmentid,department.deptname FROM department,(SELECT COUNT(*) AS cnt,deptname FROM (SELECT deptname,student.classid FROM student,class WHERE student.classid = class.classid) tab1
	GROUP BY deptname) tab2 WHERE tab2.deptname = department.deptname AND cnt>3;

INSERT INTO department VALUES(006,'物理系');

DELETE FROM student WHERE `name` = '张三';