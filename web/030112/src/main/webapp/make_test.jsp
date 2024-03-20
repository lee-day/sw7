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
		var questionType = document.getElementById('questionType').value;
		var tb_test_name= document.getElementById('tb_test_name').value;
		if(tb_test_name==""){
			alert("문제가 입력되어있지 않습니다.");
			return false;
		}
		if(questionType=='1'){
			var tb_test_sub_1= document.getElementById('tb_test_sub_1').value;
			var tb_test_sub_2= document.getElementById('tb_test_sub_2').value;
			var tb_test_sub_3= document.getElementById('tb_test_sub_3').value;
			var tb_test_sub_4= document.getElementById('tb_test_sub_4').value;
			if(tb_test_sub_1=="" || tb_test_sub_2=="" || tb_test_sub_3=="" || tb_test_sub_4=="" ){
				alert("보기가 입력되어있지 않습니다.");
				return false;
			}
		}else if(questionType=='2'){
		    var trueFalseAnswerSelected = document.querySelector('input[name="trueFalseAnswer"]:checked');
		    if (!trueFalseAnswerSelected) {
		        alert("o또는 x가 선택되지 않았습니다.");
		        return false;
		    }
		}else if(questionType=='3'){
			var shortAnswer= document.getElementById('shortAnswer').value;
			if(shortAnswer==""){
				alert("핵심 단어가 입력되지 않았습니다.");
				return false;
			}
		}
		alert("문제 등록이 완료되었습니다.");
		return true;
		
	}
	function updateFormFields() {
	    var questionType = document.getElementById('questionType').value;
	    var multipleChoiceFields = document.getElementById('multipleChoiceFields');
	    var trueFalseFields = document.getElementById('trueFalseFields');
	    var shortAnswerFields = document.getElementById('shortAnswerFields');
	    var linkAnswerFields = document.getElementById('linkAnswerFields');
	    var linkCountRow = document.getElementById('linkCountRow'); // 연결가능 수 선택 <tr>에 대한 참조

	    // 모든 입력 필드를 숨깁니다.
	    multipleChoiceFields.style.display = 'none';
	    trueFalseFields.style.display = 'none';
	    shortAnswerFields.style.display = 'none';
	    linkAnswerFields.style.display = 'none';
	    linkCountRow.style.display = 'none'; // 연결 가능 수 선택 옵션을 숨깁니다.

	    // 선택된 문제 유형에 따라 해당 입력 필드를 표시합니다.
	    if (questionType === '1') {
	        multipleChoiceFields.style.display = 'block';
	    } else if (questionType === '2') {
	        trueFalseFields.style.display = 'block';
	    } else if (questionType === '3') {
	        shortAnswerFields.style.display = 'block';
	    } else if (questionType === '4') {
	        linkAnswerFields.style.display = 'block';
	        linkCountRow.style.display = 'table-row'; // "연결형"이 선택되었을 때만 연결 가능 수 선택 옵션을 보이게 합니다.
	        updateLinkAnswerFields(); // 연결형 문제 입력 필드 업데이트
	    }
	}

	function updateLinkAnswerFields() {
	    var linkCount = document.getElementById('linkCount').value; // 연결 가능 수를 가져옵니다.
	    // 1에서 4까지의 모든 연결형 입력 필드를 숨깁니다.
	    for (var i = 1; i <= 4; i++) {
	        document.getElementById('linkField_' + i).style.display = 'none';
	    }
	    // 선택된 연결 가능 수에 따라 해당 입력 필드를 보여줍니다.
	    for (var i = 1; i <= linkCount; i++) {
	        document.getElementById('linkField_' + i).style.display = 'block';
	    }
	}

	window.onload = function() {
	    updateFormFields(); // 페이지 로딩 시 입력 필드 업데이트
	}
</script>
</head>
<body>
<form name='form_test' action='test_ok.jsp' method='post' onsubmit="return validateForm()" >
<input type='hidden' name='mode' value='insert' >
문제 등록하기
	<table border='1'>
		<tr>
			<td>문제 유형</td>
			<td>
				<select id="questionType" name="questionType" onchange="updateFormFields()">
					<option value="1">4지 선다형</option>
					<option value="2">진위형(ox)</option>
					<option value="3">주관식</option>
					<option value="4">연결형</option>
				</select>
			</td>
		</tr>
		<tr>
				<td>문제</td>
				<td><input type='text' id="tb_test_name" name='tb_test_name' size='100'></td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><input type='file' name='image_link' enctype="multipart/form-data"></td>
		</tr>
		<tr>
				<td colspan='2'>
				<table>
		<!-- 4지 선다형 입력 필드 -->
		<tbody id="multipleChoiceFields">
			<tr>
				<td>보기</td>
				<td>
				1.<input type='text' id='tb_test_sub_1' name='tb_test_sub_1' size='80'><input type='checkbox' name='dab_1' value="Yes"><br>
				2.<input type='text' id='tb_test_sub_2' name='tb_test_sub_2' size='80'><input type='checkbox' name='dab_2' value="Yes"><br>
				3.<input type='text' id='tb_test_sub_3' name='tb_test_sub_3' size='80'><input type='checkbox' name='dab_3' value="Yes"><br>
				4.<input type='text' id='tb_test_sub_4' name='tb_test_sub_4' size='80'><input type='checkbox' name='dab_4' value="Yes"><br>
			</td>
		</tr>
		</tbody>
		<!-- 진위형(ox) 입력 필드 -->
		<tbody id="trueFalseFields" style="display:none;">
			<tr>
				<td>정답</td>
				<td>
					<label><input type='radio' name='trueFalseAnswer' value="Yes">O</label>
					<label><input type='radio' name='trueFalseAnswer' value="No">X</label>
				</td>
			</tr>
		</tbody>
		<!-- 주관식 입력 필드 -->
		<tbody id="shortAnswerFields" style="display:none;">
			<tr>
				<td>핵심단어</td>
				<td><input type='text' name='shortAnswer' size='80'></td>
			</tr>
		</tbody>
		<!-- 연결형 입력 필드 -->
		<tbody id="linkAnswerFields" style="display:none;">
			<tr id="linkCountRow" style="display:none;">
				<td>연결가능 수</td>
				<td>
				<select id="linkCount" onchange="updateLinkAnswerFields()">
				    <option value="1">1</option>
				    <option value="2">2</option>
				    <option value="3">3</option>
				    <option value="4">4</option>
				</select>
				</td>
			</tr>
			<tr id="linkField_1" style="display:none;">
				    <td>1</td>
				    <td>보기<input type='text' name='tb_test_link_str_1' size='10'>답<input type='text' name='tb_test_link_end_1' size='10'></td>
			</tr>
			<tr id="linkField_2" style="display:none;">
				    <td>2</td>
				    <td>보기<input type='text' name='tb_test_link_str_2' size='10'>답<input type='text' name='tb_test_link_end_2' size='10'></td>
			</tr>
			<tr id="linkField_3" style="display:none;">
				    <td>3</td>
				    <td>보기<input type='text' name='tb_test_link_str_3' size='10'>답<input type='text' name='tb_test_link_end_3' size='10'></td>
			</tr>
			<tr id="linkField_4" style="display:none;">
				    <td>4</td>
				    <td>보기<input type='text' name='tb_test_link_str_4' size='10'>답<input type='text' name='tb_test_link_end_4' size='10'></td>
			</tr>
		</tbody>
		<!-- 공통 입력 필드 (예: 이미지, 힌트 등) -->
		</table>
		</td>
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