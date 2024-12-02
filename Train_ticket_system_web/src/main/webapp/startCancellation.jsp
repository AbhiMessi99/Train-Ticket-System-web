<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="redirect_styles.css">
</head>
<body background="image/background.jpg">
<div class="glass-container">
	<p class="font">Are you sure, that you want to cancel your booking?</p>
	<%String book_id=(String)request.getParameter("selectedId1");
	session.setAttribute("cancel_id",book_id);
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
			PreparedStatement ps = con.prepareStatement("select amount, method, passengers, class from bookingdetails where BOOK_ID=?");
			ps.setString(1,book_id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()){
				double deduction=0;
				String cl=rs.getString(4);
				if(cl.equalsIgnoreCase("SLEEPER"))
					deduction=120+23;
				if(cl.equalsIgnoreCase("THIRDAC"))
					deduction=180+23+0.18*180;
				if(cl.equalsIgnoreCase("SECONDAC"))
					deduction=200+23+0.18*200;
				if(cl.equalsIgnoreCase("FIRSTAC"))
					deduction=240+23+0.18*240;
				double amount=rs.getDouble(1);
				String method=rs.getString(2);
				double refund=amount-deduction*rs.getDouble(3);
				if(refund<0)
					refund=0;
				session.setAttribute("refund",refund);
				session.setAttribute("method", method);
		%>
		<br>
		<p class="font">A refund of <span style="color: red"> <b>Rs. <%= refund %></b></span> into from original payment method(<%=method%>) in 3 to 7 business days.</p>
		<%
			}
		}
		con.close();
	}
	catch(Exception e)
	{
		out.println(e);
	}
	%>
	<form action="cancellationServlet" method="post">
	<div class="button-container">
	   <input type="Submit" value="Cancel" class="rounded-button">
	 </div>
	</form>
	<br>

	<a href="ShowFlights.jsp"
   class="cancel-link"
   style="text-decoration: none; color: black;"
   onmouseover="this.style.color='#777'; this.style.textDecoration='underline';"
   onmouseout="this.style.color='black'; this.style.textDecoration='none';">
   No, don't cancel
</a>





	</div>
</body>
</html>