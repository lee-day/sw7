<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
<script>
	function validateForm(){
		var tb_test_name= document.getElementById('tb_test_name').value;
		var tb_test_sub_1= document.getElementById('tb_test_sub_1').value;
		var tb_test_sub_2= document.getElementById('tb_test_sub_2').value;
		var tb_test_sub_3= document.getElementById('tb_test_sub_3').value;
		var tb_test_sub_4= document.getElementById('tb_test_sub_4').value;

		if(tb_test_name==""){
			alert("문제가 입력되어있지 않습니다.");
			return false;
		}
		if(tb_test_sub_1=="" || tb_test_sub_2=="" || tb_test_sub_3=="" || tb_test_sub_4=="" ){
			alert("보기가 입력되어있지 않습니다.");
			return false;
		}
		alert("문제 등록이 완료되었습니다.");
		return true;
		
	}
</script>
</head>
<body>
<form name='form_test' action='test_ok.jsp' method='post' onsubmit="return validateForm()">
<input type='hidden' name='mode' value='insert' >
문제 등록하기
	<table border='1'>
		<tr>
			<td>문제</td>
			<td><input type='text' id="tb_test_name" name='tb_test_name'></td>
		</tr>
		<tr>
			<td>보기</td>
			<td>
				1.<input type='text' id='tb_test_sub_1' name='tb_test_sub_1'><input type='checkbox' name='dab_1' value="Yes"><br>
				2.<input type='text' id='tb_test_sub_2' name='tb_test_sub_2'><input type='checkbox' name='dab_2' value="Yes"><br>
				3.<input type='text' id='tb_test_sub_3' name='tb_test_sub_3'><input type='checkbox' name='dab_3' value="Yes"><br>
				4.<input type='text' id='tb_test_sub_4' name='tb_test_sub_4'><input type='checkbox' name='dab_4' value="Yes"><br>
			</td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><input type='file' name='image_link'></td>
		</tr>
		<tr>
			<td>흰트</td>
			<td><input type='text' name='hint'></td>
		</tr>
		<tr>
			<td>학습모듈</td>
			<td>
			<% 
				 	Connection conn=null;
				 	Statement stmt=null;
				 	String callback = ""; 	
				 	try{
				 		conn = Utill.getConnection(); 										// 데이터베이스 연결을 설정합니다.
					    stmt = conn.createStatement(); 										// SQL 명령어를 실행하기 위한 Statement 객체를 생성합니다.
					    String sql = ""; 	
						    	sql=" select"
						    			+" seq,"
						    			+" name"
						    		+ " from "
						    			+ " tb_ncs"
						    		+ " order by "
						    			+ "seq asc ";
						ResultSet rs = stmt.executeQuery(sql);
				%>
				<select name='tb_ncs'>
							<option value="">---------</option>
				<%
						while(rs.next()){
							String seq=rs.getString("seq");
							String name=rs.getString("name");
				%>
							<option value="<%=seq%>"><%=name%></option>
				<% 
						}
				 	}catch(Exception e) {
					    e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
					}
				%>			
				</select>
			</td>
		</tr>	
		<tr>
			<td colspan='2'>
				<input type='submit' value='등록하기'>
				<input type='button' value='되돌아가기'>
			</td>
		</tr>	
	</table>
</form>
</body>
</html>