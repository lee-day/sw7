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
		var id= document.getElementById('id').value;
		var pass= document.getElementById('pass').value;
		var name= document.getElementById('name').value;
		var num= document.getElementById('num').value;
		if(id==""){
			alert("회원 아이디가 입력되어있지 않습니다.");
			return false;
		}
		if(pass==""){
			alert("회원 비밀번호가 입력되어있지 않습니다.");
			return false;
		}
		if(name==""){
			alert("회원 이름이 입력되어있지 않습니다.");
			return false;
		}
		if(num==""){
			alert("회원 기수가 입력되어있지 않습니다.");
			return false;
		}
		alert("회원가입이 완료되었습니다.");
		return true;
		
	}
</script>
</head>
<body>
회원가입
<form name='form_join' action='join_ok.jsp' method='get' onsubmit="return validateForm()">
<input type='hidden' name='mode' value='insert' >
	<table border='1'>
		<tr>
			<td>아이디</td>
			<td><input type='text' id='id' name='id'></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type='password' id='pass' name='pass'></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type='text' id='name' name='name'></td>
		</tr>
		<tr>
			<td>기수</td>
			<td><select name='num' id='num'>
					<option value='1'>1기</option>
					<option value='2'>2기</option>
					<option value='3'>3기</option>
					<option value='4'>4기</option>
					<option value='5'>5기</option>
					<option value='6'>6기</option>
					<option value='7' selected>7기</option>
				</select>
			</td>
		</tr>	
		<tr>
			<td colspan='2'>
				<input type='submit' value='가입하기'>
				<input type='button' value='되돌아가기'>
			</td>
		</tr>	
	</table>
</form>
</body>
</html>