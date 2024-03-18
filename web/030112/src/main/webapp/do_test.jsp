<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문제 풀기2222</title>
      <script>
        // 정답 확인 함수
        function checkAnswer(isCorrect, elementId) {
            let message = isCorrect === 'Yes' ? '정답입니다!' : '틀렸습니다.';
            alert(message);
        }
    </script>
</head>
<body>

<h1>문제 풀기</h1>

<table border="1">
  <thead>
    <tr>
      <th>출제자</th>
      <th>문제</th>
      <th>힌트</th>
      <th>보기</th>
      <th>정답여부</th>
      <th>학습모듈</th>
    </tr>
  </thead>
  <tbody>
    <!-- 여기에 서버에서 가져온 데이터를 동적으로 삽입할 부분 -->
    <!-- 데이터베이스에서 가져온 문제 목록을 표시합니다. -->
    <%@ page import="java.sql.*" %>
    <%@ page import="DBPKG.Utill" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <% 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            conn = Utill.getConnection(); // 데이터베이스 연결을 설정합니다.
            stmt = conn.createStatement(); // SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
            String sql = "SELECT tb_member.name as 출제자, " +
                            "tb_test.name AS 문제, " +
                            "tb_test.hint AS 힌트, " +
                            "tb_test_sub.name AS 보기, " +
                            "tb_test_sub.dab AS 정답여부, " +
                            "tb_ncs.name AS 학습모듈 " +
                         "FROM tb_test " +
                         "JOIN tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test " +
                         "JOIN tb_member ON tb_test.id_tb_member = tb_member.id " +
                         "JOIN tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq " +
                         "ORDER BY tb_test.seq ASC, DBMS_RANDOM.VALUE";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while(rs.next()) {
    %>
                <tr>
                    <td><%= rs.getString("출제자") %></td>
                    <td><%= rs.getString("문제") %></td>
                    <td><%= rs.getString("힌트") %></td>
                    <td><%= rs.getString("보기") %></td>
                    <td>
                        <button onclick="checkAnswer('<%= rs.getString("정답여부") %>')">정답 확인</button>
                    </td>
                    <td><%= rs.getString("학습모듈") %></td>
                </tr>
    <%
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

</body>
</html>

