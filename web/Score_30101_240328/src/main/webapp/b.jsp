<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="DBPKG.Utill" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
	table{
		margin: auto;
		margin-top: 40px;
	}
	h2{
		text-align:center;
	}
</style>


<script type="text/javascript">
	
	function check_form() {
		var stid = document.getElementById("stid").value;
		var sbj = document.getElementById("sbj").value;
		var mid = document.getElementById("mid").value;
		var fin = document.getElementById("fin").value;
		var att = document.getElementById("att").value;
		var rep = document.getElementById("rep").value;
		var etc = document.getElementById("etc").value;
		
		if(stid == ""){alert("학번이 입력되지 않았습니다.");return false;}
		if(sbj == ""){alert("곽목코드가 입력되지 않았습니다.");return false;}
		if(mid == ""){alert("중간 점수가 입력되지 않았습니다.");return false;}
		if(fin == ""){alert("기말 점수가 입력되지 않았습니다.");return false;}
		if(att == ""){alert("출석 점수가 입력되지 않았습니다.");return false;}
		if(rep == ""){alert("레포트 점수가 입력되지 않았습니다.");return false;}
		if(etc == ""){alert("기타 점수가 입력되지 않았습니다.");return false;}
		alert("등록되었습니다");
		return true;
	}
	
</script>

<h2>개인성적등록</h2>
<form name="form1" action="resu.jsp" onsubmit="return check_form()">
<table border="">
	<tr>
		<th>학번</th>
		<td><input type="text" name="stid"  id="stid" size="20"></td>
	</tr>
	<tr>
		<th>과목코드</th>
		<td><input type="text" name="sbj" id="sbj" size="20"></td>
	</tr>
	<tr>
		<th> 중간(30%)(0~100) </th>
		<td><input type="text" name="mid" id="mid" size="20">점</td>
	</tr>
	<tr>
		<th> 기말(30%)(0~100) </th>
		<td><input type="text" name="fin" id="fin" size="20">점</td>
	</tr>
	<tr>
		<th> 출석(20%)(0~100) </th>
		<td><input type="text" name="att" id="att" size="20">점</td>
	</tr>
	<tr>
		<th> 레포트(10%)(0~100) </th>
		<td><input type="text" name="rep" id="rep" size="20">점</td>
	</tr>
	<tr>
		<th> 기타(10%)(0~100) </th>
		<td><input type="text" name="etc" id="etc" size="20">점</td>
	</tr>
	<tr>
		<th colspan="2"><button>등록</button> 
		<button type="reset">다시쓰기</button></th>
	</tr>
</table>
</form>


</body>
</html>