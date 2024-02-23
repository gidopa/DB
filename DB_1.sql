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
-- Like 문자열 데이터의 일부 글자가 포함되어 있는 열의 데이터를 조회할 수 있는 예약어
-- __의 경우 글자 수 까지 정확하게 검사
select *
from member
where mem_name like '__핑크';

select *
from member
where mem_name like '우%';

select *
from member
where mem_name like '%크';

select *
from member
where mem_name like '%미%';

select *
from member
where mem_name like '%친구';

-- 서브쿼리 한 쿼리 문장안에 다수의 select문을 넣음
-- ( 키가 에이핑크 보다 큰 그룹을 조회함 )
select mem_name, height
from member
where height > (select height 
from member 
where mem_name = '에이핑크');
-- (에이핑크가 사는 주소와 같은 주소에 사는 그룹을 조회함)
select *
from member
where addr = ( select addr from member where mem_name = '에이핑크');

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

create view left_view as 
select 
    member.mem_id  AS member_mem_id,   -- member 테이블의 mem_id 열에 별칭을 지정
    member.mem_name, 
    member.mem_number, 
    member.addr, 
    member.phone1, 
    member.phone2, 
    member.height, 
    member.debut_date,
    buy.num, 
    buy.prod_name, 
    buy.group_name, 
    buy.price, 
    buy.amount
from member
left join buy on member.mem_id = buy.mem_id;

select * from left_view;

select *
from buy_member
order by num ASC;

select * from buy;
select * 
from member
order by debut_date ASC;

select * from member 
order by debut_date DESC;

select mem_name, mem_id, height
from member
where height > 164
order by height DESC;

select *
from member
order by height DESC, debut_date ASC;
-- 3건만 조회
select *
from member
limit 3;
-- 3번째 인덱스부터 2개의 데이터를 조회
select *
from member
order by height DESC
limit 3, 2;

select *
from left_view;

-- distinct 열의 데이터들이 중복되면 중복된 데이터를 하나만 남기고 조회함
-- select distinct 
select distinct addr
from member
order by addr ; 

-- group by 절은 집계함수 중 하나랑 같이 작성해서 사용
-- SUM(열명) : 열에 저장된 데이터들을 합계를 해서 반환
-- AVG(열명) : 열에 저장된 데이터들의 평균을 구해 반환
-- MIN() : 최솟값 반환 / MAX() : 최대값 반환 
-- count() : 행의 갯수를 반환  // count(distinct) : 중복되는 열 제외하고 행 갯수 반환
-- select 열명, 집게함수(열명2) from 테이블명
-- group by 그룹으로 묶을 데이터가 저장된 열명
-- having 조건식 order by ~ limit ~

select * from buy
order by mem_id ;

select mem_id, SUM(amount)
from buy
group by mem_id;

select mem_id '그룹 아이디', SUM(amount) '구매 수량', SUM(amount*price) '총 가격'
from buy
group by mem_id;

select mem_id, AVG(amount)
from buy
group by mem_id;

select mem_id, AVG(total) 
from (
select mem_id, SUM(price*amount) as total 
from buy 
group by mem_id) as subquery
group by mem_id;

select count(*) from member;
select * from member;

select count(phone2) '연락처가 있는 그룹' from member;

-- having 조건절 
-- where 조건절 대신 그룹으로 묶어준 데이터의 조건검사를 하는 구문
select mem_id, SUM(price*amount) total
from buy
group by mem_id
having total > 1000;

SELECT mem_id,
       SUM(price*amount) AS total,
       CASE WHEN SUM(price*amount) > 1000 THEN 'true' ELSE 'false' END AS gift
FROM buy
GROUP BY mem_id;
select * from buy;

/*
	db내부에 만든 테이블에 데이터를 추가/수정/삭제하는 SQL
    INSERT : 테이블에 행 데이터를 삽입하여 저장
			 insert into 행을추가핧테이블명(추가할값의열명1, 추가할값의열명2, 추가할값의열명3)
             values (값1,값2,값3);
    UPDATE : 
    DELETE
*/
use market_db;
create table hongong1(
	toy_id INT,
    toy_name char(4),
    age int
);
select * from hongong1;
insert into hongong1(toy_id,toy_name,age)
values (1,'우디',25);

insert into hongong1(toy_id,toy_name)
values(2,'버즈');

-- hongon1 테이블에 열명의 순서를 바꿔 추가로 저장
-- 주의할점은 ()사이에 작성한 열명의 순서에 맞게 values() 사이에 저장할 값을 넣어서 추가해야 함
insert into hongong1(toy_name,age,toy_id)
values('제시',20,3);
-- 테이블에 열명을 생략하고 values()에 추가값만 순서에 맞게 넣어 삽입가능. 
insert into hongong1 values(4,'영구',30);
/*
	auto_increment : 테이블 생성 시 열명에 설정하면 값이 자동으로 채워짐 1씩 증가하면서 채워진다 
*/
create table hongong2(
toy_id int auto_increment primary key,
toy_name char(4),
age int
);
select * from hongong2;
-- hongong2 테이블에 자동 증가하는 열의 데이터를 null로 채우고 데이터 추가
insert into hongong2(toy_id,toy_name,age)
values (null, '보핍', 25);
insert into hongong2(toy_id,toy_name,age)
values(null,'슬링키',22);
insert into hongong2(toy_id,toy_name,age)
values (null,'렉스',21);
-- toy_id 값을 아예 안줘도 자동으로 채워줌
insert into hongong2(toy_name,age)
values ('맹구',100);
-- 자동으로 증가된 값이 얼마인지 확인하는 검색 구문
select last_insert_id();
-- auto_increment를 지정한 열은 1부터 insert되기 때문에 특정 값 부터 insert 되게 설정 가능
alter table hongong2 auto_increment = 100; -- 초기값이 100부터 
insert into hongong2 (toy_name,age)
values ('재남',35);
insert into hongong2 (toy_name,age)
values ('승규',26);
-- auto_increment가 1씩 증가되고 있는데 속성으로 1이 아닌 다른 값으로도 증가 할 수 있음
create table hongong3(
toy_id int auto_increment primary key,
toy_name char(4),
age int
);
alter table hongong3 auto_increment = 1000;
-- auto_increment 1000부터 추가되는데 3씩 증가하도록 하려고 하면, @@auto_increment_increment의 변수의 값을 바꾸면 된다
set @@auto_increment_increment = 3;
insert into hongong3 values(null,'토마스',20);
insert into hongong3 values(null,'제임스',24);
insert into hongong3 values(null,'고든',22);
select * from hongong3;
insert into hongong3 values(null,'갤러거',23),(null,'엔조',8),(null,'mz세도',25);





