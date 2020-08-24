/*사용자 계정의 테이블 조회*/
SELECT * FROM TABS;

/*EMP 테이블의 이름을 NEW_EMP로 변경하십시오.*/
ALTER TABLE EMP RENAME TO NEW_EMP;

/*EMP 테이블에 age 칼럼을 추가하십시오.*/
/*(age칼럼은 숫자형 2자리이고 기본값은 1이다.)*/
ALTER TABLE EMP ADD(AGE number(2) default 1);

/*EMP 테이블의 age칼럼명을 old로 변경하여라.*/
ALTER TABLE EMP
RENAME COLUMN age TO old;

/*INSERT문의 성능을 향상시키기 위해 Buffer Cache의 기록을 생략하는 옵션은 무엇인가?*/
NOLOGGING;

/*EMP테이블의 구조는 삭제하지 않고 모든 데이터를 삭제하시오.*/
/*(단 테이블의 데이터를 모두 삭제 후 테이블의 공간은 초기회해야 한다.)*/
TRUNCATE TABLE EMP;

/*TCL문 2개, DCL문 2개를 쓰시오.*/
COMMIT,ROLLBACK
GRANT,REVOKE

/*EMP 테이블에 DEPT 테이블의 기본키 DEPTNO 칼럼을 참조하는 외래키 FK_DEPT를 추가하시오.*/
ALTER TABLE EMP ADD
CONSTRAINT FK_DEPT (DEPTNO) REFERENCES DEPT (DEPTNO);