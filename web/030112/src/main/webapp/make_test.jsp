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
문제 등록하기
	<table border='1'>
		<tr>
			<td>문제</td>
			<td><input type='text' name='name'></td>
		</tr>
		<tr>
			<td>보기</td>
			<td>
				1.<input type='text' name='num_1'><input type='checkbox' name='num_pass' value="1"><br>
				2.<input type='text' name='num_2'><input type='checkbox' name='num_pass' value="2"><br>
				3.<input type='text' name='num_3'><input type='checkbox' name='num_pass' value="3"><br>
				4.<input type='text' name='num_4'><input type='checkbox' name='num_pass' value="4"><br>
			</td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><input type='file' name='img'></td>
		</tr>
		<tr>
			<td>흰트</td>
			<td><input type='text' name='hint'></td>
		</tr>
		<tr>
			<td>학습모듈</td>
			<td><select name='module'>
					<option value='1'>화면구현<option>
					<option value='2'>프로그램언어활용<option>
					<option value='3'>프로그램언어응용<option>
					<option value='4'>개발자환경구축<option>
					<option value='5'>애플리케이션배포<option>
					<option value='6'>응용SW기초기술활용<option>
					<option value='7'>SQL활용<option>
					<option value='8'>서버구축<option>
					<option value='9'><option>
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