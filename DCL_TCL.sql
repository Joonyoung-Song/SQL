/*@@@@@@@@@@@@@@@@@DCL@@@@@@@@@@@@@@@@@*/

##GRANT
GRANT SELECT, INSERT, UPDATE, DELETE
   ON EMP
   TO song;
#GRANT에 들어갈 수 있는 권한 명령어
#SELECT
#INSERT
#UPDATE
#DELETE
#REFERENCES
#ALTER
#INDEX
#ALL
#WITH GRANT OPTION : 특정사용자에게 권한을 부여할 수 있는 권한을 부여한다.
GRANT SELECT, INSERT, UPDATE, DELETE
ON EMP
TO SONG WITH GRANT OPTION;
#WITH ADMIN OPTION : 테이블에 대한 모든 권한을 부여한다

##REVOKE : 부여된 권환 회수
REVOKE 권한 ON 테이블 FROM 사용자;

/*@@@@@@@@@@@@@@@@@TCL@@@@@@@@@@@@@@@@@*/
#COMMIT: INSERT, UPDATE, DELETE문으로 변경한 데이터를 데이터베이스 반영함 (DDL,DCL은 AUTO CUMMIT)
#ROLLBACK : 데이터에 대한 변경 사용 모두 취소 후 트랜잭션 종료
#SAVEPOINT : 트랜잭션 작게 분할관리하는 것. SAVEPOINT 사용하면 지정된 위치 이후 트랜잭션만 ROLLBACK 가능.(ROLLBACK TO SAVEPOINT명)(ROLLBACK을 입력하면 SAVEPOINT 적용 안됨)
