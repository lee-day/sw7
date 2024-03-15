<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
 	Connection conn=null;
 	Statement stmt=null;
 	String callback = ""; 	
 	try{
 		conn = Utill.getConnection(); 										// 데이터베이스 연결을 설정합니다.
	    stmt = conn.createStatement(); 										// SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
	    String sql = ""; 	
		    	sql=" select"
		    			+" id,"
		    			+" pass,"
		    			+" name,"
		    			+" num"
		    		+ " from "
		    			+ " tb_member"
		    		+ " order by "
		    			+ "id asc ";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()){
			out.println(rs.getString("name"));
			out.println(rs.getString("id"));
			out.println("<br>");
		}
 	}catch(Exception e) {
	    e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
	}
 %>
</body>
</html>