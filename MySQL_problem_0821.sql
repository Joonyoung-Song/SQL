
CREATE TABLE ALL_MEMBERS(
member_no int(10),
kurly_yn varchar(20)
);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ALL_MEMBERS.csv' 
INTO TABLE ALL_MEMBERS 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

CREATE TABLE ALL_ORDERS(
order_code int(10),
order_time datetime(6),
order_pay int(20),
pay_yn varchar(20),
member_no int(10)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ALL_ORDERS.csv' 
INTO TABLE ALL_ORDERS 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

select *
from ALL_MEMBERS;
select *
from ALL_ORDERS;


/*1번*/
/*ALL_MEMBERS 내 회원(member_no) 중 임직원이 아닌 회원에 대해 
1. 첫 구매 일시(first_buy_time) 
2. 마지막 구매 일시(last_buy_time) 
3. 총 결제액(sum_pay) 
4. 주문수(order_cnt) 를 구하는 쿼리를 작성하시오
(단, 위 네 컬럼은 모두 결제완료된 주문에 한해 계산되어야 함. 
또한 쿼리를 실행하여 얻게 되는 데이터엔 ALL_MEMBERS에 존재하지 않는 회원(member_no)이 있어선 안 됨.) 
• 주의 : ALL_MEMBERS엔 결제를 한 번도 완료하지 않은 회원이 존재함.
*/

SELECT  AM.member_no, MIN(order_time) first_buy_time, MAX(order_time) last_buy_time, SUM(DISTINCT(order_pay)) sum_pay, COUNT(DISTINCT(order_code)) order_cnt
FROM (SELECT *
      FROM ALL_MEMBERS
      WHERE kurly_yn like 'n%') AM
LEFT OUTER JOIN ALL_ORDERS AO ON AM.member_no = AO.member_no AND AO.pay_yn NOT like 'n%'
group by AM.member_no;

/*2번*/
/*ALL_ORDERS 내 결제완료된 주문(order_code)에 대해 
각각 해당 회원(member_no)의 몇 번째 주문인지(order_seq)를 order_code, order_time과 함께 나타내는 쿼리를 작성하시오.
*/

SELECT F.member_no, F.order_code, F.order_time,
	SUM(F.cnt) OVER(PARTITION BY F.member_no ORDER BY F.SEQ) AS order_seq
FROM (
	SELECT ROW_NUMBER() OVER() SEQ, member_no, order_code,order_time, COUNT(distinct(order_time)) CNT
	FROM (SELECT AM.member_no,order_code,order_time
		FROM ALL_MEMBERS AM
		JOIN ALL_ORDERS AO 
		ON AO.member_no = AM.member_no
		WHERE pay_yn like 'y%') JN
	GROUP BY JN.member_no,order_code,order_time
) F;
