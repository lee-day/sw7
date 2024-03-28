<%@ page import="java.io.*, java.sql.*, java.util.*, javax.servlet.http.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.*, javax.servlet.http.*" %>
<%@ page import="org.apache.commons.*" %>
<%@ page import="java.nio.file.Paths, java.nio.file.Files, java.nio.file.Path" %>
<%

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>b.html</title>
</head>
<body>
    <h2>자식 페이지 (b.html)</h2>
    <form id="myForm">
        <input type="text" name="data" value="전송할 데이터">
        <button type="button" onclick="submitData()">전송</button>
    </form>

    <script>
        function submitData() {
            var dataToSend = document.getElementsByName("data")[0].value;
            fetch("c.jsp", {
                method: "POST",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: "data=" + encodeURIComponent(dataToSend)
            })
            .then(response => response.text())
            .then(data => {
                window.opener.receiveDataFromChild(data);
                window.close(); // 데이터 전송 후 b.html 페이지 닫기
            })
            .catch(error => console.error('Error:', error));
        }
    </script>
</body>
</html>
