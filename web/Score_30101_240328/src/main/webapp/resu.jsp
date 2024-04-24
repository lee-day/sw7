<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="DBPKG.Utill" %>


<%
	request.setCharacterEncoding("UTF-8");
	String stid = request.getParameter("stid");
	String sbj = request.getParameter("sbj");
	String mid = request.getParameter("mid");
	String fin = request.getParameter("fin");
	String att = request.getParameter("att");
	String rep = request.getParameter("rep");
	String etc = request.getParameter("etc");
	
	Connection conn = null;
	Statement stmt = null;
	
	conn = Utill.getConnection();
	stmt = conn.createStatement();
	String sql = "insert into tbl_grade_202205 values("
			+" '"+ stid +"',"
			+" '"+ sbj +"',"
			+" '"+ mid +"',"
			+" '"+ fin +"',"
			+" '"+ att +"',"
			+" '"+ rep +"',"	
			+" '"+ etc +"')";
	

	ResultSet rs = stmt.executeQuery(sql);

	response.sendRedirect("/Score_30101_240328/main.jsp");
	
%>


