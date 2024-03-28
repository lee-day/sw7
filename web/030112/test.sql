SELECT 
    tb_member.name as "출제자",
    tb_test.count(*)
FROM 
    tb_test
JOIN    
    tb_member on tb_test.id_tb_member = tb_member.id
group by
	tb_test.seq



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

desc uploaded_files 
    


SELECT tb_test.seq AS seq, tb_member.name as 출제자, tb_test.name AS 문제, tb_test.image_link AS 이미지, tb_test.hint AS 힌트, tb_test_sub.seq AS tb_test_sub_seq, tb_test_sub.name AS 보기, tb_test_sub.dab AS 정답여부, tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답, tb_test.questionType AS 문제형태, tb_ncs.name AS 학습모듈 FROM tb_test LEFT JOIN tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test LEFT JOIN tb_member ON tb_test.id_tb_member = tb_member.id LEFT JOIN tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq WHERE tb_test_sub.SEQ_TB_TEST_SUB IS NULL ORDER BY tb_test.seq ASC, DBMS_RANDOM.VALUE


SELECT 
	* 
FROM 
	tb_test;


//문제 관련 테이블을 연결해서 답(번호를 랜덤하게 섞어보여주기)
SELECT 
	tb_test.seq AS "tb_test_seq",
	tb_test_sub.seq AS "tb_test_sub_seq",
    tb_member.name as "출제자",
    tb_test.name AS "문제",
    tb_test.hint AS "힌트",
    tb_test_sub.name AS "보기",
    tb_test_sub.dab AS "정답여부",
    tb_test_sub.SEQ_TB_TEST_SUB AS "연결형답",
    tb_ncs.name AS "학습모듈"
FROM 
    tb_test
LEFT JOIN
    tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test
LEFT JOIN
    tb_member ON tb_test.id_tb_member = tb_member.id
LEFT JOIN
    tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq
WHERE 
	tb_test_sub.SEQ_TB_TEST_SUB IS NULL 
ORDER BY 
	tb_test.seq asc,
	DBMS_RANDOM.VALUE;
    
select * from tb_ncs    


select seq,name,hint,id_tb_member from tb_test
select * from tb_test_sub
select * from tb_ncs

SELECT tb_test_sub.name AS 보기, tb_test_sub.dab AS 정답여부, tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답 FROM tb_test_sub WHERE tb_test_sub.SEQ_TB_TEST='1' AND tb_test_sub.SEQ_TB_TEST_SUB is not null ORDER BY DBMS_RANDOM.VALUE

SELECT tb_test.seq AS seq, tb_member.name as 출제자, tb_test.name AS 문제, tb_test.hint AS 힌트, tb_test_sub.seq AS tb_test_sub_seq, tb_test_sub.name AS 보기, tb_test_sub.dab AS 정답여부, tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답, tb_test.questionType AS 문제형태, tb_ncs.name AS 학습모듈 FROM tb_test LEFT JOIN tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test LEFT JOIN tb_member ON tb_test.id_tb_member = tb_member.id LEFT JOIN tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq WHERE tb_test_sub.SEQ_TB_TEST_SUB IS NULL ORDER BY tb_test.seq ASC, DBMS_RANDOM.VALUE
SELECT seq, tb_test_sub.name AS 보기, tb_test_sub.dab AS 정답여부, tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답 FROM tb_test_sub WHERE tb_test_sub.SEQ_TB_TEST='1' AND tb_test_sub.SEQ_TB_TEST_SUB is not null ORDER BY DBMS_RANDOM.VALUE
/*
  Create table tb_member(
 	id varchar2(20) NOT NULL,
 	pass varchar2(20) NOT NULL,
 	name varchar2(10) NOT NULL,
 	num number(2) NOT NULL,
 	constraint tb_member_pk Primary key(id)
 )
  <button onclick="
  	checkAnswer4(
  		document.querySelector(
  			'input[name=answer_link_<%= rs.getString("tb_test_sub_seq") %>]:checked'
  			).value, 
  		<%= rs_link.getString("연결형답") %>
  	)
  ">정답 확인</button>
 

 Create table tb_test(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
	image_link varchar2(255) NOT NULL,
	hint varchar2(255) NOT NULL,
	seq_tb_ncs number(5) NOT NULL,
	id_tb_member varchar2(20) NOT NULL,
	questionType number(1) NOT NULL,
 	constraint tb_test_pk Primary key(seq)
 );
 
 
 Create table tb_ncs(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
 	file_link varchar2(255) NOT NULL,
  	constraint tb_ncs_pk Primary key(seq)
 );
 
 
 Create table tb_image(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
 	image_data BLOB,
  	constraint tb_image_pk Primary key(seq)
 );
 
 CREATE TABLE uploaded_files (
    id number(5) NOT NULL,
    file_name VARCHAR2(255),
    file_size NUMBER,
    upload_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    constraint uploaded_files_pk PRIMARY KEY (id)
);
 
 desc tb_image
 
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
    dab varchar2(3) DEFAULT 'No',
    image_link varchar2(255) NOT NULL
);
ALTER TABLE tb_test_sub ADD CONSTRAINT tb_test_sub_pk PRIMARY KEY(seq);
ALTER TABLE tb_test_sub ADD CONSTRAINT dab_check CHECK (dab IN ('Yes', 'No'));
 


 desc tb_test_sub
 
            
*/