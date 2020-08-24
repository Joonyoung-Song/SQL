/*����� ������ ���̺� ��ȸ*/
SELECT * FROM TABS;

/*EMP ���̺��� �̸��� NEW_EMP�� �����Ͻʽÿ�.*/
ALTER TABLE EMP RENAME TO NEW_EMP;

/*EMP ���̺� age Į���� �߰��Ͻʽÿ�.*/
/*(ageĮ���� ������ 2�ڸ��̰� �⺻���� 1�̴�.)*/
ALTER TABLE EMP ADD(AGE number(2) default 1);

/*EMP ���̺��� ageĮ������ old�� �����Ͽ���.*/
ALTER TABLE EMP
RENAME COLUMN age TO old;

/*INSERT���� ������ ����Ű�� ���� Buffer Cache�� ����� �����ϴ� �ɼ��� �����ΰ�?*/
NOLOGGING;

/*EMP���̺��� ������ �������� �ʰ� ��� �����͸� �����Ͻÿ�.*/
/*(�� ���̺��� �����͸� ��� ���� �� ���̺��� ������ �ʱ�ȸ�ؾ� �Ѵ�.)*/
TRUNCATE TABLE EMP;

/*TCL�� 2��, DCL�� 2���� ���ÿ�.*/
COMMIT,ROLLBACK
GRANT,REVOKE

/*EMP ���̺� DEPT ���̺��� �⺻Ű DEPTNO Į���� �����ϴ� �ܷ�Ű FK_DEPT�� �߰��Ͻÿ�.*/
ALTER TABLE EMP ADD
CONSTRAINT FK_DEPT (DEPTNO) REFERENCES DEPT (DEPTNO);