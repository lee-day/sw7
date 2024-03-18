<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
 	String id=request.getParameter("id");
 	String mode=request.getParameter("mode");
 	Connection conn=null;
 	Statement stmt=null;
 	String callback = ""; 	
 	try{
 		conn = Utill.getConnection(); 										// 데이터베이스 연결을 설정합니다.
	    stmt = conn.createStatement(); 		// SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
	    String sql = ""; 	
    	switch(mode){
    	case "login":
		 	String pass=request.getParameter("pass");
		    sql=" select"
	    			+" id,"
	    			+" pass,"
	    			+" name,"
	    			+" num"
	    		+ " from "
	    			+ " tb_member"
	    		+ " where "
	    			+ " id='"+id+"'"
	    			
	    			+ "and pass='"+pass+"'";
				ResultSet rs = stmt.executeQuery(sql);
				out.println(sql);
			
				if(rs.next()){
					out.println(rs.getString("name"));
					out.println("님 로그인이 되었습니다.");
					String name = rs.getString("name");
					// 세션에 사용자 정보를 저장합니다.
				    session.setAttribute("userId", id); // 사용자 ID 저장
				    session.setAttribute("userName", name); // 사용자 이름 저장
				    // 로그인 성공 페이지로 리다이렉트 또는 성공 메시지 출력 등의 로직을 추가합니다.
				}else{
					out.println("아이디나 패스워드가 일치하지 않거나 없습니다.");
				} 
			break;
    		case "logout":
    			// 세션을 무효화합니다. 이로써 세션에 저장된 모든 데이터가 삭제됩니다.
    			session.invalidate();
    		break;
    		}
}catch(Exception e) {
e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
}
	
 	response.sendRedirect("index.jsp");	
 	 
 	
 %>
 