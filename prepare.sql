-- 동적 SQL
-- 쿼리문이 고정된 것이 아니라 상황에따라 where 조건열의 값을 변경해 필요할때마다 추가해 사용하는 쿼리문
-- prepare 예약어로 SQL문을 미리 준비함. execute로 준비된 쿼리문을 실행
-- member테이블에 저장된 "BLK"라는 그룹 아이디를 가진 그룹 회원의 정보를 조회하기 위해서 미리 prepare 예약어를 사용한 구문을 준비하고
-- execute 예약어를 통해 준비해놓은 쿼리문을 실행해 조회하자

-- 미리 준비해놓을 쿼리문을 가져다 실행할 이름
prepare myQuery from 'select * from member where mem_id = "BLK"';
execute myQuery ;

SET @mem_id_param = 'apn';
PREPARE myQuery FROM 'SELECT * FROM member WHERE mem_id = ?';
EXECUTE myQuery using @mem_id_param;

create table gate_table(
id INT auto_increment primary key,
entry_time datetime -- 'YYYY-MM-DD hh:mm:ss'
);
set @curDate = current_timestamp();
insert into gate_table values();
