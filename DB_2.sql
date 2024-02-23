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








