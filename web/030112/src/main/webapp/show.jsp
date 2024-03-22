<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
    <title>Uploaded Files</title>
</head>
<body>
    <h2>Uploaded Files</h2>
    <ul>
        <%-- 업로드된 파일 경로로부터 파일 목록을 가져와 출력합니다 --%>
        <% File uploadDir = new File(application.getRealPath("/") + "uploads");
           File[] files = uploadDir.listFiles();
           if (files != null) {
               for (File file : files) { %>
                   <li><a href="uploads/<%= file.getName() %>"><%= file.getName() %></a></li>
               <% }
           } %>
    </ul>
</body>
</html>