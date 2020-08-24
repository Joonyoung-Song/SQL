/*@@@@@@@@@@@@@@@조인@@@@@@@@@@@@@@@*/

/*카테시안 곱 발생*/
SELECT * 
FROM EMP,DEPT;

/*EQUI 조인*/
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO;

/*INNER 조인*/
SELECT *
FROM EMP
INNER JOIN DEPT
ON EMP.DEPTNO=DEPT.DEPTNO;

/*INTERSECT 연산*/
/*두 개의 테이블에서 교집합 조회*/
SELECT DEPTNO 
FROM EMP
INTERSECT
SELECT DEPTNO
FROM DEPT;

/*NON-EQUI 조인*/
/*등호(=)를 사용하지 않고 부등호(>)등을 사용한다.*/

/*OUTER 조인*/
/*오라클에서만 +기호를 통하여 OUTER JOIN이 가능*/
SELECT *
FROM DEPT,EMP
WHERE EMP.DEPTNO (+)= DEPT.DEPTNO;

/*LEFT OUTER 조인*/
SELECT *
FROM DEPT 
LEFT OUTER  JOIN EMP
ON EMP.DEPTNO=DEPT.DEPTNO;

/*RIGHT OUTER 조인*/
SELECT *
FROM DEPT
RIGHT OUTER JOIN EMP
ON EMP.DEPTNO=DEPT.DEPTNO;

/*CROSS 조인*/
/*조인구가 없기 때문에 카테시안 곱 발생*/
SELECT * 
FROM EMP
CROSS JOIN DEPT;

/*UNION(합집합)*/
/*두 테이블의 칼럼 수와 데이터 형식 모두가 일치해야 함(중복데이터는 제거하고 SORT함)*/
SELECT DEPTNO
FROM EMP
UNION
SELECT DEPTNO 
FROM EMP;

/*UNION ALL*/
/*중복데이터 제거 X, SORT X*/
SELECT DEPTNO 
FROM EMP
UNION ALL
SELECT DEPTNO 
FROM EMP;

/*MINUS(차집합)*/
/*MS-SQL에서는 EXCEPT를 사용*/
SELECT DEPTNO
FROM DEPT
MINUS
SELECT DEPTNO
FROM EMP;


/*@@@@@@@@@@@@@@@계층형 조회(CONNECT BY)@@@@@@@@@@@@@@@*/

SELECT *
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR;

SELECT LEVEL, /*검색 항목의 깊이*/
       LPAD(' ',4*(LEVEL-1))||EMPNO, /*트리형태로 보기위해서 함수 사용*/
       MGR,
       CONNECT_BY_ROOT(EMPNO), /*최상위 값 표시*/
       CONNECT_BY_ISLEAF /*최하위 값 표시*/
FROM EMP
START WITH MGR IS NULL
CONNECT BY PRIOR EMPNO=MGR;



/*@@@@@@@@@@@@@@@서브쿼리@@@@@@@@@@@@@@@*/

/*서브쿼리(WHERE절에)*/
SELECT *
FROM EMP
WHERE DEPTNO=(
             SELECT DEPTNO
             FROM DEPT
             WHERE DEPTNO=10);

/*인라인뷰(FROM절에)*/
SELECT *
FROM (SELECT ROWNUM
     FROM EMP)
WHERE ROWNUM<5;

/*IN : 반환되는 여러 개의 행중에서 하나만 참이 되어도 참이 되는 연산*/
/*IN을 사용해서 2000보다 큰 행들을 다 조회*/
SELECT ENAME, DNAME, SAL
FROM EMP, DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EMP.EMPNO
IN (SELECT EMPNO
    FROM EMP
    WHERE SAL > 2000);
    
/*ALL : 메인쿼리와 서브쿼리의 결과가 모두 동일하면 참이 됨*/
/*ALL을 사용해서 20,30보다 작거나 같은 것을 조회하므로 20이하가 조회됨*/
SELECT *
FROM EMP
WHERE DEPTNO <= ALL(20,30);

/*EXISTS : 서브쿼리로 어떤 데이터 존재여부 확인함. 즉, 참과 거짓으로 반환*/
SELECT *
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO
AND EXISTS (SELECT 1
           FROM EMP
           WHERE SAL > 2000);
           
/*스칼라 서브쿼리 : 여러행이 반환되면 오류 발생*/
SELECT ENAME AS "이름",
       SAL AS "급여",
       (SELECT AVG(SAL)
        FROM EMP) "평균급여"
FROM EMP
WHERE EMPNO=1000;

/*연관 서브쿼리 : 서브쿼리 내에서 메인쿼리 내의 칼럼을 사용함*/
SELECT *
FROM EMP A
WHERE A.DEPTNO=(SELECT DEPTNO
                FROM DEPT B
                WHERE B.DEPTNO = A.DEPTNO);



/*@@@@@@@@@@@@@@@그룹 함수@@@@@@@@@@@@@@@*/

