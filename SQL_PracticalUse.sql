/*@@@@@@@@@@@@@@@����@@@@@@@@@@@@@@@*/

/*ī�׽þ� �� �߻�*/
SELECT * 
FROM EMP,DEPT;

/*EQUI ����*/
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO;

/*INNER ����*/
SELECT *
FROM EMP
INNER JOIN DEPT
ON EMP.DEPTNO=DEPT.DEPTNO;

/*INTERSECT ����*/
/*�� ���� ���̺��� ������ ��ȸ*/
SELECT DEPTNO 
FROM EMP
INTERSECT
SELECT DEPTNO
FROM DEPT;

/*NON-EQUI ����*/
/*��ȣ(=)�� ������� �ʰ� �ε�ȣ(>)���� ����Ѵ�.*/

/*OUTER ����*/
/*����Ŭ������ +��ȣ�� ���Ͽ� OUTER JOIN�� ����*/
SELECT *
FROM DEPT,EMP
WHERE EMP.DEPTNO (+)= DEPT.DEPTNO;

/*LEFT OUTER ����*/
SELECT *
FROM DEPT 
LEFT OUTER  JOIN EMP
ON EMP.DEPTNO=DEPT.DEPTNO;

/*RIGHT OUTER ����*/
SELECT *
FROM DEPT
RIGHT OUTER JOIN EMP
ON EMP.DEPTNO=DEPT.DEPTNO;

/*CROSS ����*/
/*���α��� ���� ������ ī�׽þ� �� �߻�*/
SELECT * 
FROM EMP
CROSS JOIN DEPT;

/*UNION(������)*/
/*�� ���̺��� Į�� ���� ������ ���� ��ΰ� ��ġ�ؾ� ��(�ߺ������ʹ� �����ϰ� SORT��)*/
SELECT DEPTNO
FROM EMP
UNION
SELECT DEPTNO 
FROM EMP;

/*UNION ALL*/
/*�ߺ������� ���� X, SORT X*/
SELECT DEPTNO 
FROM EMP
UNION ALL
SELECT DEPTNO 
FROM EMP;

/*MINUS(������)*/
/*MS-SQL������ EXCEPT�� ���*/
SELECT DEPTNO
FROM DEPT
MINUS
SELECT DEPTNO
FROM EMP;


/*@@@@@@@@@@@@@@@������ ��ȸ(CONNECT BY)@@@@@@@@@@@@@@@*/

SELECT *
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR;

SELECT LEVEL, /*�˻� �׸��� ����*/
       LPAD(' ',4*(LEVEL-1))||EMPNO, /*Ʈ�����·� �������ؼ� �Լ� ���*/
       MGR,
       CONNECT_BY_ROOT(EMPNO), /*�ֻ��� �� ǥ��*/
       CONNECT_BY_ISLEAF /*������ �� ǥ��*/
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR;



/*@@@@@@@@@@@@@@@��������@@@@@@@@@@@@@@@*/

/*��������(WHERE����)*/
SELECT *
FROM EMP
WHERE DEPTNO=(
             SELECT DEPTNO
             FROM DEPT
             WHERE DEPTNO=10);

/*�ζ��κ�(FROM����)*/
SELECT *
FROM (SELECT ROWNUM
     FROM EMP)
WHERE ROWNUM<5;

/*IN : ��ȯ�Ǵ� ���� ���� ���߿��� �ϳ��� ���� �Ǿ ���� �Ǵ� ����*/
/*IN�� ����ؼ� 2000���� ū ����� �� ��ȸ*/
SELECT ENAME, DNAME, SAL
FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EMP.EMPNO
IN (SELECT EMPNO
    FROM EMP
    WHERE SAL > 2000);
    
/*ALL : ���������� ���������� ����� ��� �����ϸ� ���� ��*/
/*ALL�� ����ؼ� 20,30���� �۰ų� ���� ���� ��ȸ�ϹǷ� 20���ϰ� ��ȸ��*/
SELECT *
FROM EMP
WHERE DEPTNO <= ALL(20,30);

/*EXISTS : ���������� � ������ ���翩�� Ȯ����. ��, ���� �������� ��ȯ*/
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EXISTS (SELECT 1
           FROM EMP
           WHERE SAL > 2000);
           
/*��Į�� �������� : �������� ��ȯ�Ǹ� ���� �߻�*/
SELECT ENAME AS "�̸�",
       SAL AS "�޿�",
       (SELECT AVG(SAL)
        FROM EMP) "��ձ޿�"
FROM EMP
WHERE EMPNO=1000;

/*���� �������� : �������� ������ �������� ���� Į���� �����*/
SELECT *
FROM EMP A
WHERE A.DEPTNO=(SELECT DEPTNO
                FROM DEPT B
                WHERE B.DEPTNO = A.DEPTNO);



/*@@@@@@@@@@@@@@@�׷� �Լ�@@@@@@@@@@@@@@@*/

