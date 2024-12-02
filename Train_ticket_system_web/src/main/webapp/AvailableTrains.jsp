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
    <header style="background-color: #fff; padding: 20px; border-radius: 10px;">
        <div style="display: flex; align-items: center; justify-content: space-between;">
            <div>
                <!-- Logo -->
                <img src="image/Air_Trips1.png" alt="Logo" style="height: 50px; width: auto;">
            </div>
            <div>
                <!-- Username -->
                <span style="font-size: 20px;">Welcome, <%=(String)session.getAttribute("Username") %></span>
                <img src="image/icon.png" alt="Logo" style="height: 25px;">
            </div>
        </div>
    </header>
<h1>AVAILABLE TRAINS</h1>

<%
    String FROM = (request.getParameter("from")).toUpperCase();
    String TO = (request.getParameter("to")).toUpperCase();
    String CLASS = request.getParameter("class");
    
    String DATE = request.getParameter("Date");
    session.setAttribute("yyyy_mm_dd", DATE);
    String month[] = {"JAN", "FEB", "", "", "", "", "", "", "SEP", "OCT", "NOV", "DEC"};
    String day = DATE.substring(8,10);
    int mon = Integer.parseInt(DATE.substring(5,7));
    String year = DATE.substring(0,4);
    String newdate = month[mon-1] + day + "_" + year;
    session.setAttribute("date", newdate);
    session.setAttribute("cl", CLASS);
    session.setAttribute("fareType", request.getParameter("faretype"));

try {
	Class.forName("org.sqlite.JDBC");
	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
    if (con == null) {
%>
    Connection not created...
<% } else { 
    String query = "SELECT a.TRAIN_number, " +
                   "a.TRAIN_name, " +
                   "b.departure_time, " +
                   "b.arrival_time, " +
                   "b.journey_time, " +
                   "c." + CLASS + ", " +  // Using dynamic class
                   "d." + newdate +// Dynamically setting date column
                   " FROM TRAINs a " +
                   "INNER JOIN TRAINtimetable b ON a.TRAIN_number = b.TRAIN_number " +
                   "INNER JOIN TRAIN_fares c ON b.TRAIN_number = c.TRAIN_number " +
                   "INNER JOIN " + CLASS + " d ON c.TRAIN_number = d.TRAIN_number " +
                   "WHERE a.source = ? " +
                   "AND a.destination = ? " +
                   "AND d." + newdate + " > 0";  // Use dynamic column for the fare condition
    out.println(query);
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, FROM);
    ps.setString(2, TO);
    ResultSet rs = ps.executeQuery();
    ResultSetMetaData rsm = rs.getMetaData();
    int col = rsm.getColumnCount();
    if (rs.next()) {
%>
    <table>
        <thead>
            <tr>
                <th>TRAIN NUMBER</th>
                <th>TRAIN NAME</th>
                <th>DEPARTURE</th>
                <th>LANDING</th>
                <th>JOURNEY TIME</th>
                <th>FARE</th>
                <th><%= CLASS %>
            </tr>
        </thead>
        <%
        do { %>
        <tbody>
            <tr>
                <% for (int i = 1; i <= col; i++) { %>
                    <td><b><%= rs.getString(i) %></b></td>
                <% } %>
                <td>
                    <div class="button-container">
                        <button onclick="sendData('<%= rs.getString(1) %>')" class="rounded-button">BOOK</button>
                    </div>
                </td>
            </tr>
        </tbody>
        <% } while (rs.next()); %>
    </table>
    <form id="form" action="ExtractDetails" method="post">
        <input type="hidden" id="selectedId" name="selectedId">
        <input type="hidden" id="class" name="class">
    </form>
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
