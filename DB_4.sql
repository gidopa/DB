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
    
*/


