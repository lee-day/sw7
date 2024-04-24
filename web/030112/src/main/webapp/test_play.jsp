<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문제 풀기2</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs_main = null;
    ResultSet rs = null;
    PreparedStatement pstmt = null;
    ResultSet rs_link = null;
    PreparedStatement pstmt_link = null;
    String prevSeq = ""; // 이전 문제의 seq 값을 저장하기 위한 변수
    try {
        conn = Utill.getConnection(); // 데이터베이스 연결을 설정합니다.
        int count_number=1;
        int test_number=0;
%>

<br>
<h1>문제 풀기</h1>
<form action="test_play_ok.jsp" method="post">
<table border="0">
  <thead>
    <tr>
      <th>랜덤으로 생성된 기출문제입니다.</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <% 
            String sql = "SELECT tb_test.seq AS seq " +
                         "FROM tb_test " +
                         "WHERE ROWNUM <= 20 ORDER BY DBMS_RANDOM.VALUE";        
            pstmt = conn.prepareStatement(sql);
            rs_main = pstmt.executeQuery();
          	//out.println(sql);
            count_number=1;
            test_number=0;
            while(rs_main.next()) {
            	String seq_ramdom = rs_main.getString("seq");         
            	String sql_sub = "SELECT tb_test.seq AS seq, " +
                        "tb_member.name as 출제자, " +
                        "tb_member.id as 출제자id, " +
                        "tb_test.name AS 문제, " +
                        "tb_test.image_link AS 이미지, " +
                        "tb_test.hint AS 힌트, " +
                        "tb_test_sub.seq AS tb_test_sub_seq, " +
                        "tb_test_sub.name AS 보기, " +
                        "tb_test_sub.dab AS 정답여부, " +                      
                        "tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답, " +
                        "tb_test.questionType AS 문제형태, " +
                        "tb_test.bogi AS 문제보기, " +
                        "tb_test_sub.image_link AS 보기_이미지, " +
                        "tb_ncs.name AS 학습모듈 " +
                        "FROM tb_test " +
                        "LEFT JOIN tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test " +
                        "LEFT JOIN tb_member ON tb_test.id_tb_member = tb_member.id " +
                        "LEFT JOIN tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq " +
                        "WHERE tb_test_sub.SEQ_TB_TEST_SUB IS NULL " +
                        "and tb_test.seq =" + seq_ramdom +
                        " ORDER BY DBMS_RANDOM.VALUE";
               //out.println(sql_sub);
               //out.println("<br><br>");
	           pstmt = conn.prepareStatement(sql_sub);
	           rs = pstmt.executeQuery();
	           while(rs.next()) {
	        	int count_no=0;
            	String bogi="";
                String currentSeq = rs.getString("seq");
            	if (!currentSeq.equals(prevSeq)) {
                	test_number=test_number+1;
                	count_number=1;
                    // seq 값이 변경되었을 때만 문제 정보를 출력
                	if(test_number==21){
    					break;
    	            }
    			%>
    			<tr>
	                <td colspan='3'><h3><%=test_number%>번 문제: [<%= rs.getString("학습모듈") %>]<%=rs.getString("문제") %></h3></td>
	            </tr>
                <%if(rs.getString("이미지") != null) {%>
                <tr>
				    <td colspan="3">
				        <img src='uploads/<%=rs.getString("이미지")%>' width='400px'>
				    </td>
				</tr>
				<%}%>
				<%if(rs.getString("문제보기") != null) {%>
                <tr>
				    <td colspan="3" bgcolor="#505050">
				    [보기]<br>
				        <font color='#ffffff'><%=rs.getString("문제보기")%></font>
				    </td>
				</tr>
				<%}%>
    <%
                }

            	int questionType=rs.getInt("문제형태");
            	if(questionType==1){
	                // 보기와 정답 여부 출력
	                if(count_number==1){
	                	bogi="① "+rs.getString("보기");
	                }else if(count_number==2){
	                	bogi="② "+rs.getString("보기");
	                }else if(count_number==3){
	                	bogi="③ "+rs.getString("보기");
	                }else if(count_number==4){
	                	bogi="④ "+rs.getString("보기");
	                }else{
	                	count_number=0;
	                }
	                count_number=count_number+1;
	    %>
	                <tr>
	                    <td colspan="3"><%= bogi %>
	                    <input type='radio' name='answer_<%=test_number%>' value='<%=rs.getString("tb_test_sub_seq")%>'></td>
	                </tr>
	    <%
	                prevSeq = currentSeq; // 이전 seq 값을 현재로 업데이트
	            }else if(questionType==2){
	        	    %>
	               	<tr>
					    <td colspan="3">
					        <label><input type='radio' name='answer_<%=test_number%>' value="O">O</label>
					        <label><input type='radio' name='answer_<%=test_number%>' value="X">X</label>
					    </td>
					</tr>
	    			<%	            	
	        	   }else if(questionType==3){
	        	    %>
					<tr>
					    <td colspan="3">
					        <!-- 사용자 답안 입력 필드 -->
					        <input type='text' id='answer_<%=test_number%>' value="" size='50'><br>
					    </td>
					</tr>
					<% 
					}else if(questionType==4){
						
				           count_no++;
					        // 연결형 문제
					        String links = "";				        
					        links = count_number + ". " + rs.getString("보기");
					        // 답이 'Yes'인 경우, 보기만 출력 
					        if("Yes".equals(rs.getString("정답여부"))){
					        	if(rs.getString("보기") != null){			                
				               
					%>
					<tr>
					    <td colspan="2" width="600"><%= rs.getString("보기") %></td>
					    <td colspan="2">
					    <% 
						String sql_link = "SELECT seq," +
											 " tb_test_sub.name AS 보기, " +
					                         " tb_test_sub.dab AS 정답여부, " +
					                         "tb_test_sub.image_link AS 보기_이미지, " +
					                         " tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답 " +
				                         " FROM tb_test_sub " +
				                         " WHERE "+ 
				                         	"tb_test_sub.SEQ_TB_TEST='" + currentSeq +"'"+
				                         	" AND tb_test_sub.SEQ_TB_TEST_SUB is not null" +
				                         	" AND tb_test_sub.name is not null" +
				                         " ORDER BY DBMS_RANDOM.VALUE";
            
            			pstmt_link = conn.prepareStatement(sql_link);
            			//out.println(sql_link);	
           				rs_link = pstmt_link.executeQuery();
			           // out.println(sql);
			            	
			           while(rs_link.next()) {
			           
			            %>
						<label>
				            <input type='radio' name='answer_link_<%=test_number%>_<%=count_no%>' value='<%= rs.getString("tb_test_sub_seq") %>'> <%= rs_link.getString("보기") %>
				        </label><br>
						<%
					        }
					    %>
					    
					    </td>
					</tr>
					<%
					        	}
					        }
					        prevSeq = currentSeq; // 이전 seq 값을 현재로 업데이트
					        count_number++;
					    }


            	}
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException e) { e.printStackTrace(); }
            try { if(pstmt != null) pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
            try { if(conn != null) conn.close(); } catch(SQLException e) { e.printStackTrace(); }
        }
    %>
  </tbody>
</table>
<input type="submit" value="답안 제출">
</form>