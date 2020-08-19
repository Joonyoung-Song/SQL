create table emp(
empno number(4) primary key,
ename varchar2(20));



/*@@@@@@@@@@@@@@@@@insert��@@@@@@@@@@@@@@@@@*/

/*insert��*/
insert into emp(empno,ename) values(10,'�Ӻ���Ʈ')

/*��� Į���� ���� ������ ���Խ� Į���� ���� ����*/
insert into emp values(11,'�Ӻ���Ʈ');

/*select������ �Է�*/
/*�������̺� ����*/
create table emp_test(
empno number(4),
ename varchar2(20));
/*select������ �Է�*/
insert into emp_test select * from emp;

/*nologging ���*/
/*nologging �ɼ��� �α������� ����� �ּ�ȭ���� �Է½� ������ ����Ű�� ���*/
alter table emp nologging;



/*@@@@@@@@@@@@@@@@@update��@@@@@@@@@@@@@@@@@*/
/*������ �� ����*/
update emp
set ename='����'
where empno='10';



/*@@@@@@@@@@@@@@@@@delete��@@@@@@@@@@@@@@@@@*/
/*���ϴ� ���� �˻��ؼ� �ش�Ǵ� �� ����*/
/*���� where ���� �Է����� �ʴ� �ٸ� ���̺��� ��� ������ ����(���̺� �뷮 ����x)*/
delete from emp
where empno='10';
/*truncate table */
/*���̺��� ��� ������ ����(���̺� �뷮 �ʱ�ȭ)*/
truncate table emp;


/*@@@@@@@@@@@@@@@@@select��@@@@@@@@@@@@@@@@@*/

insert into emp values(10,'���ؿ�');
insert into emp values(11,'��ä��');
select *
from emp;

/*�ڿ� ���� �ٿ��� ���*/
select ename||'��' from emp;

/*order by�� ����� ������������*/
select * from emp order by empno;
/*order by�� ����� ������������*/
select * from emp order by empno desc;

/*index�� ����� ���� ȸ��*/
drop table emp;
create table emp(
empno number(10) primary key,
ename varchar2(20),
sal number(10)
);
insert into emp values(1000,'��μ�',20000);
insert into emp values(1001,'�ڿ���',20000);
insert into emp values(1002,'�ּ���',20000);

select  /*+ INDEX_DESC(A)*/*
from emp A;

/*DISTINCT*/
select distinct sal /*�ߺ�����*/
from emp;



/*@@@@@@@@@@@@@@@@@where��@@@@@@@@@@@@@@@@@*/

/*LIKE*/
/*%�� ������� ������ =�� ����*/
select * from emp
where ename like '��%';

/*between*/
select * from emp
where sal between 10000 and 21000; /*10000�̻� 21000����*/
/*not between*/
select * from emp
where sal not between 10000 and 21000 /*10000�̸� 21000�ʰ�*/

/*in*/
select * from emp
where ename in ('��μ�','�ּ���' )

/*null*/
/*null�� �𸣴� ���� �ǹ�*/
/*null�� ���� ���縦 �ǹ�*/
/*null�� ���� Ȥ�� ��¥�� ���ϸ� null�� ��*/
/*null�� � ���� ���� ��, '�˼�����'�� ��ȯ*/
/*null�� ��ȸ*/
select * from emp
where mgr is null;
insert into emp values(1004,'���ؿ�','30000','��������');
/*nvl(mgr,0) : mgrĮ���� null�̸� 0���� �ٲ�*/
select mgr,nvl(mgr,0) from emp;
/*nvl2(mgr,1,0) : mgrĮ���� null�� �ƴϸ� 1, null�̸� 0���� ��ȯ*/
select mgr,nvl2(mgr,1,0) from emp;
/*nullif(exp1,exp2) : exp1�� exp2�� ������ null��, ���������� exp1�� ��ȯ*/
select mgr,nullif(empno,sal) from emp;
/*coalesce(exp1,exp2,exp3,...) : exp1�� null�� �ƴϸ� exp1�� ����, null�̸� exp2�� ���� ��ȯ*/
select mgr,coalesce(mgr,'0') from emp;



/*���̺� ����*/
drop table dept;
drop table emp;
CREATE TABLE DEPT
       (DEPTNO number(10),
        DNAME VARCHAR2(14),
        LOC VARCHAR2(13) );



INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');


