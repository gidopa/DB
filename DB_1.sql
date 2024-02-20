-- 개체 : 데이터료 표현하고자 하는 데이터베이스 구성요소
-- 개체 종류 : 테이블, 인덱스, 뷰, 스토어드프로시저, 트리거, 함수, 커서 등
-- 인덱스 : DB테이블에 저장된 데이터를 조회할때 B-트리 등을 사용해 검색속도를 향상 시키는 개체
-- 인덱스 개체를 사용하지 않고 member테이블에 저장되어 있는 아이유를 찾아서 조회
select * from member where member_name = '아이유';
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
select * from member where member_name = '나훈아';
-- 상품테이블에 저장된 product_name의 값이 삼각김밥인 모든 열의 값 조회
select * from product where product_name = '삼각김밥';

-- 위 두 셀렉문을 하나의 스토어드 프로시저로 만들면
DELIMITER //
CREATE PROCEDURE myProc()
BEGIN
    SELECT * FROM member WHERE member_name = '나훈아';
    SELECT * FROM product WHERE product_name = '삼각김밥';
END //
DELIMITER ;

call myProc;
