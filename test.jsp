<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임형준</title>
</head>
<body>
<form method="post" action="Form2.jsp">
<input type="text" name="bookname">
<br><br>
<input type="radio" name="r" value="로맨스">로맨스
<input type="radio" name="r" value="액션">액션
<input type="radio" name="r" value="서사">서사
<input type="radio" name="r" value="역사">역사
<input type="radio" name="r" value="수필">수필
<br><br>
<input type="text" name="bookmade">
<br><br>
<input type="number" name="num">
<br><br>
<input type="checkbox" vlaue="책" name="ch">책
<input type="checkbox" value="이북" name="ch">이북
<input type="checkbox" value="usb" name="ch">USB
<br><br>
<select name="buy">
	<option>1</option>
	<option>2</option>
	<option>3</option>
	<option>4</option>
	<option>5</option>
</select>
<br><br>
<input type="submit" value="전송">
</form>
</body>
</html>