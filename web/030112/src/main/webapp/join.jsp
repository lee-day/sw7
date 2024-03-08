<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
회원가입
	<table border='1'>
		<tr>
			<td>아이디</td>
			<td><input type='text' name='id'></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type='password' name='pass'></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type='text' name='name'></td>
		</tr>
		<tr>
			<td>기수</td>
			<td><select name='num'>
					<option value='1'>1기<option>
					<option value='2'>2기<option>
					<option value='3'>3기<option>
					<option value='4'>4기<option>
					<option value='5'>5기<option>
					<option value='6'>6기<option>
					<option value='7' selected>7기<option>
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
</body>
</html>