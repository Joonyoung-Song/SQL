/*@@@@@@@@@@@@@@테이블 생성@@@@@@@@@@@@@@*/

/*basic table 열람*/
select * from dual;

/*emp 테이블 생성*/
Create table emp
(
 empno number(10) primary key,
 ename varchar2(20),
 sal number(6)
 );
 
 /*emp 테이블 삭제*/
 drop table emp;

 /*dept 테이블 생성*/
 create table dept(
 deptno number(4) primary key,
 deptname varchar2(20));
 
 
 /*제약조건을 사용하여 emp테이블 생성*/
 create table emp(
 empno number(10),
 ename varchar2(20),
 sal number(10,2) default 0,  /*소수점 둘째자리까지 저장 및 기본값 0*/
 deptno number(4) not null, /*null값 허용x*/
 createdate date default sysdate, /*디폴트 sysdate(오늘의 날짜)*/
 constraint emppk primary key (empno), 
 constraint deptfk foreign key(deptno) /*deptno칼럼을 deptfk이름으로 외래키로 지정*/
             references dept(deptno) /*dept 테이블의 deptno를 참조*/
);
 
/*dept테이블에 데이터 입력*/
insert into dept values(1000,'인사팀');
insert into dept values(1001,'총무팀');

/*emp테이블 삭제*/
drop table emp;

/*on delete cascade 사용하여 참조되는 데이터를 자동 반영하도록 하고 emp 테이블 생성*/
 create table emp(
 empno number(10),
 ename varchar2(20),
 sal number(10,2) default 0,  /*소수점 둘째자리까지 저장 및 기본값 0*/
 deptno number(4) not null, /*null값 허용x*/
 createdate date default sysdate, /*디폴트 sysdate(오늘의 날짜)*/
 constraint emppk primary key (empno), 
 constraint deptfk foreign key(deptno) /*deptno칼럼을 deptfk이름으로 외래키로 지정*/
             references dept(deptno) /*dept 테이블의 deptno를 참조*/
             on delete cascade /*참조되는 데이터를 자동 반영*/
);

/*emp 테이블에 데이터 입력*/
insert into emp values(100,'임베스트',null,1000,sysdate);
insert into emp values(101,'을지문덕',null,1001,sysdate);

/*dept 테이블에서 데이터 삭제*/
delete from dept where deptno=1000;

/*emp에 있는 행도 삭제됨.*/
/*emp 생성당시 on delete cascade 구문 때문에*/
select * from emp;



/*@@@@@@@@@@@@@@테이블 변경@@@@@@@@@@@@@@*/

/*테이블명 변경*/
alter table emp rename to new_emp;

/*칼럼 추가*/
alter table new_emp add (age number(2) default 1);

/*칼럼 변경(칼럼의 데이터 타입 변경 시 아래와 같이 기존에 데이터가 있었다면 에러가 발생함)*/
alter table new_emp modify(ename number(2) not null);

/*칼럼 삭제*/
alter table new_emp drop column age;

/*칼럼명 변경*/
alter table new_emp rename column age to old;



/*@@@@@@@@@@@@@@테이블 변경@@@@@@@@@@@@@@*/

/*테이블 삭제*/
drop table new_emp;
drop table dept cascade constraint; /*dept테이블을 참조하는 테이블의 제약사항도 삭제*/



/*@@@@@@@@@@@@@@뷰의 생성과 삭제@@@@@@@@@@@@@@*/

/*뷰 생성*/
create view t_emp as select * from emp;
select * from t_emp;

/*뷰 삭제*/
drop view t_emp;