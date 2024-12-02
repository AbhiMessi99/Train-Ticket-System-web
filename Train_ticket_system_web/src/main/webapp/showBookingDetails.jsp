
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Details</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="all.css">
<link rel="stylesheet" href="booked_styles.css">
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
<%
String book_id=(String)request.getParameter("selectedId");
%>
<h1>Booking id: <%=book_id%></h1></p>
<hr style="border-top: 2px solid #333;">

<%
try
{
	Class.forName("org.sqlite.JDBC");
	Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
	if(con==null)
	{
%>
Connection not created...
<%}
	else
	{
		PreparedStatement ps1 = con.prepareStatement("select JOURNEY_DATE,TRAIN_NUMBER,TRAIN_NAME,CLASS,SOURCE,DESTINATION,BOARDINGTIME,FARETYPE from bookingdetails where BOOK_ID=?");
		ps1.setString(1,book_id);
		ResultSet rs1=ps1.executeQuery();
		if(rs1.next())
		{
		%>
		    <div class= main>
		        <div class=date>
			    <%
			    String TrainName=(String)session.getAttribute("flightName");
			  
			    %>
			    
			    <div class="trains"><%=rs1.getString(2)%>-<%=rs1.getString(3)%></div>
			    </div>
			    
			    <div class=tofrom>
			    <%=rs1.getString(5)%>&#8594<%=rs1.getString(6)%>
			    <br>
			    <br>
			    <span style="color:green;">Boarding Time:<%=rs1.getString(7)%></span>
			    </div>
			    <div class=date>
			    <%=rs1.getString(1)%> 
			    </div>
			</div>
			    
			<div class= main style="margin-bottom:50px">
			    <div class=flightnameid>
			    <%=rs1.getString(4)%>
			    </div>
			    <div class=tofrom>
			    Book id: <%=book_id%>
			    <br>
			    </div>
			    <div class=date>
			    Fare Quota: <%=rs1.getString(8)%>
			    </div>
			</div>
		<%
		}
		PreparedStatement ps = con.prepareStatement("select PASSENGER_NAME,AGE,GENDER from TRAINPASSENGERDETAILS where PNR=?");
		ps.setString(1,book_id);
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsm=rs.getMetaData();
		int col=rsm.getColumnCount();
		if(rs.next())
		{
			%>
			<table border=9>
			<%
			for(int i=1;i<=col;i++)
			{%>
				<th><%=rsm.getColumnName(i)%></th>
			<%}%>
			<%
			do
			{%>
			<tr>
				<%
				for(int i=1;i<=col;i++)
				{%>
					<td><b><%=rs.getString(i) %></b></td>
				<%}%>
			</tr>
			<%}while(rs.next());
			con.close();
			%>
			</table>
			<%
		}
	
	}

}
catch(Exception e)
{
	out.println(e);
}
%>
<br>
<form method="post" action="showTrains.jsp">
  <div class="button-container">
                <input type="submit" value="Home" class="rounded-button">
    </div>
</form>
</body>
</html>