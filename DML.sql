create table emp(
empno number(4) primary key,
ename varchar2(20));



/*@@@@@@@@@@@@@@@@@insert문@@@@@@@@@@@@@@@@@*/

/*insert문*/
insert into emp(empno,ename) values(10,'임베스트')

/*모든 칼럼에 대한 데이터 삽입시 칼럼명 생략 가능*/
insert into emp values(11,'임베스트');

/*select문으로 입력*/
/*사전테이블 생성*/
create table emp_test(
empno number(4),
ename varchar2(20));
/*select문으로 입력*/
insert into emp_test select * from emp;

/*nologging 사용*/
/*nologging 옵션은 로그파일의 기록을 최소화시켜 입력시 성능을 향상시키는 방법*/
alter table emp nologging;



/*@@@@@@@@@@@@@@@@@update문@@@@@@@@@@@@@@@@@*/
/*데이터 값 수정*/
update emp
set ename='조조'
where empno='10';



/*@@@@@@@@@@@@@@@@@delete문@@@@@@@@@@@@@@@@@*/
/*원하는 조건 검색해서 해당되는 행 삭제*/
/*만약 where 절을 입력하지 않는 다면 테이블의 모든 데이터 삭제(테이블 용량 감소x)*/
delete from emp
where empno='10';
/*truncate table */
/*테이블의 모든 데이터 삭제(테이블 용량 초기화)*/
truncate table emp;


/*@@@@@@@@@@@@@@@@@select문@@@@@@@@@@@@@@@@@*/

insert into emp values(10,'송준영');
insert into emp values(11,'송채연');
select *
from emp;

/*뒤에 글자 붙여서 출력*/
select ename||'님' from emp;

/*order by를 사용한 오름차순정렬*/
select * from emp order by empno;
/*order by를 사용한 내림차순정렬*/
select * from emp order by empno desc;

/*index를 사용한 정렬 회피*/
drop table emp;
create table emp(
empno number(10) primary key,
ename varchar2(20),
sal number(10)
);
insert into emp values(1000,'김민수',20000);
insert into emp values(1001,'박영희',20000);
insert into emp values(1002,'최수지',20000);

select  /*+ INDEX_DESC(A)*/*
from emp A;

/*DISTINCT*/
select distinct sal /*중복제거*/
from emp;



/*@@@@@@@@@@@@@@@@@where문@@@@@@@@@@@@@@@@@*/

/*LIKE*/
/*%를 사용하지 않으면 =와 같음*/
select * from emp
where ename like '최%';

/*between*/
select * from emp
where sal between 10000 and 21000; /*10000이상 21000이하*/
/*not between*/
select * from emp
where sal not between 10000 and 21000 /*10000미만 21000초과*/

/*in*/
select * from emp
where ename in ('김민수','최수지' )

/*null*/
/*null은 모르는 값을 의미*/
/*null은 값의 부재를 의미*/
/*null과 숫자 혹은 날짜를 더하면 null이 됨*/
/*null은 어떤 값을 비교할 때, '알수없음'이 반환*/
/*null값 조회*/
select * from emp
where mgr is null;
insert into emp values(1004,'송준영','30000','스펀지송');
/*nvl(mgr,0) : mgr칼럼이 null이면 0으로 바꿈*/
select mgr,nvl(mgr,0) from emp;
/*nvl2(mgr,1,0) : mgr칼럼이 null이 아니면 1, null이면 0으로 반환*/
select mgr,nvl2(mgr,1,0) from emp;
/*nullif(exp1,exp2) : exp1과 exp2가 같으면 null을, 같지않으면 exp1을 반환*/
select mgr,nullif(empno,sal) from emp;
/*coalesce(exp1,exp2,exp3,...) : exp1이 null이 아니면 exp1의 값을, null이면 exp2의 값을 반환*/
select mgr,coalesce(mgr,'0') from emp;



/*테이블 생성*/
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


/*@@@@@@@@@@@@@@@@@group by문@@@@@@@@@@@@@@@@@*/
/*group by 기본*/
select mgr,sum(sal)
from emp
group by mgr;

/*having*/
select deptno, avg(sal)
from emp
group by deptno
having sum(sal)>10000;

/*count함수*/
/*count(*)는 null값을 포함한 모든 행수를 계산*/
/*count(칼럼명)은 null값을 제외한 행 수 계산*/
select count(*) from emp;
select count(mgr) from emp;

/*예제1: 부서별 관리자별 급여평균계산*/
select deptno,mgr,avg(sal)
from emp
group by deptno,mgr;

/*예제2: 직업별 급여합계 중에 급여 합계가 1000이상인 직업*/
select * from emp;
select job,sum(sal)
from emp
group by job
having sum(sal)>=1000; /*>와 >= 헷갈리지 않기*/

/*예제3: 사원번호 1000~1003번의 부서별 급여합계*/
select deptno, sum(sal)
from emp
where empno between 1000 and 1003
group by deptno;



/*@@@@@@@@@@@@@@@@@형변환@@@@@@@@@@@@@@@@@*/

/*암시적형변환*/
desc emp;
select * from emp;
/*sal은 number형*/
select * from emp where sal='5000';
desc emp;

/*명시적 형변환*/
/*to_number(문자열):문자열을 숫자로 변환*/
/*to_char(숫자 혹은 날짜,[format]):숫자 혹은 날짜를 지정된 format의 문자로 변환*/
/*to_date(문자열,format):문자열을 지정된 format의 날짜형으로 변환*/



/*@@@@@@@@@@@@@@@@@내장형 함수@@@@@@@@@@@@@@@@@*/
desc dual;
select * from dual;

/*문자열*/
select 
ascii('a'), /*ascii코드값을 알려줌*/
substr('abc',1,2), /*abc의 1번째부터 2개를 보여줌*/
length('a bc'),/*공백을 포함한 길이를 알려줌*/
ltrim(' abc'),/*왼쪽 공백 제거*/
from dual;

/*날짜형*/
select 
sysdate, /*현재날짜시각*/
extract(year from sysdate), /*날짜형에서 연도만 출력*/
to_char(sysdate,'yyyymmdd') /*날짜를 문자형으로 변환*/
from dual;

/*숫자형*/
select
abs(-1),/*절대값*/
sign(-10),/*음수,0,양수를 -1,0,1로 구분*/
mod(4,2),/*4를 2로 나누는 것의 나머지 = 4%2*/
ceil(10.9),/*올림*/
floor(10.1),/*내림*/
round(10.222,1)/*소수점 한자리에서 반올림*/
from dual;

/*@@@@@@@@@@@@@@@@@decode와 case@@@@@@@@@@@@@@@@@*/
/*DECODE*/
select decode(empno,1000,'T','F') /*empno가 1000이면 T, 아니면 F*/
from emp;
/*CASE WHEN THEN ELSE END*/
select * from emp; 
select case
when empno=7839 then 'a'
when ename='BLAKE' then 'b'
else 'c'
end
from emp;



/*@@@@@@@@@@@@@@@@@ROWNUM와 ROWID@@@@@@@@@@@@@@@@@*/

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