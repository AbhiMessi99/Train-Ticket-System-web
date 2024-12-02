<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booked Successfully</title>
<link rel="stylesheet" href="booked_styles.css">
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="all.css">


</head>
<body background="image/background.jpg">

<div class= download>
    <div class=booked>
    <p>Your Ticket is Booked.....</p>
    </div>
    <div class=print>
    <div class="button-container">
    <button onclick="window.print()" class="rounded-button">Print</button> 
    </div>
    </div>
</div>

<div class= main>
    <div class=date>
    <%
    String trainName=(String)session.getAttribute("trainName");
    String src="logo/"+trainName.toLowerCase()+".png";
    %>
    
    <div class="trains"><%=(String)session.getAttribute("trainNumber")%>-<%=(String)session.getAttribute("trainName")%></div>
    </div>
    <div class=tofrom>
    <%=(String)session.getAttribute("source")%>&#8594<%=(String)session.getAttribute("destination")%>
    <br>
    <%=(String)session.getAttribute("arrival")%> --<span class="spanclass"><%=(String)session.getAttribute("journeyTime")%></span>--><%=(String)session.getAttribute("departure")%>
    </div>
    <div class=date>
    <%=(String)session.getAttribute("yyyy_mm_dd") %> 
    </div>
</div>
    
<div class= main style="margin-bottom:50px">
    <div class=date>
    <%=(String)session.getAttribute("cl")%>
    </div>
    <div class=tofrom>
    PNR Number: <%=(String)session.getAttribute("book_id")%>
    <br>
    </div>
    <div class=date>
    Fare Quota: <%=(String)session.getAttribute("faretype")%> 
    </div>
</div>
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
		
		
		PreparedStatement ps = con.prepareStatement("SELECT * FROM trainPASSENGERDETAILS WHERE PNR=?");
		ps.setString(1, (String)session.getAttribute("book_id"));
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsm=rs.getMetaData();
		int col=rsm.getColumnCount();
		if(rs.next())
		{
			%>
			<table border=9>
			<%
			for(int i=2;i<=col;i++)
			{%>
				<th><%=rsm.getColumnName(i)%></th>
			<%}%>
			<%
			do
			{%>
			<tr>
				<%
				for(int i=2;i<=col;i++)
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


<div class= buttons>
    <div class=button1>
        <form class = "buttonone" action="showTrains.jsp" method="post">
        <div class="button-container">
	    <input type="submit" value="Home" class="rounded-button">
	    </div>
        </form>
    </div>
    <div class=button2>
    <form class = "buttontow" action="AccountSignIn.html" method="post">
	<div class="button-container">
                <input type="submit" value="Sign out" class="rounded-button">
    </div>
    </form>
    </div>
</div>
</body>
</html>