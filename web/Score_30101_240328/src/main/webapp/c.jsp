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
	String sql = "select CASE std.course WHEN 'AD' THEN '전문학사' "+
			" WHEN 'BD' THEN '학사' WHEN 'MD' THEN '석사' "+
			" WHEN 'DD' THEN '박사' ELSE 'no' END as sbs, "+
			" std.studentid as stid, std.studentname as stname, "+
			" count(grd.subjectcode) as ct,"+
			" TRUNC(sum((grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10)) as summ,"+
			" TRUNC(sum((grd.mid*3+grd.final*3+grd.attend*2+grd.report+grd.etc)/10)/count(grd.subjectcode)) as pg "+
			" from tbl_grade_202205 grd "+
			" INNER JOIN tbl_student_202205 std "+
			" ON grd.studentid = std.studentid "+
			" group by std.studentid, std.studentname, std.course "+
			" order by std.studentid desc";
			

	ResultSet rs = stmt.executeQuery(sql);
	

%>ad
<h2>전체성적조회</h2>

<table border="">
<tr>
	<th>학위과정</th>
	<th>학번</th>
	<th>성명</th>
	<th>수강교과목수</th>
	<th>총점</th>
	<th>평균</th>
</tr>
<%
while(rs.next()){
%>
<tr>
	<td><%=rs.getString("sbs") %></td>
	<td><%=rs.getString("stid") %></td>
	<td><%=rs.getString("stname") %></td>
	<td><%=rs.getString("ct") %>과목</td>
	<td><%=rs.getString("summ") %></td>
	<td><%=rs.getString("pg") %></td>
</tr>
<%} %>

