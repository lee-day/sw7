


SELECT 
    tb_member.name as "출제자",
    tb_test.name AS "문제",
    tb_test.hint AS "힌트",
    tb_test_sub.name AS "보기",
    tb_test_sub.dab AS "정답여부"
                    AS "학습모듈"
FROM 
    tb_test
JOIN
    tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test
JOIN    
    tb_member on tb_test.id_tb_member = tb_member.id;

 
    
    
SELECT 
	* 
FROM 
	tb_test;


//문제 관련 테이블을 연결해서 답(번호를 랜덤하게 섞어보여주기)
SELECT 
    tb_member.name as "출제자",
    tb_test.name AS "문제",
    tb_test.hint AS "힌트",
    tb_test_sub.name AS "보기",
    tb_test_sub.dab AS "정답여부",
    tb_ncs.name AS "학습모듈"
FROM 
    tb_test
JOIN
    tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test
JOIN
    tb_member on tb_test.id_tb_member = tb_member.id
JOIN
    tb_ncs on tb_test.seq_tb_ncs = tb_ncs.seq
ORDER BY 
	tb_test.seq asc,
	DBMS_RANDOM.VALUE;
    
select *from tb_ncs    
    
/*
  Create table tb_member(
 	id varchar2(20) NOT NULL,
 	pass varchar2(20) NOT NULL,
 	name varchar2(10) NOT NULL,
 	num number(2) NOT NULL,
 	constraint tb_member_pk Primary key(id)
 )
 
 

 Create table tb_test(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
	image_link varchar2(255) NOT NULL,
	hint varchar2(255) NOT NULL,
	seq_tb_ncs number(5) NOT NULL,
	id_tb_member varchar2(20) NOT NULL,
 	constraint tb_test_pk Primary key(seq)
 );
 
 
 Create table tb_ncs(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
 	file_link varchar2(255) NOT NULL,
  	constraint tb_ncs_pk Primary key(seq)
 );
 
  SEQ NAME        FILE_LINK         
 --- ----------- ----------------- 
   1 화면구현        https://ncs.go.kr
   2 프로그램언어활용    https://ncs.go.kr
   3 프로그램언어응용    https://ncs.go.kr
   4 개발자환경구축     https://ncs.go.kr
   5 애플리케이션배포    https://ncs.go.kr
   6 응용SW기초기술활용  https://ncs.go.kr
   7 SQL활용       https://ncs.go.kr
   8 애플리케이션테스트수행 https://ncs.go.kr
   9 UI테스트       https://ncs.go.kr

 
  
CREATE TABLE tb_test_sub(
    seq number(5) NOT NULL,
    seq_tb_test number(5) NOT NULL,
    name varchar2(255) NOT NULL,
    dab varchar2(3) DEFAULT 'No'
);
ALTER TABLE tb_test_sub ADD CONSTRAINT tb_test_sub_pk PRIMARY KEY(seq);
ALTER TABLE tb_test_sub ADD CONSTRAINT dab_check CHECK (dab IN ('Yes', 'No'));
 


 
 
            
*/