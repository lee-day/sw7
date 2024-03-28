<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>과정평가형 필기 문제은행</title>
<link rel="stylesheet" type="text/css" href="style.css">

<script>
document.getElementById('section_page').addEventListener('load', function() {
    var iframe = document.getElementById('section_page');
    try {
        var body = iframe.contentWindow.document.body;
        var html = iframe.contentWindow.document.documentElement;
        var height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight);
        iframe.style.height = height + 'px';
    } catch (e) {
        console.log('Cannot resize iframe: ', e);
    }
});
</script>

</head>
<body>
<header>
<form name='form_login' action='login_ok.jsp' method='post'>
	<h2>과정평가형 필기 문제은행</h2>
<% if (session != null && session.getAttribute("userName") != null) {
	// 세션에서 사용자 이름을 가져옵니다.
    String userName = (String) session.getAttribute("userName");
    String userId = (String) session.getAttribute("userId");
    // 환영 메시지를 표시합니다.
    out.println(userName + "님, 환영합니다.");
%>
	<a href="member_list.jsp" target="section_page">[회원정보]</a>    
	<input type='hidden' name='mode' value='logout'>
	<input type='hidden' name='id' size='<%=userId%>'>
	<input type='submit' value='로그아웃'>
<% }else{ %>	
	<input type='text' name='id' size='5'>
	<input type='text' name='pass' size='5'>
	<input type='hidden' name='mode' value='login'>
	<input type='submit' value='로그인'>
	<a href="join.jsp" target="section_page">[회원가입]</a>
<%} %>	
	
	
</form>
</header>
<nav>
	<a href="do_test.jsp" target="section_page">문제풀기</a>
<% if (session != null && session.getAttribute("userName") != null) {%>
	<a href="make_test.jsp" target="section_page">문제등록하기</a>
<%} %>	
	<a href="point_test.jsp" target="section_page">점수관리</a>
	<a href="main.jsp" target="section_page">홈으로</a>
</nav>
<section>
	<iframe name="section_page" id="section_page" src="main.jsp"></iframe>
</section>
<footer>
	세명컴고
</footer>
</body>
</html>