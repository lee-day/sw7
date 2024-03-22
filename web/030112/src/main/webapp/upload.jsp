<%@ page import="java.io.*, java.sql.*, java.util.*, javax.servlet.http.*, org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.*, javax.servlet.http.*" %>
<%@ page import="org.apache.commons.*" %>
<%@ page import="java.nio.file.Paths, java.nio.file.Files, java.nio.file.Path" %>

<%
    // 파일 업로드 처리
    String savePath = application.getRealPath("/") + "uploads"; // 파일이 저장될 서버 내 폴더 경로
    File fileSaveDir = new File(savePath);
    String name="";
    if (!fileSaveDir.exists()) {
        fileSaveDir.mkdir();
    }

    if (ServletFileUpload.isMultipartContent(request)) {
        try {
            List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

            for (FileItem item : multiparts) {
                if (!item.isFormField()) {
                    name = new File(item.getName()).getName();
                    item.write(new File(savePath + File.separator + name));

                    // DB에 파일 메타데이터 저장
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "1234");
                        String sql = "INSERT INTO uploaded_files (file_name, file_size) VALUES (?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, name);
                        pstmt.setLong(2, item.getSize());
                        pstmt.executeUpdate();
                        out.println("File uploaded and metadata saved to database successfully.");
                          
                    } catch (Exception ex) {
                        out.println("File upload failed or metadata saving failed due to: " + ex);
                    } finally {
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                }
            }
        } catch (Exception ex) {
            out.println("File upload failed due to: " + ex);
        }
    } else {
        out.println("Sorry, this Servlet only handles file upload requests.");
    }
    
out.println(" 파일이름 : "+name);
%>

<script>window.opener.postMessage(name, "*");</script>                   
