/*@@@@@@@@@@@@@@���̺� ����@@@@@@@@@@@@@@*/

/*basic table ����*/
select * from dual;

/*emp ���̺� ����*/
Create table emp
(
 empno number(10) primary key,
 ename varchar2(20),
 sal number(6)
 );
 
 /*emp ���̺� ����*/
 drop table emp;

 /*dept ���̺� ����*/
 create table dept(
 deptno number(4) primary key,
 deptname varchar2(20));
 
 
 /*���������� ����Ͽ� emp���̺� ����*/
 create table emp(
 empno number(10),
 ename varchar2(20),
 sal number(10,2) default 0,  /*�Ҽ��� ��°�ڸ����� ���� �� �⺻�� 0*/
 deptno number(4) not null, /*null�� ���x*/
 createdate date default sysdate, /*����Ʈ sysdate(������ ��¥)*/
 constraint emppk primary key (empno), 
 constraint deptfk foreign key(deptno) /*deptnoĮ���� deptfk�̸����� �ܷ�Ű�� ����*/
             references dept(deptno) /*dept ���̺��� deptno�� ����*/
);
 
/*dept���̺� ������ �Է�*/
insert into dept values(1000,'�λ���');
insert into dept values(1001,'�ѹ���');

/*emp���̺� ����*/
drop table emp;

/*on delete cascade ����Ͽ� �����Ǵ� �����͸� �ڵ� �ݿ��ϵ��� �ϰ� emp ���̺� ����*/
 create table emp(
 empno number(10),
 ename varchar2(20),
 sal number(10,2) default 0,  /*�Ҽ��� ��°�ڸ����� ���� �� �⺻�� 0*/
 deptno number(4) not null, /*null�� ���x*/
 createdate date default sysdate, /*����Ʈ sysdate(������ ��¥)*/
 constraint emppk primary key (empno), 
 constraint deptfk foreign key(deptno) /*deptnoĮ���� deptfk�̸����� �ܷ�Ű�� ����*/
             references dept(deptno) /*dept ���̺��� deptno�� ����*/
             on delete cascade /*�����Ǵ� �����͸� �ڵ� �ݿ�*/
);

/*emp ���̺� ������ �Է�*/
insert into emp values(100,'�Ӻ���Ʈ',null,1000,sysdate);
insert into emp values(101,'��������',null,1001,sysdate);

/*dept ���̺��� ������ ����*/
delete from dept where deptno=1000;

/*emp�� �ִ� �൵ ������.*/
/*emp ������� on delete cascade ���� ������*/
select * from emp;



/*@@@@@@@@@@@@@@���̺� ����@@@@@@@@@@@@@@*/

/*���̺�� ����*/
alter table emp rename to new_emp;

/*Į�� �߰�*/
alter table new_emp add (age number(2) default 1);

/*Į�� ����(Į���� ������ Ÿ�� ���� �� �Ʒ��� ���� ������ �����Ͱ� �־��ٸ� ������ �߻���)*/
alter table new_emp modify(ename number(2) not null);

/*Į�� ����*/
alter table new_emp drop column age;

/*Į���� ����*/
alter table new_emp rename column age to old;



/*@@@@@@@@@@@@@@���̺� ����@@@@@@@@@@@@@@*/

/*���̺� ����*/
drop table new_emp;
drop table dept cascade constraint; /*dept���̺��� �����ϴ� ���̺��� ������׵� ����*/



/*@@@@@@@@@@@@@@���� ������ ����@@@@@@@@@@@@@@*/

/*�� ����*/
create view t_emp as select * from emp;
select * from t_emp;

/*�� ����*/
drop view t_emp;