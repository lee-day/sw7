










select studentid, count(mid)
from tbl_grade_202205 
group by studentid
;

select CASE std.course WHEN 'AD' THEN '전문학사'
WHEN 'BD' THEN '학사' WHEN 'MD' THEN '석사' 
WHEN 'DD' THEN '박사' ELSE 'no' END as sbs, 
std.studentid as stid, std.studentname as stname,
count(grd.subjectcode) as ct,
TRUNC(sum((grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10)) as summ,
TRUNC(sum((grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10)/count(grd.subjectcode)) as pg
from tbl_grade_202205 grd
INNER JOIN tbl_student_202205 std
ON grd.studentid = std.studentid
group by std.studentid, std.studentname, std.course
order by std.studentid desc
;



select CASE std.course WHEN 'AD' THEN '전문학사'
WHEN 'BD' THEN '학사' WHEN 'MD' THEN '석사' WHEN 'DD' THEN '박사' END as hs, 
std.studentid as stid, std.studentname as stname
from tbl_grade_202205 grd
INNER JOIN tbl_student_202205 std
ON grd.studentid = std.studentid
group by std.studentid, std.studentname, std.course
order by grd.studentid desc
;



select grd.studentid AS "id", std.studentname AS "stname", 
CASE substr(std.jumin, 8,1) WHEN '3' THEN '남' WHEN '4' THEN '여' ELSE 'no' END AS "sex",
sbj.subjectname AS "subname", 
CASE sbj.classification WHEN '01' THEN '전공필수' WHEN '02' 
THEN '전공선택' WHEN '03' THEN '교양필수' WHEN '04' THEN '교양선택' ELSE 'no' END AS "class",
sbj.professorname AS "proname", grd.mid AS "mid", grd.final AS "final", 
grd.attend AS "attend", grd.report AS "report", grd.etc AS "etc",
(grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 AS "num",
CASE WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 90 THEN 'A'
WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 80 THEN 'B'
WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 70 THEN 'C'
WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 60 THEN 'D'
ELSE 'F' END AS "grade"
from tbl_grade_202205 grd
INNER JOIN tbl_student_202205 std
ON grd.studentid = std.studentid
INNER JOIN tbl_subject_202205 sbj
ON grd.subjectcode = sbj.subjectcode
order by grd.studentid, grd.subjectcode;


select grd.studentid AS "id", std.studentname AS "stname", CASE substr(std.jumin, 8,1) WHEN '3' THEN '남' WHEN '4' THEN '여' ELSE 'no' END AS "sex",sbj.subjectname AS "subname", CASE sbj.classification WHEN '01' THEN '전공필수' WHEN '02' THEN '전공선택' WHEN '03' THEN '교양필수' WHEN '04' THEN '교양선택' ELSE 'no' END AS "class",sbj.professorname AS "proname", grd.mid AS "mid", grd.final AS "final", grd.attend AS "attend", grd.report AS "report", grd.etc AS "etc",(grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 AS "num",CASE WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 90 THEN 'A'WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 80 THEN 'B'WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 70 THEN 'C'WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 60 THEN 'D'ELSE 'F' END AS "grade"from tbl_grade_202205 grdINNER JOIN tbl_student_202205 stdON grd.studentid = std.studentidINNER JOIN tbl_subject_202205 sbjON grd.subjectcode = sbj.subjectcodeorder by grd.studentid, grd.subjectcode;




create table tbl_student_202205 (
	studentid char(8) not null primary key,
	studentname varchar2(20),
	majorcode char(2),
	jumin varchar2(14),
	phone varchar2(13),
	course char(2)
);

create table tbl_subject_202205 (
	subjectcode char(4) NOT NULL primary key,
	subjectname varchar2(40),
	professorname varchar2(20),
	classification char(2)
);

create table tbl_grade_202205(
	studentid char(8) NOT NULL,
	subjectcode char(4) NOT NULL,
	mid number(3),
	final number(3),
	attend number(3), 
	report number(3),
	etc number(3),
	primary key(studentid,subjectcode)
);






insert into tbl_student_202205 values('20220001','김길동','03','030101-3000001','010-1111-0001','BD');
insert into tbl_student_202205 values('20220002','이길동','03','030101-3000002','010-1111-0002','BD');
insert into tbl_student_202205 values('20220003','박길동','03','030101-3000003','010-1111-0003','BD');
insert into tbl_student_202205 values('20220004','정길동','03','030101-4000004','010-1111-0004','BD');
insert into tbl_student_202205 values('20220005','최길동','03','030101-4000005','010-1111-0005','BD');
insert into tbl_student_202205 values('20220006','황길동','03','030101-4000006','010-1111-0006','BD');


insert into tbl_subject_202205 values('S001','메타버스의이해','김교수','02');
insert into tbl_subject_202205 values('S002','게임엔진기초','이교수','01');
insert into tbl_subject_202205 values('S003','게임엔진심화','박교수','01');
insert into tbl_subject_202205 values('S004','인문학개론','정교수','04');


insert into tbl_grade_202205 values('20220001','S001','70','80','100','100','90');
insert into tbl_grade_202205 values('20220001','S002','80','85','100','90','90');
insert into tbl_grade_202205 values('20220001','S003','70','80','100','100','100');
insert into tbl_grade_202205 values('20220002','S001','70','80','90','90','100');
insert into tbl_grade_202205 values('20220002','S002','60','70','100','90','100');
insert into tbl_grade_202205 values('20220002','S003','70','70','100','100','90');
insert into tbl_grade_202205 values('20220003','S001','90','90','90','100','100');
insert into tbl_grade_202205 values('20220003','S002','90','85','100','100','100');
insert into tbl_grade_202205 values('20220003','S003','100','100','100','90','100');
insert into tbl_grade_202205 values('20220004','S004','90','90','90','90','90');







