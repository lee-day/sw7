<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = (String) session.getAttribute("userId");
 	String mode=request.getParameter("mode");
 	String tb_test_name=request.getParameter("tb_test_name");
 	String tb_test_sub_1=request.getParameter("tb_test_sub_1");
 	String tb_test_sub_2=request.getParameter("tb_test_sub_2");
 	String tb_test_sub_3=request.getParameter("tb_test_sub_3");
 	String tb_test_sub_4=request.getParameter("tb_test_sub_4");
 	String dab_1=request.getParameter("dab_1");
 	String dab_2=request.getParameter("dab_2");
 	String dab_3=request.getParameter("dab_3");
 	String dab_4=request.getParameter("dab_4");	
 	String image_link=request.getParameter("image_link");	
 	String hint=request.getParameter("hint");	
 	String tb_ncs=request.getParameter("tb_ncs");
 	
 	out.println(tb_test_name+"<br>");
 	out.println(tb_test_sub_1+"<br>");
 	out.println(dab_1+"<br>");
 	out.println(image_link+"<br>");
 	out.println(hint+"<br>");
 	out.println(tb_ncs+"<br>");
 	
 	
 	Connection conn=null;
 	Statement stmt=null;
 	String callback = ""; 	
 	try{
 		conn = Utill.getConnection(); 										// 데이터베이스 연결을 설정합니다.
	    stmt = conn.createStatement(); 		// SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
	    String sql = ""; 	
	    String sql_count = ""; 
	    String seq_count_sub ="";
    	switch(mode){
    	case "insert":
    		sql_count=" select " 
    			+ 	"	NVL(max(seq)+1,1) as max_count"
    			+ " from"
    			+ 	"	tb_test ";
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
	    			+"'"+userId+ "')";
		    out.println(sql);	
		    //stmt.executeUpdate(sql);	
		    
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
	    			+"'"+tb_test_sub_1+"',"
	    			+"'"+dab_1+"')";
		    out.println(sql);	
		    //stmt.executeUpdate(sql);	
		    
		    //보기2
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
	    			+"'"+tb_test_sub_2+"',"
	    			+"'"+dab_2+"')";
		    out.println(sql);	
		    //stmt.executeUpdate(sql);	
		    
		    //보기3
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
	    			+"'"+tb_test_sub_3+"',"
	    			+"'"+dab_3+"')";
		    out.println(sql);	
		    //stmt.executeUpdate(sql);	
		    
		    
		    //보기4
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
	    			+"'"+tb_test_sub_4+"',"
	    			+"'"+dab_4+"')";
		    out.println(sql);	
		    //stmt.executeUpdate(sql);	
		    
		break;
    	}
}catch(Exception e) {
e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
}
	//response.sendRedirect("index.jsp");	
 	 
 	
 %>
 
 <!--  

 

 Create table tb_test(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
	image_link varchar2(255) NOT NULL,
	hint varchar2(255) NOT NULL,
	seq_tb_ncs number(5) NOT NULL,
	id_tb_member varchar2(20) NOT NULL,
 	constraint tb_test_pk Primary key(seq)
 );
 
 
 Create table tb_ncs(
 	seq number(5) NOT NULL,
 	name varchar2(255) NOT NULL,
 	file_link varchar2(255) NOT NULL,
  	constraint tb_ncs_pk Primary key(seq)
 );
 
  
CREATE TABLE tb_test_sub(
    seq number(5) NOT NULL,
    seq_tb_test number(5) NOT NULL,
    name varchar2(255) NOT NULL,
    dab varchar2(3) DEFAULT 'No'
);
ALTER TABLE tb_test_sub ADD CONSTRAINT tb_test_sub_pk PRIMARY KEY(seq);
ALTER TABLE tb_test_sub ADD CONSTRAINT dab_check CHECK (dab IN ('Yes', 'No'));
 
 -->
 
 