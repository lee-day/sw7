<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<%@page import="java.text.NumberFormat"%> 
<%@page import="java.util.*"%> 
<head>
	<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h4>회원매출조회</h4>
    <div style="text-align: center;"><!-- 이 부분 추가 시작 -->
    <form action="search_plus2.jsp" method="get">
        <select name="opt">
            <option value="custname">회원성명</option>
            <option value="grade">고객등급</option>
            <option value="price">가격</option>
        </select>
        <input type="text" name="value" placeholder="검색어를 입력하세요">
        <input type="submit" value="검색">
    </form>
    </div><!-- 이 부분 추가 끝 -->
    <%
    request.setCharacterEncoding("UTF-8");
    String opt = Util.getParamNN(request.getParameter("opt")); // 이 부분 추가 
    String value = Util.getParamNN(request.getParameter("value")); // 이 부분 추가
	
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
            "    ON me.custno = mo.custno ";
        
        // 검색 조건 추가
        if(!opt.isEmpty() && !value.isEmpty()) {
            sql += " WHERE me." + opt + " LIKE '%" + value + "%' ";
        }
        
        sql += "GROUP BY " +
            "    me.custno ";
        sql +=  "ORDER BY PRICE DESC ";
        //out.println(sql);		
        ResultSet rs = stmt.executeQuery(sql);
        NumberFormat nf = NumberFormat.getCurrencyInstance(new Locale("ko", "KR"));

	%>
	
	<table border="1" >
		<tr align="center">
			<td width='80px'>회원번호</td>
			<td width='80px'>회원성명</td>
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
			<td align="right"><%=nf.format(rs.getInt("price")) %></td> 
		</tr>	
	<%
		}
	
	} catch(Exception e) {
		e.printStackTrace();
	}
	%>
	</table>
</body>