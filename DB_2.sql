use world;
/*
insert into ~ select 구문
특정 테이블에 select로 조회한 테이블의 결과를 insert into로 넣을 수 있다.
insert into table명 (열명1, 열명2, 열명3)
select 구문;
*/
show tables;
select * from city;
select count(*) '총 레코드 수'
from city;
-- 테이블 내부에 열이 어떻게 만들어져 있는지 구성의 구조확인
desc city;
-- city 테이블에 저장된 데이터 중 5개의 행 만 조회
select * from city
limit 5;

/*
create tabel 테이블명(
	열명1 열데이터유형 제약조건,
    열명2 열데이터유형 제약조건,
    열명3 열데이터유형 제약조건,
)
*/
-- city_popul 테이블 생성
create table city_popul(
	city_name char(35),
    population int
);
select * from city;

insert into city_popul
select Name, population
from city;

select * from city_popul;
-- 다른 데이터베이스의 테이블에 박아 넣을때
insert into market_db.city_popul(city_name,population)
select name, population from world.city;
drop table city_popul;
create table city_popul(
	city_name char(35),
    population int
);

select * from city_popul;
select * from market_db.city_popul;

/*
UPDATE : 테이블에 이미 저장된 열의 데이터를 수정하는 SQL문
update 수정할테이블명
set 수정할열명1=수정할값, 수정할열명2 = 수정할값;
where 조건식;
*/
select * from city_popul
where city_name = '서울';

update city_popul 
set city_name = '서울'
where city_name = 'seoul';
-- ----------------------------------------
/*
	city_popul테이블의 city_name열에 저장된 데이터가 'New York'을 '뉴욕'으로 변경하고
    population의 인구수를 0으로 수정 조건 -> city_name이 New York인 열만 수정
*/
update city_popul
set city_name = '뉴욕', population = 0
where city_name = 'New York';

select city_name, population 
from city_popul
where city_name = '뉴욕';

-- city_name열의 모든 데이터들의 값을 모두 서울로 수정
-- update city_popul
-- set city_name = '서울';

select city_name
from city_popul;
-- population값을 모두 10000으로 나눈 값으로 변경
update city_popul
set population = population / 10000;
select * from city_popul
limit 5;

-- -----------------------------------------------------------------
/*
	delete문
    - 행단위로 데이터를 삭제하는 sql문 
    - delete from 테이블명 wehre 조건 
*/
-- city_name이 'New'로 시작하는 도시이름의 행 11개를 삭제
create view city as 
select * from city_popul;
select * from city;
delete from city
where city_name like 'New%';
select * from city
where city_name like 'New%';
select count(*) from city;
-- ---------------------------------------------------------------------









