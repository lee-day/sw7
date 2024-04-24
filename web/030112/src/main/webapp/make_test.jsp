<%@ page import="java.sql.*" %>
<%@ page import="DBPKG.Utill"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <% 
  	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql=null;
	String seq=null;
	PreparedStatement pstmt = null;
	int questionType= 0;
	conn = Utill.getConnection();
	stmt = conn.createStatement();
	//out.println(request.getParameter("mode"));
	String tb_test_name = "";
	String bogi = "";
	String seq_tb_ncs = ""; 
	String image_link = ""; 
	String hint= ""; 
	String tb_test_sub[]= {"","","","",""};
	String tb_test_sub_seq[]= {"","","","",""};
	String tb_test_sub_seq_end[]= {"","","","",""};
	String tb_test_sub_dab[]= {"No","No","No","No","No"};
	String tb_test_link_str[]= {"","","","",""};
	String tb_test_link_end[]= {"","","","",""};
	String mode = "insert";
	String truefalsesave="No";
	String shortanswer="";
	//out.println("kkkkk");
  	if("update".equals(request.getParameter("mode"))){
		mode = "update";
		seq = request.getParameter("seq"); 	
		ResultSet rs_link = null;
		PreparedStatement pstmt_link = null;
		String prevSeq = ""; // 이전 문제의 seq 값을 저장하기 위한 변수
		String userName = (String) session.getAttribute("userName");
		String userId = (String) session.getAttribute("userId"); 		
       try {
           conn = Utill.getConnection(); // 데이터베이스 연결을 설정합니다.
           sql = "SELECT tb_test.seq AS seq, " +
                        "tb_member.name as 출제자, " +
                        "tb_member.id as 출제자id, " +
                        "tb_test.name AS 문제, " +
                        "tb_test.image_link AS 이미지, " +
                        "tb_test.hint AS 힌트, " +
                        "tb_test_sub.seq AS tb_test_sub_seq, " +
                        "tb_test_sub.name AS 보기, " +
                        "tb_test_sub.dab AS 정답여부, " +                      
                        "tb_test_sub.SEQ_TB_TEST_SUB AS 연결형답, " +
                        "tb_test.questionType AS 문제형태, " +
                        "tb_test.bogi AS 문제보기, " +
                        "tb_test_sub.image_link AS 보기_이미지, " +
                        "tb_ncs.name AS 학습모듈, " +
                        "tb_test.seq_tb_ncs AS seq_tb_ncs " +
                        "FROM tb_test " +
                        "LEFT JOIN tb_test_sub ON tb_test.seq = tb_test_sub.seq_tb_test " +
                        "LEFT JOIN tb_member ON tb_test.id_tb_member = tb_member.id " +
                        "LEFT JOIN tb_ncs ON tb_test.seq_tb_ncs = tb_ncs.seq " +
                        "WHERE tb_test_sub.SEQ_TB_TEST_SUB IS NULL " +
                        "and tb_test.type =2 " +
                        "and tb_test.id_tb_member='" + userId +"' "+
                        "and tb_test.seq='" + seq +"' ";
           pstmt = conn.prepareStatement(sql);
           rs = pstmt.executeQuery();
         	//out.println(sql);
           int count_number=1;
           int test_number=0;
           while(rs.next()) {
        	   // out.println("ggggg");
	           questionType=rs.getInt("문제형태");
	           tb_test_name=rs.getString("문제");
        	   bogi=rs.getString("문제보기");
        	   seq_tb_ncs=rs.getString("seq_tb_ncs");
        	   image_link=rs.getString("이미지");
        	   hint=rs.getString("힌트");   
	           if(questionType==1){	        	  
	        	   tb_test_sub[count_number]=rs.getString("보기");
	        	   tb_test_sub_dab[count_number]=rs.getString("정답여부");
	        	   tb_test_sub_seq[count_number]=rs.getString("tb_test_sub_seq");
	        	   count_number=count_number+1;
	           }else if(questionType==2){	        	
	        	   truefalsesave=rs.getString("정답여부");
	        	   //out.println(truefalsesave);
	           }else if(questionType==3){	        	
	        	   shortanswer=rs.getString("보기");
	        	   //out.println(truefalsesave);
	           }else if(questionType==4){	        	
	        	   tb_test_sub[count_number]=rs.getString("보기");
	        	   if(("Yes".equals(rs.getString("정답여부")))){	
	        		   tb_test_sub_seq[count_number]=rs.getString("tb_test_sub_seq");
	        		   tb_test_link_str[count_number]=rs.getString("보기");
	        	   }else{
	        		   tb_test_sub_seq_end[count_number]=rs.getString("tb_test_sub_seq");   
	        		   tb_test_link_end[count_number]=rs.getString("보기");
	        		   //잊지마 기억해야되 넌 지금 연결형에서 보기와 보기정답을 연결하기위한 정렬을 하고있었어. 연결을 시켜서 보기당 하나의 정답만 뜨게 해야해 
	        	   }
	        	   count_number=count_number+1;
	           }	      
           }
         }catch(Exception e) {
			    e.printStackTrace();												// 예외가 발생하면 스택 트레이스를 출력합니다.
		 }
  	}else{		
  	}
