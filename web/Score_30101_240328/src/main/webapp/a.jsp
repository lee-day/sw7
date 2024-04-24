<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="DBPKG.Utill" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<style>
	table{
		margin: auto;
		margin-top: 30px;
	}
	h2{
		text-align:center;
	}
</style>
<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	Statement stmt = null;
	
	conn = Utill.getConnection();
	stmt = conn.createStatement();
	String sql = "select grd.studentid AS \"id\", std.studentname AS \"stname\",  "
			+"CASE substr(std.jumin, 8,1) WHEN '3' THEN '남' WHEN '4' THEN '여' ELSE 'no' END AS \"sex\", "
			+"sbj.subjectname AS \"subname\",  "
			+"CASE sbj.classification WHEN '01' THEN '전공필수' WHEN '02'  "
			+"THEN '전공선택' WHEN '03' THEN '교양필수' WHEN '04' THEN '교양선택' ELSE 'no' END AS \"class\", "
			+"sbj.professorname AS \"proname\", grd.mid AS \"mid\", grd.final AS \"final\", "
			+"grd.attend AS \"attend\", grd.report AS \"report\", grd.etc AS \"etc\","
			+"(grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 AS \"num\","
			+"CASE WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 90 THEN 'A' "
			+"WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 80 THEN 'B' "
			+"WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 70 THEN 'C' "
			+"WHEN (grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10 >= 60 THEN 'D' "
			+"ELSE 'F' END AS \"grade\" "
			+" from tbl_grade_202205 grd "
			+" INNER JOIN tbl_student_202205 std "
			+" ON grd.studentid = std.studentid "
			+" INNER JOIN tbl_subject_202205 sbj "
			+" ON grd.subjectcode = sbj.subjectcode "
			+" order by grd.studentid, grd.subjectcode";
			

	ResultSet rs = stmt.executeQuery(sql);
	

%>
<h2>전체성적조회</h2>

<table border="">
<tr>
	<th>학번</th>
	<th>성명</th>
	<th>성별</th>
	<th>과목명</th>
	<th>전공구분</th>
	<th>담당교수</th>
	<th>중간</th>
	<th>기말</th>
	<th>출석</th>
	<th>레포트</th>
	<th>기타</th>
	<th>점수</th>
	<th>등급</th>
</tr>
<%
while(rs.next()){
%>
<tr>
	<td><%=rs.getString("id") %></td>
	<td><%=rs.getString("stname") %></td>
	<td><%=rs.getString("sex") %></td>
	<td><%=rs.getString("subname") %></td>
	<td><%=rs.getString("class") %></td>
	<td><%=rs.getString("proname") %></td>
	<td><%=rs.getString("mid") %></td>
	<td><%=rs.getString("final") %></td>
	<td><%=rs.getString("attend") %></td>
	<td><%=rs.getString("report") %></td>
	<td><%=rs.getString("etc") %></td>
	<td><%=rs.getString("num") %></td>
	<td><%=rs.getString("grade") %></td>
</tr>
<%} %>


</table>
</body>
</html>