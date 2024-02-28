select * from member;
select * from buy;

create view buy_member as
select a.mem_id, a.mem_name, a.mem_number, b.prod_name, b.price, b.amount
from member a
join buy b on a.mem_id = b.mem_id;

select * from buy_member;

create view left_view as 
select a.mem_id, a.mem_name, a.debut_date, b.prod_name, b.price, b.amount
from member a 
left join buy b on a.mem_id = b.mem_id;

select * from left_view;
/*
	inner join
    outer join
    self join
*/
/*
	inner join 양쪽의 열에 저장된 동일한 데이터가 있을때 사용되는 조인
    select 조회할열명
    from 첫번째테이블명 join 두번째테이블명
    on 조인을위한 조건 where 조건식;
*/
-- GRL이라는 그룹이 구매한 물건 배송을 위해 그룹이름,주소,연락처를 조회
select a.mem_name,b.prod_name,b.amount,a.addr, concat(a.phone1, a.phone2) '연락처'
from member a
join buy b on a.mem_id = b.mem_id
where b.mem_id = 'GRL';

select a.mem_id, a.mem_name, b.prod_name, a.addr
from member a
join buy b on a.mem_id = b.mem_id
order by a.mem_id;

--	사이트에서 한번이라도 구매한 기록이 있는 회원그룹의 아이디, 이름, 주소, 중복된 데이터 없이 buy 테이블과 member 테이블의 inner join
select distinct a.mem_id, a.mem_name, a.addr
from member a
join buy b on a.mem_id = b.mem_id
order by mem_id;

-- --------------------------------------------------------------------------------------------
/*
	두 테이블 중 한쪽 테이블의 열에만 데이터가 저장되어 있어도 두 테이블에 열을 모두 조회하기 위한 join
    기준으로 left, right, full이 있는데 mySQL에선 full outer join을 지원안해서 left, right join 한걸 union all 해서 합쳐야 함
    1. left outer join
    기준이 되는 테이블의 내용을 모두 조회해야 함. join한 테이블에서 해당 데이터가 없을 시 null 넣어줌
    2. right outer join
    오른쪽에 작성한 테이블을 기준으로 열에 모든데이터가 저장되어 있으면, 왼쪽 테이블에 열의 데이터가 저장되어 있지 않아도 모든 열값 조회
*/
-- 구매기록이 없는 그룹회원의 정보도 함께 모두 조회
select a.mem_id, mem_name, b.prod_name, sum(b.amount), a.addr
from member a
left join buy b on a.mem_id = b.mem_id
group by  a.mem_id,prod_name
order by a.mem_id;
-- 전체 회원 중 구매기록이 없는 그룹회원의 정보도 함께 모두 조회 right join
-- member의 mem_id가 buy의 mem_id가 일치하는 행이 있으면 member테이블을 기준으로 모든 값 조회 buy에서 해당 값 없으면 null
select a.mem_id, mem_name, b.prod_name, sum(b.amount), a.addr
from buy b
right join member a on a.mem_id = b.mem_id
group by a.mem_id,b.prod_name
order by a.mem_id;
-- 구매 기록이 없는 회원 목록 조회 left join, 열의 데이터 중복시 하나의 데이터로 조회
select distinct a.mem_id, a.mem_name, b.prod_name, a.addr
from member a left join buy b
on a.mem_id = b.mem_id
where prod_name is null
order by a.mem_id;

/*
	자체조인
    자신의 테이블의 두개의 열 데이터를 이용해 조회, 하나의 테이블에 서로다른 별칭으로 조인함
*/
-- 실습1. market_db데이터베이스 내부에 emp_table
create table emp_table(
	emp char(8), -- 직급
    manager char(4), -- 직속 상관의 직급
	phone varchar(8) -- 사내 내선 번호
    );
insert into emp_table values('대표', null, '0000');
insert into emp_table values('영업이사', '대표', '1111');
insert into emp_table values('관리이사', '대표', '2222');
insert into emp_table values('정보이사', '대표', '3333');
insert into emp_table values('영업과장', '영업이사', '1111-1');
insert into emp_table values('경리부장', '관리이사', '2222-1');
insert into emp_table values('인사부장', '관리이사', '2222-2');
insert into emp_table values('개발팀장', '정보이사', '3333-1');
insert into emp_table values('개발주임', '정보이사', '3333-1-1');
select * from emp_table;

select a.emp '직원', b.emp '직속상관', b.phone '직속상관번호'
from emp_table a join emp_table b
on a.manager = b.emp
where a.emp = '경리부장';








