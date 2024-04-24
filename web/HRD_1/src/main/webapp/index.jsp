<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 		<!-- JSP 페이지 설정: Java 언어 사용, 문서 타입은 text/html, 문자 인코딩 UTF-8 -->

<!DOCTYPE html> 																			<!-- HTML5 문서 유형 선언 -->
<html>
<head>
	<link rel="stylesheet" type="text/css" href="style.css"> 								<!-- 외부 CSS 파일 링크 -->
	<meta charset="UTF-8"> 																	<!-- 문자 인코딩을 UTF-8로 설정 -->
	<title>쇼핑몰 회원관리 30100 홍길동</title> 														<!-- 웹 페이지 제목 설정 -->
</head>
<body>

	<header><h2>쇼핑몰 회원관리 30100 홍길동</h2></header> 											<!-- 헤더 부분: 페이지 제목을 h2 태그로 표시 -->

	<nav>
		<ul> 																				<!-- 순서가 없는 목록 사용 -->
			<li><a href="insert.jsp" target="section_page">회원등록</a></li> 					<!-- 내비게이션 링크: 회원 등록 페이지로 이동 -->
			<li><a href="list_plus2.jsp" target="section_page">회원목록조회/수정</a></li> 		<!-- 내비게이션 링크: 회원 목록 조회 및 수정 페이지로 이동 -->
			<li><a href="search_plus2.jsp" target="section_page">회원매출조회</a></li> 			<!-- 내비게이션 링크: 회원 매출 조회 페이지로 이동 -->
			<li><a href="main.jsp" target="section_page" class="nav_home_a">홈으로</a></li> 	<!-- 내비게이션 링크: 홈으로 이동 -->
		</ul>
	</nav>

	<section>
		<IFRAME NAME="section_page" SRC='main.jsp'></IFRAME> 								<!-- iframe으로 다른 페이지를 보여주는 섹션, 기본으로 main.jsp 페이지 표시 -->
	</section>

	<footer>																				<!-- 푸터 부분: 저작권 정보 표시 -->
		<h3>HRDKOREA Copyright@2016 All right reserved Human Resources Development Service of Korea.</h3>
	</footer>

</body>
</html>