/*ROLLUP : GROUP BY Į���� ���ؼ� SUBTOTAL�� �������*/
SELECT DECODE(DEPTNO,NULL,'�հ�',DEPTNO),
       SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO);              
/*�ΰ��� �׷����̵Ǹ� �μ��� ������ �հ踦 ���ϰ� �� �հ赵 ����*/
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

/*GROUPING : �����Ǵ� �հ谪�� 0�� 1�� ����*/
SELECT DEPTNO, GROUPING(DEPTNO), JOB, GROUPING(JOB), SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);
/*DECODE���� Ȱ���� 1�� �࿡ �ؽ�Ʈ ����*/
SELECT DEPTNO,DECODE(GROUPING(DEPTNO),1,'��ü�հ�') TOT,JOB,DECODE(GROUPING(JOB),1,'�������հ�') SUBTOT,SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

/*GROUPING SETS : GROUP BY�� ������ Į���� ������ ������� �پ��� �Ұ� ����*/
/*���� Į���� �־ ������� ������ �հ� ���*/
SELECT DEPTNO,JOB,SUM(SAL)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO,JOB);

/*CUBE : CUBE�Լ��� ������ Į���� ���ؼ� ���� ������ ��� ���踦 ���*/
SELECT DEPTNO,JOB,SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB);



/*@@@@@@@@@@@@@@@������ �Լ�@@@@@@@@@@@@@@@*/
/*ù����� ����������� ����*/
SELECT EMPNO,ENAME,SAL,
       SUM(SAL) OVER (ORDER BY SAL
                      ROWS BETWEEN UNBOUNDED PRECEDING
                               AND UNBOUNDED FOLLOWING) TOTSAL
FROM EMP;

/*ù����� ��������� ���� (������)*/
SELECT EMPNO,ENAME,SAL,
       SUM(SAL) OVER (ORDER BY SAL
                      ROWS BETWEEN UNBOUNDED PRECEDING
                               AND CURRENT ROW) CUMTOTSAL
FROM EMP;

/*���� ����� ����������� �հ�*/
SELECT EMPNO,ENAME,SAL,
       SUM(SAL) OVER (ORDER BY SAL
                      ROWS BETWEEN CURRENT ROW
                               AND UNBOUNDED FOLLOWING) FINTOT
FROM EMP;

/*�����Լ�(RANK)*/
/*RANK : ������ ������ ������ �� �ο�*/
SELECT ENAME, SAL,
       RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
       RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK
FROM EMP;

/*DENSE_RANK : ������ ������ �ϳ��� �Ǽ��� ���. ��, 2���� 2���̸� 3���� ����� ������ �ش� �Լ��� �ϳ��� �Ǽ��� �ν��ϱ⿡ 3���� ����*/
SELECT ENAME, SAL,
       RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
       DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK
FROM EMP;

/*ROW_NUMBER : ������ ������ ������ ���� �ο�*/
SELECT ENAME, SAL,
       RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
       ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUM
FROM EMP;

/*�����Լ�*/
SELECT ENAME, SAL, MGR,
       SUM(SAL) OVER (PARTITION BY MGR) SUM_MGR
FROM EMP;

/*����� ���� �Լ�*/
/*FIRST_VALUE : ��Ƽ�� �� ���� ó�� ������ �� ����(MIN�� ���� ���� ��� ���ϱ� ����)*/
SELECT DEPTNO, ENAME, SAL,
       FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO 
                                ORDER BY SAL DESC 
                                ROWS UNBOUNDED PRECEDING)
FROM EMP;
/*LAST_VALUE : ��Ƽ�� �� ���� ���߿� ���� �� ����(MAX�� ���� ���� ��� ���ϱ� ����)*/
SELECT DEPTNO, ENAME, SAL,
       LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO
                               ORDER BY SAL
                               ROWS BETWEEN CURRENT ROW
                                        AND UNBOUNDED FOLLOWING)
FROM EMP;
/*LAG : ������ ������. ������� PRE_SAL�� 5000���� SAL�� ���� ������*/
SELECT DEPTNO,ENAME,SAL,
       LAG(SAL) OVER (ORDER BY SAL DESC) AS PRE_SAL
FROM EMP;
/*LEAD: ������ ���� ���� ������ ���� ��.(�⺻�� 1)*/
SELECT DEPTNO,ENAME,SAL,
       LEAD(SAL,2) OVER (ORDER BY SAL)
FROM EMP;

/*���������Լ�*/
/*PERCENT_RANK:��Ƽ�ǿ��� ����� �ۼ�Ʈ�� ����*/
SELECT DEPTNO, ENAME, SAL,
       PERCENT_RANK() OVER (PARTITION BY DEPTNO
                            ORDER BY SAL DESC)
FROM EMP;
/*NTILE(N):N������� �����Ͽ���*/
SELECT DEPTNO, ENAME, SAL,
       NTILE(4) OVER (ORDER BY SAL DESC)
FROM EMP;