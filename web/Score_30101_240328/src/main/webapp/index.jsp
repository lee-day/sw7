<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
*{
	margin: 0;
	padding: 0;
}

header{
	background: rgb(100,100,250);
	height: 100px;
	text-align: center;
	text-size: 20px;
	line-height: 100px;
}

nav{
	background: rgb(100,100,150);
	height: 60px;
	line-height:30px;
}

nav ul li {
	display: inline-block;
	margin: 10px;
}
a{
	text-decoration: none;
	color: inherit;
}

section{
	background: rgb(240,240,240);
	height: 400px;
}
iframe{
	width: 100%;
	height: 100%;
	border: none;
}
footer{
	background: navy;
	height: 60px;
	color: white;
	text-align:center;
	line-height:60px;
}


</style>
</head>
<body>
<header>과정평가형 정보처리산업기사 성적관리 프로그램 ver 2022-05</header>
<nav>
	<ul>
		<li><a href="/Score_30101_240328/a.jsp" target="section_frame">전체성적조회</a></li>
		<li><a href="/Score_30101_240328/b.jsp" target="section_frame">개인성적등록</a></li>
		<li><a href="/Score_30101_240328/c.jsp" target="section_frame">개인별성적통계</a></li>
		<li><a href="/Score_30101_240328/main.jsp" target="section_frame"><u>홈으로</u> </a></li>
	</ul>
</nav>

<section>
<iframe name="section_frame" src="/Score_30101_240328/main.jsp"></iframe>
</section>

<footer> HRDKOREA Copyright &copy;2022 All rights reserved. Human Resources Development Service of Korea </footer>


</body>
</html>