/*ROLLUP : GROUP BY 칼럼에 대해서 SUBTOTAL을 만들어줌*/
SELECT DECODE(DEPTNO,NULL,'합계',DEPTNO),
       SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO);              
/*두개의 그룹핑이되면 부서별 직업별 합계를 구하고 총 합계도 구함*/
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

/*GROUPING : 생성되는 합계값을 0과 1로 구분*/
SELECT DEPTNO, GROUPING(DEPTNO), JOB, GROUPING(JOB), SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);
/*DECODE문을 활용해 1인 행에 텍스트 삽입*/
SELECT DEPTNO,DECODE(GROUPING(DEPTNO),1,'전체합계') TOT,JOB,DECODE(GROUPING(JOB),1,'직업별합계') SUBTOT,SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

/*GROUPING SETS : GROUP BY에 나오는 칼럼의 순서와 관계없이 다양한 소계 생성*/
/*여러 칼럼을 넣어도 관계없이 각각의 합계 계산*/
SELECT DEPTNO,JOB,SUM(SAL)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO,JOB);

/*CUBE : CUBE함수에 제시한 칼럼에 대해서 결합 가능한 모든 집계를 계산*/
SELECT DEPTNO,JOB,SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB);



/*@@@@@@@@@@@@@@@윈도우 함수@@@@@@@@@@@@@@@*/
/*첫행부터 마지막행까지 더함*/
SELECT EMPNO,ENAME,SAL,
       SUM(SAL) OVER (ORDER BY SAL
                      ROWS BETWEEN UNBOUNDED PRECEDING
                               AND UNBOUNDED FOLLOWING) TOTSAL
FROM EMP;

/*첫행부터 현재행까지 더함 (누적합)*/
SELECT EMPNO,ENAME,SAL,
       SUM(SAL) OVER (ORDER BY SAL
                      ROWS BETWEEN UNBOUNDED PRECEDING
                               AND CURRENT ROW) CUMTOTSAL
FROM EMP;

/*현재 행부터 마지막행까지 합계*/
SELECT EMPNO,ENAME,SAL,
       SUM(SAL) OVER (ORDER BY SAL
                      ROWS BETWEEN CURRENT ROW
                               AND UNBOUNDED FOLLOWING) FINTOT
FROM EMP;

/*순위함수(RANK)*/
/*RANK : 동일한 순위는 동일한 값 부여*/
SELECT ENAME, SAL,
       RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
       RANK() OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK
FROM EMP;

/*DENSE_RANK : 동일한 순위를 하나의 건수로 계산. 즉, 2등이 2명이면 3등이 없어야 하지만 해당 함수는 하나의 건수로 인식하기에 3등이 존재*/
SELECT ENAME, SAL,
       RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
       DENSE_RANK() OVER (ORDER BY SAL DESC) DENSE_RANK
FROM EMP;

/*ROW_NUMBER : 동일한 순위에 고유의 순위 부여*/
SELECT ENAME, SAL,
       RANK() OVER (ORDER BY SAL DESC) ALL_RANK,
       ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUM
FROM EMP;

/*집계함수*/
SELECT ENAME, SAL, MGR,
       SUM(SAL) OVER (PARTITION BY MGR) SUM_MGR
FROM EMP;

/*행순서 관련 함수*/
/*FIRST_VALUE : 파티션 중 가장 처음 나오는 값 구함(MIN을 통해 같은 결과 구하기 가능)*/
SELECT DEPTNO, ENAME, SAL,
       FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO 
                                ORDER BY SAL DESC 
                                ROWS UNBOUNDED PRECEDING)
FROM EMP;
/*LAST_VALUE : 파티션 중 가장 나중에 오는 값 구함(MAX를 통해 같은 결과 구하기 가능)*/
SELECT DEPTNO, ENAME, SAL,
       LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO
                               ORDER BY SAL
                               ROWS BETWEEN CURRENT ROW
                                        AND UNBOUNDED FOLLOWING)
FROM EMP;
/*LAG : 이전값 가져옴. 예를들어 PRE_SAL의 5000값은 SAL의 이전 데이터*/
SELECT DEPTNO,ENAME,SAL,
       LAG(SAL) OVER (ORDER BY SAL DESC) AS PRE_SAL
FROM EMP;
/*LEAD: 지정된 행의 값을 가지고 오는 것.(기본값 1)*/
SELECT DEPTNO,ENAME,SAL,
       LEAD(SAL,2) OVER (ORDER BY SAL)
FROM EMP;

/*비율관련함수*/
/*PERCENT_RANK:파티션에서 등수의 퍼센트를 구함*/
SELECT DEPTNO, ENAME, SAL,
       PERCENT_RANK() OVER (PARTITION BY DEPTNO
                            ORDER BY SAL DESC)
FROM EMP;
/*NTILE(N):N등분으로 분할하여라*/
SELECT DEPTNO, ENAME, SAL,
       NTILE(4) OVER (ORDER BY SAL DESC)
FROM EMP;