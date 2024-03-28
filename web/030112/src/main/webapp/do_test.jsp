<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문제 풀기</title>
    <script>
        // 정답 확인 함수
        function checkAnswer(isCorrect, elementId) {
            let message = isCorrect === 'Yes' ? '정답입니다!' : '틀렸습니다.';
            alert(message);
        }
        //ox 답안 확인 함수 
        function checkAnswer2(userAnswer, correctAnswer) {
            let message = userAnswer === correctAnswer ? '정답입니다!' : '틀렸습니다.';
            alert(message);
        }
     	// 주관식 답안 확인 함수
        function checkAnswer3(inputId, correctWord) {
            var userAnswer = document.getElementById(inputId).value;
            if (userAnswer.includes(correctWord)) {
                alert('정답입니다!');
            } else {
                alert('틀렸습니다.');
            }
        }
     	// 연결형 답안 확인 함수
        function checkAnswer4(userAnswer, correctAnswer) {
        	let message = userAnswer === correctAnswer ? '정답입니다!' : '틀렸습니다.';
            alert(message);
        }
    </script>
</head>
<body>

<h1>문제 풀기</h1>

<table border="1">
  <thead>
    <tr>
      <th>문제</th>
      <th>힌트(출제자)</th>
      <th>학습모듈</th>
    </tr>
  </thead>
  <tbody>
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
            String sql = "SELECT tb_test.seq AS seq, " +
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
                         "tb_ncs.name AS 학습모듈 " +
                         "FROM tb_test " +
                         "LEFT JOIN tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test " +
                         "LEFT JOIN tb_member ON tb_test.id_tb_member = tb_member.id " +
                         "LEFT JOIN tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq " +
                         "WHERE tb_test_sub.SEQ_TB_TEST_SUB IS NULL " +
                         "ORDER BY tb_test.seq DESC, DBMS_RANDOM.VALUE";
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
          	//out.println(sql);
            int count_number=1;
            int test_number=0;
            while(rs.next()) {
   
            	int questionType=rs.getInt("문제형태");
            	if(questionType==1){
            		
	            	String bogi="";
	                String currentSeq = rs.getString("seq");
	                if (!currentSeq.equals(prevSeq)) {
	                	test_number=test_number+1;
	                	count_number=1;
	                    // seq 값이 변경되었을 때만 문제 정보를 출력
	    %>
	                <tr bgcolor='skyblue'>
	                	<td><%=test_number%>번 문제: <%=rs.getString("문제") %></td>   
	                    <td><%= rs.getString("힌트") %>(<%= rs.getString("출제자") %>)
	                    <%if (session != null && session.getAttribute("userId").equals(rs.getString("출제자id"))) {%>
	                	<a href='test_ok.jsp?mode=delete&seq=<%=rs.getString("seq")%>'>x</a>
	                	<%}%>
	                    </td>
	                    <td><%= rs.getString("학습모듈") %></td>
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
					        <font color='#ffffff'><%=rs.getString("문제보기")%></font>
					    </td>
					</tr>
					<%}%>
	    <%
	                }
	                // 보기와 정답 여부 출력
	                if(count_number==1){
	                	bogi="① "+rs.getString("보기");
	                }else if(count_number==2){
	                	bogi="② "+rs.getString("보기");
	                }else if(count_number==3){
	                	bogi="③ "+rs.getString("보기");
	                }else if(count_number==4){
	                	bogi="④ "+rs.getString("보기");
	                }
	                count_number=count_number+1;
	    %>
	                <tr>
	                    <td colspan="2"><%= bogi %></td>
	                    <td>
	                        <button onclick="checkAnswer('<%= rs.getString("정답여부") %>')">정답</button>
	                    </td>
	                </tr>
	    <%
	                prevSeq = currentSeq; // 이전 seq 값을 현재로 업데이트
	            }else if(questionType==2){
	            	test_number=test_number+1;
	        	    %>
	                <tr bgcolor='skyblue'>
	                	<td><%=test_number%>번 문제: <%=rs.getString("문제") %></td>
	                    <td><%= rs.getString("힌트") %>(<%= rs.getString("출제자") %>)
	                    <%if (session != null && session.getAttribute("userId").equals(rs.getString("출제자id"))) {%>
	                	<a href='test_ok.jsp?mode=delete&seq=<%=rs.getString("seq")%>'>x</a>
	                	<%}%>
	                    </td>
	                    <td><%= rs.getString("학습모듈") %></td>
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
					        <font color='#ffffff'><%=rs.getString("문제보기")%></font>
					    </td>
					</tr>
					<%}%>
	               	<tr>
					    <td colspan="2">
					        <label><input type='radio' name='answer_<%= rs.getString("seq") %>' value="O">O</label>
					        <label><input type='radio' name='answer_<%= rs.getString("seq") %>' value="X">X</label>
					    </td>
					    <td>
					        <!-- `isCorrect`를 `Yes` 또는 `No` 대신 실제 정답 문자(`O` 또는 `X`)로 변경 -->
					        <button onclick="checkAnswer2(document.querySelector('input[name=answer_<%= rs.getString("seq") %>]:checked').value, '<%= rs.getString("정답여부").equals("Yes") ? "O" : "X" %>')">정답 확인</button>
					    </td>
					</tr>
	    			<%	            	
	        	   }else if(questionType==3){
	        		   test_number=test_number+1;
	        	    %>
	               <tr bgcolor='skyblue'>
					    <td><%=test_number%>번 문제: <%=rs.getString("문제") %></td>
					    <td><%= rs.getString("힌트") %>(<%= rs.getString("출제자") %>)
	                    <%if (session != null && session.getAttribute("userId").equals(rs.getString("출제자id"))) {%>
	                	<a href='test_ok.jsp?mode=delete&seq=<%=rs.getString("seq")%>'>x</a>
	                	<%}%>
	                    </td>
					    <td><%= rs.getString("학습모듈") %></td>
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
					        <font color='#ffffff'><%=rs.getString("문제보기")%></font>
					    </td>
					</tr>
					<%}%>
					<tr>
					    <td colspan="2">
					        <!-- 사용자 답안 입력 필드 -->
					        <input type='text' id='answer_<%= rs.getString("seq") %>' value="" size='50'>
					    </td>
					    <td>
					        <!-- 정답 확인 버튼, 정답 여부를 검사하는 JavaScript 함수에 사용자 입력값과 핵심 단어를 전달 -->
					        <button onclick="checkAnswer3('answer_<%= rs.getString("seq") %>', '<%= rs.getString("보기") %>')">정답 확인</button>
					    </td>
					</tr>
					<% 
					    }else if(questionType==4){
					        // 연결형 문제
					        String links = "";
					        String currentSeq = rs.getString("seq");
					        if (!currentSeq.equals(prevSeq)) {
					        	test_number=test_number+1;
					            // seq 값이 변경되었을 때만 문제 정보를 출력
					%>
					<tr  bgcolor='skyblue'>
					    <td width='600px'><%=test_number%>번 문제: <%=rs.getString("문제") %></td>
					    <td width='150px'><%= rs.getString("힌트") %>(<%= rs.getString("출제자") %>)
	                    <%if (session != null && session.getAttribute("userId").equals(rs.getString("출제자id"))) {%>
	                	<a href='test_ok.jsp?mode=delete&seq=<%=rs.getString("seq")%>'>x</a>
	                	<%}%>
	                    </td>
					    <td><%= rs.getString("학습모듈") %></td>
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
					        <font color='#ffffff'><%=rs.getString("문제보기")%></font>
					    </td>
					</tr>
					<%}%>
					<%
					        }
					        // 보기 출력
					        links = count_number + ". " + rs.getString("보기");
					        if("Yes".equals(rs.getString("정답여부"))){
					            // 답이 'Yes'인 경우, 보기만 출력
					%>
					<tr>
					    <td ><%= links %></td>
					    <td colspan="2">
					    <% 
						String sql_link = "SELECT seq," +
											 " tb_test_sub.name AS 보기, " +
					                         " tb_test_sub.dab AS 정답여부, " +
					                         " tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답 " +
				                         " FROM tb_test_sub " +
				                         " WHERE "+ 
				                         	"tb_test_sub.SEQ_TB_TEST='" + currentSeq +"'"+
				                         	" AND tb_test_sub.SEQ_TB_TEST_SUB is not null" +
				                         " ORDER BY DBMS_RANDOM.VALUE";
            
            			pstmt_link = conn.prepareStatement(sql_link);
            			//out.println(sql_link);	
           				rs_link = pstmt_link.executeQuery();
			           // out.println(sql);
			            while(rs_link.next()) {
			            %>
						<label>
				            <input type='radio' name='answer_link_<%= rs.getString("tb_test_sub_seq") %>' value='<%= rs.getString("tb_test_sub_seq") %>'> <%= rs_link.getString("보기") %>
				        </label><br>
						<%
					        }
					    %>
					    
					    </td>
					</tr>
					<%
					    
					        }
					        prevSeq = currentSeq; // 이전 seq 값을 현재로 업데이트
					        count_number++;
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