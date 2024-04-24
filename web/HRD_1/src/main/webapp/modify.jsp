<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<head>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
	<h4>홈쇼핑 회원 정보 수정</h4>
	<%
	request.setCharacterEncoding("UTF-8");
	String opt = Util.getParamNN(request.getParameter("opt"));
	String value = Util.getParamNN(request.getParameter("value"));
	String mod_custno = Util.getParamNN(request.getParameter("mod_custno"));
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
			    "me.grade, "+
			    "me.city " +
			"FROM "+
			    "member_tbl_02 me " + 
			"WHERE "+	
			    "me.custno =" + mod_custno;
		ResultSet rs = stmt.executeQuery(sql);
		rs.next();
		String custno = Util.getParamNN(rs.getString("custno"));
		String phone = Util.getParamNN(rs.getString("phone"));
		String address = Util.getParamNN(rs.getString("address"));
		String custname = Util.getParamNN(rs.getString("custname"));
		String joindate = Util.getParamNN(rs.getString("joindate"));
		String grade = Util.getParamNN(rs.getString("grade"));
		String city = Util.getParamNN(rs.getString("city"));
	%>
	<form name="form1" action="action.jsp" method="post">
		<input type="hidden" name="mode" value="modify">
		<table border="1">
			<tr>
				<td>회원번호(자동발생)</td>
				<td><input type="text" name="custno" value='<%=custno%>'size='10'></td>
			</tr>
			<tr>
				<td>회원성명</td>
				<td><input type="text" name="custname" value="<%=custname%>" size='10'></td>
			</tr>
			<tr>
				<td>회원전화</td>
				<td><input type="tel" name="phone" value="<%=phone%>" size='10'></td>
			</tr>
			<tr>
				<td>회원주소</td>
				<td><input type="text" name="address" value="<%=address%>" size='30'></td>
			</tr>
			<tr>
				<td>가입일자</td>
				<td><input type="date" name="joindate" value="<%=joindate%>" ></td>
			</tr>
			<tr>
				<td>고객등급[A:VIP,B:일반,C:직원]</td>
				<td><input type="text" name="grade" value="<%=grade%>" size='10'></td>
			</tr>
			<tr>
				<td>도시코드</td>
				<td><input type="text" name="city" value="<%=city%>" size='10'></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="수 정" onclick="fn_submit()">
					<input type="button" value="조 회" onclick="fn_search()">
				</td>
			</tr>
		</table>
	</form>
	<%
	} catch(Exception e) {
		e.printStackTrace();
	}
	%>
	<script>
		function fn_submit() {
			document.querySelector("form[name='form1']").submit();
			alert('회원정보 수정이 완료 되었습니다!');
		}
		function fn_search() {
			window.location = 'list.jsp';
		}
	</script>
</body>