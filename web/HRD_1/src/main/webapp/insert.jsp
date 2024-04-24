<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="DBPKG.Util"%>
<head>
    <link rel="stylesheet" type="text/css" href="style.css"> <!-- 외부 CSS 스타일시트 링크 -->
    
    <script>
   
    function validateForm() { 												// 폼 유효성 검사 함수
        var custname = document.getElementById('custname').value;     	   	// 폼 필드에서 값을 가져옵니다.
        var phone = document.getElementById('phone').value;
        var address = document.getElementById('address').value;
        var joindate = document.getElementById('joindate').value;
        var grade = document.getElementById('grade').value;
        var city = document.getElementById('city').value;

        if (custname == "") { 												// 회원성명이 비어있는지 확인합니다.
            alert("회원성명이 입력되지 않았습니다.");
            return false;  												
        }
        
        if (phone == "") { 													// 전화번호가 비어있는지 확인합니다.
            alert("전화번호가 입력되지 않았습니다.");
            return false;  												
        }

        var phonePattern = /^[0-9]{3}-[0-9]{4}-[0-9]{4}$/;					// 전화번호 패턴을 정규식으로 확인합니다.
        if (!phonePattern.test(phone)) {
            alert("전화번호 형식이 잘못되었습니다. 예: 010-1234-5678");
            return false;  												
        }
    
        
        if (grade != "A" && grade != "B" && grade != "C") {					// 고객 등급이 A, B, C 중 하나인지 확인합니다.
            alert("고객 등급은 A, B, C 중 하나여야 합니다.");
            return false;   											
        }
        
        alert("회원 등록이 완료 되었습니다.");										// 모든 유효성 검사를 통과하면 완료 메시지를 표시합니다.
        return true; 														// 유효성 검사 성공
    }
    </script>
</head>

<body>
	<h4>홈쇼핑 회원등록</h4>
	<%
	// 서버측 스크립트 시작
    request.setCharacterEncoding("UTF-8"); 										// 요청 인코딩을 UTF-8로 설정
    Connection conn = null;  													// 데이터베이스 연결 객체
    Statement stmt = null;  													// SQL 문을 실행하기 위한 Statement 객체
    String callback = "";  														// 리다이렉트 될 페이지 주소

    try {
        conn = Util.getConnection();  											// 데이터베이스 연결
        stmt = conn.createStatement();  										// Statement 객체 생성
        String sql = "SELECT MAX(custno) + 1 as custno FROM member_tbl_02"; 	// 회원번호를 생성하기 위한 SQL 쿼리
        //out.println(sql); 
        ResultSet rs = stmt.executeQuery(sql);  								// SQL 쿼리 실행
        rs.next(); // 결과 집합에서 다음 행으로 이동
        String custno2 = rs.getString("custno"); 								// 생성된 회원번호를 가져옴
        String custno = Util.getParamNN(rs.getString("custno")); 				// null이 아닌 회원번호를 가져옴
    %>
    <form name="form1" action="action.jsp" method="post"> <!-- 사용자 입력을 받는 폼 -->
        <input type="hidden" name="mode" value="insert" onsubmit="return validateForm()"> <!-- 숨겨진 필드로 'insert' 모드 지정 -->
        <table border="1"> <!-- 입력 필드가 있는 테이블 -->
            <!-- 각 행에는 레이블과 입력 필드가 있음 -->
            <tr>
                <td>회원번호(자동발생)</td>
                <td><input type="text" name="custno" id="custno" value="<%=custno%>" size='10' readonly></td>
            </tr>
			<tr>
				<td>회원성명</td>
				<td><input type="text" name="custname" id="custname" value="" size='10' ></td>
			</tr>
			<tr>
				<td>회원전화</td>
				<td><input type="tel" name="phone"  id="phone" value="" size='10' ></td>
			</tr>
			<tr>
				<td>회원주소</td>
				<td><input type="text" name="address"  id="address" value="" size='30' ></td>
			</tr>
			<tr>
				<td>가입일자</td>
				<td><input type="date" name="joindate" id="joindate" value="" ></td>
			</tr>
			<tr>
				<td>고객등급[A:VIP,B:일반,C:직원]</td>
				<td><input type="text" name="grade" id="grade" value="" size='10' ></td>
			</tr>
			<tr>
				<td>도시코드</td>
				<td><input type="text" name="city" id="city" value="" size='10' ></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="등 록">
					<input type="button" value="조 회" onclick="fn_search()">
				</td>
			</tr>
		  </table>
    </form>

    <% 
    } catch(Exception e) {
        e.printStackTrace();										 	// 예외 처리
    }
    %>
    
    <script>    
        function fn_search() {	       									// 검색 버튼 클릭 시 실행되는 함수
            window.location = 'list.jsp'; 								// 'list.jsp' 페이지로 이동
        }
        document.forms["form1"].onsubmit = validateForm;        		// 폼 제출 시 유효성 검사 함수 실행
    </script>
</body>