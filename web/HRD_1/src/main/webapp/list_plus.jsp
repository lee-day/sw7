<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<head>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h4>회원목록조회/수정</h4>
	<%
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	Statement stmt = null;
	String callback = "";
	try {
		conn = Util.getConnection();
		stmt = conn.createStatement();
		String sql = 
			"SELECT "+
			    "me.custno, "+
			    "me.custname, "+
			    "me.phone, "+
			    "me.address, "+
			    "TO_CHAR(me.joindate, 'YYYY-MM-DD') joindate, "+
			    "CASE me.grade "+
			    	"WHEN 'A' THEN 'VIP' "+
			    	"WHEN 'B' THEN '일반' "+
			    	"WHEN 'C' THEN '직원' "+
			    	"ELSE '' "+
			    "END grade, "+
			    "me.city " +
			"FROM "+
			    "member_tbl_02 me ";
		sql += 	"ORDER BY 1 ASC ";
		ResultSet rs = stmt.executeQuery(sql);
	%>
	
	<table border="1" >
		<tr align="center">
			<td>회원번호</td>
			<td>회원설명</td>
			<td>전화번호</td>
			<td>주소</td>
			<td>가입일자</td>
			<td>고객등급</td>
			<td>거주지역</td>
			<td>삭제</td> <!-- 이 부분 추가  --> 
		</tr>
	<%
		while(rs.next()){
	%>
		<tr align="center">
			<td><a href="modify.jsp?mod_custno=<%=rs.getInt("custno")%>"><%=rs.getInt("custno")%></a></td>
			<td><%=rs.getString("custname") %></td>
			<td><%=rs.getString("phone") %></td>
			<td><%=rs.getString("address") %></td>
			<td><%=rs.getString("joindate") %></td>
			<td><%=rs.getString("grade") %></td>
			<td><%=rs.getString("city") %></td>
			<td><a href="action.jsp?mode=delete&del_custno=<%=rs.getInt("custno")%>">[삭제]</a></td> <!-- 이 부분 추가  --> 
		</tr>	
	<%
		}
	
	} catch(Exception e) {
		e.printStackTrace();
	}
	%>
	</table>
</body>