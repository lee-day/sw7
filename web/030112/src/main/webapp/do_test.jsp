<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문제 풀기2</title>
</head>
<body>
<h1>출제 현황</h1>

<table border="1">
    <tr bgcolor='skyblue'>
      <td>출제자</td>
      <td>모듈</td>
      <td>총문제</td>
      <td>선다형</td>
      <td>진위형</td>
      <td>주관식</td>
      <td>연결형</td>
    </tr>
    <%@ page import="java.sql.*" %>
    <%@ page import="DBPKG.Utill" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <% 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        ResultSet rs_link = null;
        PreparedStatement pstmt_link = null;
        String prevSeq = ""; // 이전 문제의 seq 값을 저장하기 위한 변수
        try {
            conn = Utill.getConnection(); // 데이터베이스 연결을 설정합니다.
            String sql_total = " SELECT "+
							" tb_member.name AS 출제자, "+
							" tb_ncs.name AS 모듈, "+
							" COUNT(*) AS 총문제, "+
							" NVL(SUM(CASE WHEN tb_test.questionType = 1 THEN 1 ELSE 0 END), 0) AS 선다형, "+
							" NVL(SUM(CASE WHEN tb_test.questionType = 2 THEN 1 ELSE 0 END), 0) AS 진위형, "+
							" NVL(SUM(CASE WHEN tb_test.questionType = 3 THEN 1 ELSE 0 END), 0) AS 주관식, "+
							" NVL(SUM(CASE WHEN tb_test.questionType = 4 THEN 1 ELSE 0 END), 0) AS 연결형 "+
						" FROM "+ 
		            	    " tb_test "+
		            	" JOIN "+
		            	    " tb_member ON tb_test.id_tb_member = tb_member.id "+
		            	" JOIN "+
		            	    " tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq "+
		            	" WHERE "+ 
		            	    " tb_test.TYPE = 2 "+
		            	" GROUP BY "+
		            	    " tb_member.name, tb_ncs.name "+
		            	" order BY "+
				            " tb_member.name, tb_ncs.name ";
            //out.println(sql_total);
            pstmt = conn.prepareStatement(sql_total);
            rs = pstmt.executeQuery();
          	
            int count_number=1;
            int test_number=0;
            while(rs.next()) {    
	    	%>
	                <tr >
	                	<td><%= rs.getString("출제자") %></td>   
	                    <td><%= rs.getString("모듈") %></td>   
	                    <td><%= rs.getInt("총문제") %></td>   
	                    <td <% if(rs.getInt("선다형") < 4){ out.println("bgcolor=yellow"); } %>><%= rs.getInt("선다형") %></td>  
	                    <td <% if(rs.getInt("진위형") < 2){ out.println("bgcolor=yellow"); } %>><%= rs.getInt("진위형") %></td>  
	                    <td <% if(rs.getInt("주관식") < 2){ out.println("bgcolor=yellow"); } %>><%= rs.getInt("주관식") %></td>  
	                    <td <% if(rs.getInt("연결형") < 2){ out.println("bgcolor=yellow"); } %>><%= rs.getInt("연결형") %></td>  
	                </tr>
			<%} 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException e) { e.printStackTrace(); }
            try { if(pstmt != null) pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
            try { if(conn != null) conn.close(); } catch(SQLException e) { e.printStackTrace(); }
        }
    %>
</table>