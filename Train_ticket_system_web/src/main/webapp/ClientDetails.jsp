<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available TRAINs</title>
    <link rel="icon" sizes="180x180" href="image/title.png">
    <link rel="stylesheet" href="table_styles.css">
    <script>
        function sendData(id) {
            document.getElementById('selectedId').value = id;
            document.getElementById('form').submit();
        }
    </script>
</head>
<body background="image/background.jpg" >
<h1>CLIENT DETAILS</h1>

<%
try {
	Class.forName("org.sqlite.JDBC");
	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
    if (con == null) {
%>
    Connection not created...
<% } else { 
    PreparedStatement ps = con.prepareStatement("select username, firstname, lastname, mobile, email, address from users");
    ResultSet rs = ps.executeQuery();
    ResultSetMetaData rsm = rs.getMetaData();
    int col = rsm.getColumnCount();
    if (rs.next()) {
%>
    <table>
        <thead>
            <tr>
                <th>Client Id</th>
                <th>FIRST NAME</th>
                <th>LAST NAME</th>
                <th>MOBILE</th>
                <th>EMAIL</th>
                <th>ADDRESS</th>
            </tr>
        </thead>
        <%
        do { %>
        <tbody>
            <tr>
                <% for (int i = 1; i <= col; i++) { %>
                    <td><b><%= rs.getString(i) %></b></td>
                <% } %>
            </tr>
        </tbody>
        <% } while (rs.next()); %>
    </table>
<%
    } else {
        out.println("No TRAINs available");
    }
}
} catch (Exception e) {
    out.println(e);
}
%>

</body>
</html>
