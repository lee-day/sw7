<%@page import="java.sql.*"%> 
<!-- java.sql 패키지를 임포트합니다. JDBC를 사용하여 데이터베이스 작업을 수행하는 데 필요합니다. -->
<%@page import="DBPKG.Util"%> 
<!-- 사용자 정의 DBPKG 패키지 내의 Util 클래스를 임포트합니다. 데이터베이스 연결 및 유틸리티 기능을 제공할 수 있습니다. -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!-- JSP 페이지의 언어를 Java로 설정하고, 컨텐츠 유형 및 문자 인코딩을 UTF-8로 설정합니다. -->

<%
	request.setCharacterEncoding("UTF-8"); 									// 요청 객체의 문자 인코딩을 UTF-8로 설정합니다.
	String mode = Util.getParamNN(request.getParameter("mode")); 			// 'mode' 파라미터 값을 가져옵니다. Util 클래스의 getParamNN 메소드를 사용하여 null이 아닌 값을 보장합니다.
	String custno = Util.getParamNN(request.getParameter("custno")); 		// 'custno' (고객 번호) 파라미터 값을 가져옵니다.
	String custname = Util.getParamNN(request.getParameter("custname")); 	// 'custname' (고객 이름) 파라미터 값을 가져옵니다.
	String phone = Util.getParamNN(request.getParameter("phone")); 			// 'phone' (전화번호) 파라미터 값을 가져옵니다.
	String address = Util.getParamNN(request.getParameter("address")); 		// 'address' (주소) 파라미터 값을 가져옵니다.
	String joindate = Util.getParamNN(request.getParameter("joindate")); 	// 'joindate' (가입 날짜) 파라미터 값을 가져옵니다.
	String grade = Util.getParamNN(request.getParameter("grade")); 			// 'grade' (등급) 파라미터 값을 가져옵니다.
	String city = Util.getParamNN(request.getParameter("city")); 			// 'city' (도시) 파라미터 값을 가져옵니다.
	Connection conn = null; 												// 데이터베이스 연결을 위한 Connection 객체를 초기화합니다.
	Statement stmt = null; 													// SQL 문을 실행하기 위한 Statement 객체를 초기화합니다.
	String callback = ""; 													// 콜백 URL 또는 메시지 등을 저장할 변수를 초기화합니다.
	
	try {
	    conn = Util.getConnection(); 										// 데이터베이스 연결을 설정합니다.
	    stmt = conn.createStatement(); 										// SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
	    String sql = ""; 													// SQL 쿼리를 저장할 변수를 초기화합니다.
	    
	    switch(mode) { 														// 'mode' 파라미터에 따라 다른 작업을 수행합니다.
	    case "insert": 														// 'insert' 모드인 경우 회원 정보를 데이터베이스에 추가하는 SQL 쿼리를 생성합니다.
	        sql = "INSERT INTO member_tbl_02 VALUES("+ 
	                custno +", "+
	            "'"+custname+"', " + 
	            "'"+phone+"', " +
	            "'"+address+"', " + 
	            "TO_DATE('"+joindate+"', 'YYYY-MM-DD')," + 
	            "'" + grade + "' ," +
	            "'" + city+"')";
	        out.println(sql);												// 생성된 SQL 쿼리를 출력합니다.
	        stmt.executeUpdate(sql);										// SQL 쿼리를 실행합니다.
	        callback = "list_plus2.jsp";									// 작업이 완료된 후 리다이렉트될 페이지를 설정합니다.
	        break;
	        
	    case "modify":														// 'modify' 모드인 경우 회원 정보를 업데이트하는 SQL 쿼리를 생성합니다.
	        sql = "UPDATE member_tbl_02 SET "+ 
	            "custname='"+custname+"', " + 
	            "phone='"+phone+"', " +
	            "address='"+address+"', " + 
	            "joindate=TO_DATE('"+joindate+"', 'YYYY-MM-DD')," + 
	            "grade='" + grade + "' ,"+
	            "city='" + city+"' "+
	            "where custno="+custno;
	        out.println(sql);												// 생성된 SQL 쿼리를 출력합니다.
	        stmt.executeUpdate(sql);										// SQL 쿼리를 실행합니다.    
	        callback = "list_plus2.jsp";									// 작업이 완료된 후 리다이렉트될 페이지를 설정합니다.
	        break;
	        
	    case "delete":														// 'delete' 모드인 경우 삭제할 회원 번호를 가져옵니다.
	        String del_custno = Util.getParamNN(request.getParameter("del_custno"));
	        
	        sql = "DELETE FROM member_tbl_02 WHERE custno=" + del_custno;	// 회원 정보를 삭제하는 SQL 쿼리를 생성합니다.
	       // out.println(sql); 												// 생성된 SQL 쿼리를 출력합니다.
	        stmt.executeUpdate(sql); 										// SQL 쿼리를 실행합니다.
	        callback = "list_plus2.jsp"; 									// 작업이 완료된 후 리다이렉트될 페이지를 설정합니다.
	        break;
	    }
	} catch(Exception e) {
	    e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
	}
	response.sendRedirect(callback);										// 설정된 callback 페이지로 리다이렉션합니다.
%>