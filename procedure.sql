/*
	스토어드 프로시저
    db에 저장된 일련의 SQL문장들로 구성된 프로그램(개체)
    여러 줄의 sql 구문을 작성 해 놓을 스토어드 프로시저 생성을 위해 
    MySQL의 기본구분자(문장의 끝을 나타내는기호) 변경을 위해 $$로 설정
    delimiter $$
	create procedure 프로시저이름()
	begin
		SQL 코드
    end $$
    delimiter ; 기본구분자를 ;으로 다시 설정
    call 프로시저이름();
    --------------------------------------------------------------------------------
    if 조건식 then 
		조건식이 참일때 실행할 코드
	end if;
*/
-- 실습1. 
drop procedure if exists ifProc1;
delimiter $$
create procedure ifProc1()
begin
	if 100 = 100 then
    select '100은 100과 같다';
    end if;
end $$
delimiter ;
-- 위에 만든 ifProc1이라는 이름의 스토어드 프로시저 개체를 호출해서 실행시킴
call ifProc1();
/*
	if ~ else
    if 조건식 then
		실행문;
	else 
		실행문;
	end if;
*/
drop procedure if exists ifProc2;

delimiter $$
create procedure ifProc2()
begin
	declare myNum int; -- declare예약어를 사용해 myNum 변수를 선언.
    set myNum = 200; -- set 예약어를 사용해 myNum 변수에 200을 대입해 저장
    if myNum = 100 then
		select '100입니다';
	else
		select '100이 아님';
	end if;
end $$
delimiter ;

call ifProc2();
-- market_db에 만들어져 있는 member 테이블의 정보를 활용해 스토어드 프로시저 생성 후 사용
-- APN인 회원그룹의 데뷔일자가 5년이 넘었는지 확인하고 5년이 넘었으면 축하 메세지를 만들어서 출력
drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin
	declare debutDate date; -- 데뷔일 저장
    declare curDate date; -- 현재 날짜 저장
    declare days int; -- 데뷔일로부터 며칠 지났는지 저장
    
    -- 조회한 결과를 변수에 저장 하는 into
    select debut_date into debutDate
    from member
    where mem_id = 'APN';
    
    -- 참고. 오늘 컴퓨터의 시스템날짜를 반환하는 함수 -> current_date() 함수
    set curDate = current_date();
    -- 날짜2부터 날짜1까지 일수를 계산해주는 함수 -> datediff(날짜2, 날짜1)
    -- 활동일 계산
    set days = datediff(curDate, debutDate);
    if (days / 365) >= 5 then
		select concat('데뷔 한지', days, '일이 지났습니다 핑순이들 축하합니다!');
    else
		select '데뷔한지' + days +'일 밖에 안지났다 ㅎㅇㅌ';
    end if;
end$$
delimiter ;
call ifProc3();
-- 현재 날짜와 시간 정보를 함께 얻고 싶을떄 - current_timestamp() 함수
/*
	case문 - 2가지 이상의 조건식 중 선택해야 하는 경우 사용
    CASE
    when 조건식1 then
		sql문장;
	when 조건식2 then
		sql문장;
	else
		조건식이 모두 거짓일때 실행항 sql문장
	end case;
*/
drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
	declare score int; -- 점수
    declare credit char(1); -- 학점
    set score = 88;
    CASE
    when score >= 90 then
		set credit = 'A';
	when score >= 80 then
		set credit = 'B';
	when score >= 70 then
		set credit = 'C';
	when score >= 60 then
		set credit = 'D';
	else 
		set credit = 'F';
    end case;
    select concat('취득 점수 = ',score), concat('학점 = ',credit); 
end $$
delimiter ;
call caseProc();

drop procedure if exists caseProc;
delimiter $$
create procedure caseProc()
begin
select b.mem_id, b.mem_name,Sum(price*amount) "총 구매액",
case
when (sum(price*amount) >= 1500) then "최우수고객" 
when (sum(price*amount) >= 1000) then "우수고객"
when (sum(price*amount) >= 1) then "일반고객"
else '유령고객'
end '회원등급'
from buy a
right join member b on a.mem_id = b.mem_id
group by b.mem_id
order by SUM(price*amount) desc;
end $$
delimiter ;

call caseProc();
/*
	market_db에서 buy테이블에 회원그룹이 구매한 상품정보가 있음
    회원 그룹 아이디별로 총 구매액을 계산해서 회원등급을 4단계(최우수,우수,일반,유령)로 나누어서 조회
*/
select mem_id, SUM(price*amount) "총 구매액"
from buy
group by mem_id
order by SUM(price*amount) desc;

select b.mem_id, b.mem_name,Sum(price*amount) "총 구매액",
case
when (sum(price*amount) >= 1500) then "최우수고객" 
when (sum(price*amount) >= 1000) then "우수고객"
when (sum(price*amount) >= 1) then "일반고객"
else '유령고객'
end '회원등급'
from buy a
right join member b on a.mem_id = b.mem_id
group by b.mem_id
order by SUM(price*amount) desc;
/*
	while
    조건문이 참이면 반복 
*/
drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
declare i int;
declare sum int;
set i=1;
set sum = 0;
while (i<=100) do
	set sum = sum + i;
	set i = i + 1;
end while;
select '1부터 100까지의 합 : ', sum 	;
end $$
delimiter ;
call whileProc();

drop procedure if exists whileProc1;
delimiter $$
create procedure whileProc1()
begin
declare i int;
declare sum int;
set i=1;
set sum = 0;
mywhile :
while (i<=100) do
if(i % 4) =0 then
	set i = i + 1;
    iterate mywhile;
end if;
	set sum = sum + i;
if(sum >= 1000) then
	leave mywhile;
end if;
	set i = i + 1;
end while;
select '1부터 100까지의 합 : ', sum, i	;
end $$
delimiter ;
call whileProc1();



