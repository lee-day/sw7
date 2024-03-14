package DBPKG;

import java.sql.*;

public class Utill {
    public static Connection getConnection() throws Exception{
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe","system","1234");
        return conn;
    }
}