CREATE TABLE EMP (
 EMPNO               NUMBER(4) NOT NULL,
 ENAME               VARCHAR2(10),
 JOB                 VARCHAR2(9),
 MGR                 NUMBER(4) ,
 HIREDATE            DATE,
 SAL                 NUMBER(7,2),
 COMM                NUMBER(7,2),
 DEPTNO              NUMBER(2) );



INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'81-11-17',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'81-05-01',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'81-05-09',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'81-04-01',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'81-09-10',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'81-02-11',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'81-08-21',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'81-12-11',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'81-02-23',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'81-12-11',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'80-12-09',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'82-12-22',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'83-01-15',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'82-01-11',1300,NULL,10);


/*@@@@@@@@@@@@@@@@@group by��@@@@@@@@@@@@@@@@@*/
/*group by �⺻*/
select mgr,sum(sal)
from emp
group by mgr;

/*having*/
select deptno, avg(sal)
from emp
group by deptno
having sum(sal)>10000;

/*count�Լ�*/
/*count(*)�� null���� ������ ��� ����� ���*/
/*count(Į����)�� null���� ������ �� �� ���*/
select count(*) from emp;
select count(mgr) from emp;

/*����1: �μ��� �����ں� �޿���հ��*/
select deptno,mgr,avg(sal)
from emp
group by deptno,mgr;

/*����2: ������ �޿��հ� �߿� �޿� �հ谡 1000�̻��� ����*/
select * from emp;
select job,sum(sal)
from emp
group by job
having sum(sal)>=1000; /*>�� >= �򰥸��� �ʱ�*/

/*����3: �����ȣ 1000~1003���� �μ��� �޿��հ�*/
select deptno, sum(sal)
from emp
where empno between 1000 and 1003
group by deptno;



/*@@@@@@@@@@@@@@@@@����ȯ@@@@@@@@@@@@@@@@@*/

/*�Ͻ�������ȯ*/
desc emp;
select * from emp;
/*sal�� number��*/
select * from emp where sal='5000';
desc emp;

/*����� ����ȯ*/
/*to_number(���ڿ�):���ڿ��� ���ڷ� ��ȯ*/
/*to_char(���� Ȥ�� ��¥,[format]):���� Ȥ�� ��¥�� ������ format�� ���ڷ� ��ȯ*/
/*to_date(���ڿ�,format):���ڿ��� ������ format�� ��¥������ ��ȯ*/



/*@@@@@@@@@@@@@@@@@������ �Լ�@@@@@@@@@@@@@@@@@*/
desc dual;
select * from dual;

/*���ڿ�*/
select 
ascii('a'), /*ascii�ڵ尪�� �˷���*/
substr('abc',1,2), /*abc�� 1��°���� 2���� ������*/
length('a bc'),/*������ ������ ���̸� �˷���*/
ltrim(' abc'),/*���� ���� ����*/
from dual;

/*��¥��*/
select 
sysdate, /*���糯¥�ð�*/
extract(year from sysdate), /*��¥������ ������ ���*/
to_char(sysdate,'yyyymmdd') /*��¥�� ���������� ��ȯ*/
from dual;

/*������*/
select
abs(-1),/*���밪*/
sign(-10),/*����,0,����� -1,0,1�� ����*/
mod(4,2),/*4�� 2�� ������ ���� ������ = 4%2*/
ceil(10.9),/*�ø�*/
floor(10.1),/*����*/
round(10.222,1)/*�Ҽ��� ���ڸ����� �ݿø�*/
from dual;

/*@@@@@@@@@@@@@@@@@decode�� case@@@@@@@@@@@@@@@@@*/
/*DECODE*/
select decode(empno,1000,'T','F') /*empno�� 1000�̸� T, �ƴϸ� F*/
from emp;
/*CASE WHEN THEN ELSE END*/
select * from emp; 
select case
when empno=7839 then 'a'
when ename='BLAKE' then 'b'
else 'c'
end
from emp;



/*@@@@@@@@@@@@@@@@@ROWNUM�� ROWID@@@@@@@@@@@@@@@@@*/

/*ROWNUM*/
select * from emp
where rownum <= 5;

select *
from (select rownum list, ename from emp)
where list <=5;

select *
from (select rownum list, ename from emp)
where list between 5 and 10;
/*ROWID*/
SELECT ROWID, EMPNO FROM EMP;
SELECT * FROM EMP;

/*@@@@@@@@@@@@@@@@@WITH@@@@@@@@@@@@@@@@@*/
with viewdata as 
(select * from emp
union all
select * from emp
)
select * from viewdata where empno=7839;

select * from emp where empno=7839;