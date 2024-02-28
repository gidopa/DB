-- 테이블3 개 준비
create table market_db.big_table1(
select * from world.city, sakila.country
);
select count(*) from sakila.country;
select count(*) from big_table1; -- 444611 행
create table market_db.big_table2(
select * from world.city, sakila.country
);
select count(*) from big_table2; -- 444611 행

create table market_db.big_table3(
select * from world.city, sakila.country
);
select count(*) from big_table3; -- 444611 행
-- delete로 삭제 행을 다 삭제
delete from big_table1;
select * from big_table1;
-- drop table은 table 자체를 날려버림
drop table big_table2;
-- truncate문 : 테이블에 저장된 행 단위의 데이터를 모두 삭제하는 sql문
-- 단, where라는 조건문 사용 불가능. 테이블은 남겨놓고 데이터 모두 날림
truncate table big_table3;
select * from big_table3;
-- -------------------------------------------------------------------------------
/*
	MYSQL DBMS를 관리하는 언어는 SQL인데
		SQL종류
        1. DDL(Data Definition Language) - 데이터베이스의 구조를 정의하고 관리하는 작업을 하는 sql문
			create, truncate, drop, alter ....
        2. DML(Data Manipulation Language) - 데이터를 조작하고 관리하는 sql문
			select, insert, update, delete
		3. DCL(Data Control Language) - 데이터 접근 및 보안 범위를 제어하는 작업을 하는 sql문
			grant : 사용자에게 특정 작업을 수행할 수 있는 권한을 부여
            revoke : 사용자로부터 권한을 회수
		4. TCL(Transaction Control Language) - DB 트랜잭션을 관리하고 제어하는 작업을 처리하는 sql문
			트랜잭션 : DB의 데이터를 일관성 있게 유지하면서 데이터를 관리하기 위한 하나의 작업 단위
			COMMIT : 트랜잭션의 변경 사항을 영구적으로 데이터베이스에 적용하는 데 사용됩니다. 트랜잭션을 성공적으로 완료한 후에 COMMIT을 호출하면 변경 사항이 유지됩니다.
			ROLLBACK : 트랜잭션의 모든 변경 사항을 취소하고 이전 상태로 되돌리는 데 사용됩니다. 트랜잭션 중에 오류가 발생하거나 롤백이 필요한 경우에 사용됩니다.
			SAVEPOINT : 트랜잭션 내에서 특정 지점에 저장점을 설정합니다. 이후 ROLLBACK TO SAVEPOINT을 사용하여 해당 저장점으로 되돌릴 수 있습니다.
*/
create table hongong4(
tinyint_col tinyint, -- 정수 127까지 저장
smallint_col smallint, -- 정수 32767까지 저장
int_col int,  -- 정수 21억
bigint_col bigint -- 정수 약 900경
);
insert into hongong4(tinyint_col, smallint_col, int_col, bigint_col)
values (127, 32767, 2147483647, 90000000000000000);
select * from hongong4;
insert into hongong4(tinyint_col, smallint_col, int_col, bigint_col)
values (128, 32768, 2147483648, 90000000000000001);

create table big_table(
data1 char(256),
data2 varchar(16384)
);

-- netflix_db 
create database netflix_db;
use netflix_db;
create table movie(
movie_id int,
movie_title varchar(30),
movie_dir varchar(20), -- 감독
movie_star varchar(20), -- 평점
movie_script longtext, -- 영화 자막 텍스트파일 최대 4gb
movie_film longblob -- 영화 동영상 파일 최대 4gb
);
desc movie;
/*
	사용자 변수를 생성해 사용할 수 있음
    변수 생성 문법
    - set @변수명 = 저장할 값;
    변수에 저장된 값을 조회하는 문법
    - select @변수명;
*/
use market_db;
set @myVar1 = 5;
set @myVar2 = 4.25;
select @myVar1 + @myVar2;
set @txt = '가수 이름 ==>';
set @height = 166;
select mem_name, height
from member
where height > @height;

select @txt from member;
select mem_name '그룹명' from member;
select @txt, mem_name '그룹명' from member;

/*
	select문에 행의 개수를 제한해서 조회할때 limit을 사용
    제한할 행의 갯수도 변수를 선언하여 저장 해 놓고 변수명을 이용해서 값을 불러와 사용할 수 있다
*/
set @count = 3;
-- select mem_name, height from member order by height limit @count; -- 바로는 사용할 수 없음
-- prepare 구문에 mySQL 이름에 select문을 준비 해 놓고 사용.
-- 여기서 ? 는 아직 값이 정해지지 않아 나중에 결정 하겠다는 의미
prepare mySQL from 'select mem_name, height from member order by height limit ?';
-- using을 이용해 아직 결정되지 않은 값을 @count 변수의 값으로 설정하고 select 문장을 실행
execute mySQL using @count;
/*
	데이터 형변환 
    1. 개발자가 직접 제공되는 함수를 이용해 강제로 형변환
    select cast(형변환할값 as 변환할 데이터타입) "alias"
    from table명;
    select convert(형변환할값, 변환할 데이터타입) "alias"
    from table명;
    2. 자동형변환 
    
*/
-- 실습 1. buy테이블에서 구매한 평균 가격을 조회해서 가져오자
select avg(price) '평균가격' from buy;
-- 실수 값을 정수로 형변환
select cast(avg(price) as signed) '평균가격' from buy;
select convert(avg(price), unsigned) '평균가격' from buy;
-- 반올림, 내림 , 올림
select round(cast(avg(price) as signed), 0) as '평균가격' from buy;
select convert(floor(avg(price)), signed) as '평균가격' from buy;
select convert(ceil(avg(price)), signed) as '평균가격' from buy;
-- 날짜 데이터를 YYYY-MM-DD 날짜 형식을 만들기 위해 데이터 유형을 DATE를 사용해 형변환
select cast('2024$12$12' as DATE);
select cast('2024/12/12' as DATE);
select cast('2024-12-12' as DATE);
select cast('2024@12@12' as DATE);
select cast('20241212' as DATE);
-- 조회 결과를 원하는 날짜 형식으로 조회 가능
select * from buy;
select num,concat( cast(price as char), 'x', cast(amount as char) , '=') '가격 수량', price * amount '구매액'
from buy;
/*
	자동형변환
*/
-- 실습1. '100' + '200'
select '100' + '200';
select concat(100,200);
select 100 + '200';
select '100' + 200;
-- -----------------------------------------------------------------------------------------------






