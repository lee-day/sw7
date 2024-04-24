<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<head>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h4>회원매출조회</h4>
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
			    "MAX(me.custno) custno, "+
			    "MAX(me.custname) custname, "+
			    "CASE MAX(me.grade) "+
			    	"WHEN 'A' THEN 'VIP' "+
			    	"WHEN 'B' THEN '일반' "+
			    	"WHEN 'C' THEN '직원' "+
			    	"ELSE '' "+
			    "END grade, "+
			    "sum(mo.price) price " +
			"FROM "+
			    "member_tbl_02 me " +
	   			"INNER JOIN money_tbl_02 mo " +
	   		"    ON me.custno = mo.custno " +
	   		"GROUP BY " +
	   		"    me.custno ";
		sql += 	"ORDER BY PRICE DESC ";
		ResultSet rs = stmt.executeQuery(sql);
	%>
	
	<table border="1" >
		<tr align="center">
			<td width='80px'>회원번호</td>
			<td width='80px'>회원설명</td>
			<td width='100px'>고객등급</td>
			<td width='100px'>가격</td>
		</tr>
	<%
		while(rs.next()){
	%>
		<tr align="center">
			<td><%=rs.getInt("custno") %></td>
			<td><%=rs.getString("custname") %></td>
			<td><%=rs.getString("grade") %></td>
			<td><%=rs.getString("price") %></td>
		</tr>	
	<%
		}
	
	} catch(Exception e) {
		e.printStackTrace();
	}
	%>
	</table>
</body>