%>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="style.css">
<script>
	//부모 창에서 자식 창으로부터 데이터를 받는 함수
	function receiveDataFromChild(event) {
	    // 받은 데이터를 부모 창의 입력 필드에 설정
	    document.getElementById("image_link").value = event.data;
	}
	
	// 자식 창으로부터 데이터를 받는 이벤트 리스너 등록
	window.addEventListener("message", receiveDataFromChild, false);
	
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
	
    function openBPage() {
        // B 페이지를 새 창으로 열기
        window.open("b.html", "_blank", "width=600,height=400");
    }

    // 부모 창에서 자식 창으로 데이터를 받는 함수
    function receiveDataFromChild(data) {
        // 받은 데이터를 입력 필드에 표시
        document.getElementById("image_link").value = data;
    }	

</script>
</head>
<body>
<form name='form_test' action='test_ok.jsp' method='post' onsubmit="return validateForm()" >
<input type='hidden' name='mode' value='<%=mode %>' >
<input type='hidden' name='seq' value='<%=seq%>' >
문제 등록하기
	<table border='1'>
		<tr>
			<td>문제 유형</td>
			<td>
				<select id="questionType" name="questionType" onchange="updateFormFields()">
					<option value="1" <% if(questionType==1){out.println("selected");}%>>4지 선다형</option>
					<option value="2" <% if(questionType==2){out.println("selected");}%>>진위형(ox)</option>
					<option value="3" <% if(questionType==3){out.println("selected");}%>>주관식</option>
					<option value="4" <% if(questionType==4){out.println("selected");}%>>연결형</option>
				</select>
			</td>
		</tr>
		<tr>
				<td>문제</td>
				<td><input type='text' id="tb_test_name" name='tb_test_name' size='100' value='<%= tb_test_name %>'></td>
		</tr>
		<tr>
			<td>이미지</td>
			<td><input type="text" id="image_link" name="image_link" value='<%=image_link%>'readonly>
			<a href="javascript:void(0)" onclick="openBPage()">이미지 등록하기</a>
			</td>
		</tr>
		<tr>
			<td>[보기]</td>
			<td><input type="text" id="bogi" name="bogi" size='100'  value='<%= bogi %>'>
			</td>
		</tr>
		<tr>
				<td colspan='2'>
				<table>
		<!-- 4지 선다형 입력 필드 -->
		<tbody id="multipleChoiceFields">

			<tr>
				<td>보기</td>
				<td>
				1.<input type='text' id='tb_test_sub_1' name='tb_test_sub_1' size='80' value='<%= tb_test_sub[1] %>'>
				<input type='checkbox' name='dab_1' value="Yes" <% if("Yes".equals(tb_test_sub_dab[1])){out.println("checked");}%>><br>
				2.<input type='text' id='tb_test_sub_2' name='tb_test_sub_2' size='80' value='<%= tb_test_sub[2] %>'>
				<input type='checkbox' name='dab_2' value="Yes" <% if("Yes".equals(tb_test_sub_dab[2])){out.println("checked");}%>><br>
				3.<input type='text' id='tb_test_sub_3' name='tb_test_sub_3' size='80' value='<%= tb_test_sub[3] %>'>
				<input type='checkbox' name='dab_3' value="Yes" <% if("Yes".equals(tb_test_sub_dab[3])){out.println("checked");}%>><br>
				4.<input type='text' id='tb_test_sub_4' name='tb_test_sub_4' size='80' value='<%= tb_test_sub[4] %>'>
				<input type='checkbox' name='dab_4' value="Yes" <% if("Yes".equals(tb_test_sub_dab[4])){out.println("checked");}%>><br>
				<input type='hidden' name='tb_test_sub_seq_1' value='<%=tb_test_sub_seq[1]%>' >
				<input type='hidden' name='tb_test_sub_seq_2' value='<%=tb_test_sub_seq[2]%>' >
				<input type='hidden' name='tb_test_sub_seq_3' value='<%=tb_test_sub_seq[3]%>' >
				<input type='hidden' name='tb_test_sub_seq_4' value='<%=tb_test_sub_seq[4]%>' >
			</td>
		</tr>
		</tbody>
		<!-- 진위형(ox) 입력 필드 -->
		<tbody id="trueFalseFields" style="display:none;">
			<tr>
				<td>정답</td>
				<td>
					<label><input type='radio' name='trueFalseAnswer' value="Yes"<% if("Yes".equals(truefalsesave)){out.println("checked");}%>>O</label>
					<label><input type='radio' name='trueFalseAnswer' value="No"<% if("No".equals(truefalsesave)){out.println("checked");}%>>X</label>
				</td>
			</tr>
		</tbody>
		<!-- 주관식 입력 필드 -->
		<tbody id="shortAnswerFields" style="display:none;">
			<tr>
				<td>핵심단어</td>
				<td>답:<input type='text' name='shortAnswer' size='80' value='<%= shortanswer %>'><br>
				1. 핵심단어가 1개인 경우 단일 입력 ex) 응용프로그램<br>
				2. 핵심단어가 2개 이상이고 모두 포함되어야 하는 경우 and 입력 ex) 응용프로그램 and 어플리케이션배포 and 과정평가<br>
				3. 핵심단어가 2개 이상이고 어느 한가지만 포함되도 되는 경우 or 입력 ex) 응용프로그램 or 어플리케이션배포 or 과정평가<br>
				4. 핵심단어가 2개 이상이고 모두 포함되어야 하는 단어와 어느 한가지만 포함되도 되는 단어가 복수로 있는 경우<br>
				 or  and () 입력 ex) (응용프로그램 or 어플리케이션배포) and 과정평가</td>
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
			<td><input type='text' name='hint' value=<%=hint %>></td>
		</tr>
		<tr>
			<td>학습모듈</td>
			<td>
			<% 
				 	String callback = ""; 	
				 	try{
				 		sql = ""; 	
						    	sql=" select"
						    			+" seq,"
						    			+" name"
						    		+ " from "
						    			+ " tb_ncs"
						    		+ " order by "
						    			+ "seq asc ";
						rs = stmt.executeQuery(sql);
				%>
				<select name='tb_ncs'>
							<option value="">---------</option>
				<%
						while(rs.next()){
							seq=rs.getString("seq");
							String name=rs.getString("name");
				%>
							<option value="<%=seq%>" <%  if(seq.equals(seq_tb_ncs)){  out.println("selected"); }%>><%=name%></option>
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