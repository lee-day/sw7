<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String) session.getAttribute("userId");
 	String mode=request.getParameter("mode");
 	out.println(mode);
 	try{
 		Connection conn=null;
	 	Statement stmt=null;
	 	String callback = "";
 		conn = Utill.getConnection(); 										// 데이터베이스 연결을 설정합니다.
	    stmt = conn.createStatement(); 		// SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
	    String sql = ""; 	
	    String sql_count = ""; 
	    String seq_count_sub ="";
	    String seq_count_sub_link="";
	    out.println(mode);
    	switch(mode){
    	case "insert":
    	 	String tb_test_name=request.getParameter("tb_test_name");
    	 	String image_link=request.getParameter("image_link");	
    	 	String hint=request.getParameter("hint");	
    	 	String tb_ncs=request.getParameter("tb_ncs");
    	 	String questionType=request.getParameter("questionType");
    	 	String bogi=request.getParameter("bogi");
    	 	String image_data="";
    	 	 

    		sql_count=" select " 
    			+ 	"	NVL(max(seq)+1,1) as max_count"
    			+ " from"
    			+ 	"	tb_test ";
    		out.println(sql_count);
    		ResultSet rs_count = stmt.executeQuery(sql_count);
    		rs_count.next();
    		String seq_count = rs_count.getString("max_count");
    		out.println(seq_count);

    		sql=" insert into tb_test values("
	    			+"'"+seq_count+"',"
	    			+"'"+tb_test_name+"',"
	    			+"'"+image_link+"',"
	    			+"'"+hint+"',"
	    			+"'"+tb_ncs+"',"
	    			+"'"+userId+"',"
	    	    	+"'"+questionType+"',"
	    	    	+"'"+bogi+ "','2')";
    		out.println(sql);
	    	stmt.executeUpdate(sql);
		    if("1".equals(questionType)){		    		
		        // 보기와 답변 처리를 위한 반복문
		        for(int i = 1; i <= 4; i++){
		            String tb_test_sub = request.getParameter("tb_test_sub_" + i);
		            String dab = request.getParameter("dab_" + i);
		            dab = (dab == null || dab.isEmpty()) ? "No" : "Yes"; // 답변 여부 초기화

		            // seq_count_sub 값 조회
		            sql_count=" select " 
			    			+ 	"	NVL(max(seq)+1,1) as max_count"
			    			+   " from"
			    			+ 	"	tb_test_sub ";
	    			rs_count = stmt.executeQuery(sql_count);
		            if(rs_count.next()){
		                seq_count_sub = rs_count.getString("max_count");
		                // 보기와 답변을 tb_test_sub 테이블에 삽입
		                sql=" insert into tb_test_sub values("
		    			+"'"+seq_count_sub+"',"
		    			+"'"+seq_count+"',"
		    			+"'"+dab+"',"
				    	+"'','',"
				    	+"'"+tb_test_sub+"')";
		                out.println(sql);	
					    stmt.executeUpdate(sql);
		            }
		        }
		    }else if("2".equals(questionType)){
			    String trueFalseAnswer=request.getParameter("trueFalseAnswer");	
			    //보기1
			    sql_count=" select " 
	    			+ 	"	NVL(max(seq)+1,1) as max_count"
	    			+ " from"
	    			+ 	"	tb_test_sub ";
	    		rs_count = stmt.executeQuery(sql_count);
	    		rs_count.next();
	    		seq_count_sub = rs_count.getString("max_count");
			    sql=" insert into tb_test_sub values("
		    			+"'"+seq_count_sub+"',"
		    			+"'"+seq_count+"',"
		    			+"'"+trueFalseAnswer+"',"
		    			+"'','',"
						+"'진위형 문제')";
			    out.println(sql);	
			    stmt.executeUpdate(sql);
		    }else if("3".equals(questionType)){
			    String shortAnswer=request.getParameter("shortAnswer");	
			    //보기1
			    sql_count=" select " 
	    			+ 	"	NVL(max(seq)+1,1) as max_count"
	    			+ " from"
	    			+ 	"	tb_test_sub ";
	    		rs_count = stmt.executeQuery(sql_count);
	    		rs_count.next();
	    		seq_count_sub = rs_count.getString("max_count");
			    sql=" insert into tb_test_sub values("
		    			+"'"+seq_count_sub+"',"
		    			+"'"+seq_count+"',"
		    			+"'',"
		    			+"'','',"
						+"'"+shortAnswer+"')";
			    out.println(sql);	
			    stmt.executeUpdate(sql);	
		    }else if("4".equals(questionType)){	
		     // 보기와 답변 처리를 위한 반복문	
		        for(int i = 1; i <= 4; i++){
		            String tb_test_link_str = request.getParameter("tb_test_link_str_" + i);
		            String tb_test_link_end = request.getParameter("tb_test_link_end_" + i);
		            // seq_count_sub 값 조회
		            sql_count=" select " 
			    			+ 	"	NVL(max(seq)+1,1) as max_count"
			    			+   " from"
			    			+ 	"	tb_test_sub ";
	    			rs_count = stmt.executeQuery(sql_count);
		            if(rs_count.next()){
		                seq_count_sub = rs_count.getString("max_count");
		                // 보기와 답변을 tb_test_sub 테이블에 삽입
		                sql=" insert into tb_test_sub values("
				    			+"'"+seq_count_sub+"',"
				    			+"'"+seq_count+"',"
				    			+"'Yes',"
				    			+"'','',"
								+"'"+tb_test_link_str+"')";
		                out.println(sql);	
					    stmt.executeUpdate(sql);
		            }
		           
		            sql_count=" select " 
			    			+ 	"	NVL(max(seq)+1,1) as max_count"
			    			+   " from"
			    			+ 	"	tb_test_sub ";
	    			rs_count = stmt.executeQuery(sql_count);
	    			if(rs_count.next()){
	    				seq_count_sub_link = rs_count.getString("max_count");
					    sql=" insert into tb_test_sub values("
				    			+"'"+seq_count_sub_link+"',"
				    			+"'"+seq_count+"',"
				    			+"'No',"
						    	+"'"+seq_count_sub+"','',"
								+"'"+tb_test_link_end+"')";
		                out.println(sql);	
					    stmt.executeUpdate(sql);
		            }
	    			
		        }
		    }

		break;
    	case "delete":  
    		String seq=request.getParameter("seq");
		    sql=" delete from tb_test where"
	    			+" seq='"+seq+"'";
            out.println(sql);	
		    stmt.executeUpdate(sql);
		    sql=" delete from tb_test_sub where"
	    			+" seq_tb_test='"+seq+"'";
            out.println(sql);	
		    stmt.executeUpdate(sql);
    		
    	break;	
    	}
}catch(Exception e) {
e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
}
response.sendRedirect("main.jsp");	
 	 
 	
 %>
 
 