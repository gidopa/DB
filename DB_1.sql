-- 개체 : 데이터료 표현하고자 하는 데이터베이스 구성요소
-- 개체 종류 : 테이블, 인덱스, 뷰, 스토어드프로시저, 트리거, 함수, 커서 등
-- 인덱스 : DB테이블에 저장된 데이터를 조회할때 B-트리 등을 사용해 검색속도를 향상 시키는 개체
-- 인덱스 개체를 사용하지 않고 member테이블에 저장되어 있는 아이유를 찾아서 조회
select * 
from member 
where member_name = '아이유';
-- 인덱스 개체 만들기
-- member테이블에 member_name열에 인덱스 개체를 지정 인덱스 개체의 이름은 idx_member_name
create index idx_member_name on member(member_name);

-- 뷰? 가상의 테이블
-- member테이블과 연결되는 회원 뷰(member_view)가상 테이블 생성
create view member_view 
as 
	select * from member;
select * from member_view;
-- 테이블을 사용하지 않고 굳이 뷰를 쓰는 이유
-- 1. 보안에 도움 2. 긴 SQL문을 간략하게 만들 수 있음

-- 스토어드 프로시저 : 프로그램 코드를 묶어 놓은 함수 같은 개체
-- 회원테이블에 저장된 member_name의 값이 나훈아인 모든 열값 조회
select * 
from member 
where member_name = '나훈아';
-- 상품테이블에 저장된 product_name의 값이 삼각김밥인 모든 열의 값 조회
select * 
from product 
where product_name = '삼각김밥';

-- 위 두 셀렉문을 하나의 스토어드 프로시저로 만들면
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
    SELECT * FROM member WHERE member_name = '나훈아';
    SELECT * FROM product WHERE product_name = '삼각김밥';
END //
DELIMITER ;

call myProc;

-- ------------------------------------------------------------------------
-- 주제 : 기본 조회 문 SELECT ~ FROM 절 배우기 
-- 데이터 조회 전 사용할 DB를 선택할때 사용하는 예약어
use market_db;
-- Select문
-- 특정 테이블의 데이터를 조회하여 가져올떄 사용하는 구문.
-- select
-- from 	조회할 테이블명
-- where	조건식
-- group by 그룹으로 묶을 데이터가 저장된 열명
-- having 	조건식
-- order by 정렬할데이터가저장된 열명 ASC or DESC (오름차순 혹은 내림차순)
select *
from member;
select *
from buy;
select mem_name
from member;

select addr, debut_date, mem_name
from member;

-- 열명 대신 별칭을 지어 조회된 결과를 보기 위해서
-- select 열명 별칭명, 조회열명 별칭명 from 테이블명;
-- select 열명 as 별칭명, 열명 as 별칭명 from 테이블
select debut_date as '데뷔일자', mem_name as '그룹명'
from member;

select *
from member
where mem_name='블랙핑크';

select *
from member
where mem_number = 4;
-- 6-1
select mem_id, mem_name, height
from member
where height<=165 && height>=162;
-- 6-2 between and 절
select mem_id, mem_name, height, mem_number
from member
where height between 162 and 165;

select mem_id, mem_name, height, mem_number
from member
where height>=165 and mem_number>6;

select *
from member;
-- 8-1
select mem_name, addr
from member
where addr='경기' or addr='전남' or addr='경남';
-- 8-2 IN()절 
select mem_name, addr
from member
where addr in ('경기','전남','경남');

CREATE VIEW buy_member AS
SELECT 
    b.mem_id,
    b.num,
    m.mem_name,
    b.prod_name,
    b.group_name,
    b.price,
    b.amount
FROM buy b
INNER JOIN member m ON b.mem_id = m.mem_id;
select *
from buy_member
order by num ASC;








