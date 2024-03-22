<%
    String data = request.getParameter("data");
    // 부모 페이지로 데이터를 전달하는 스크립트 생성
    String script = "<script>parent.receiveDataFromChild('" + data + "');</script>";
    out.println(script);
%>
