<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Booking</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<style>
		body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;

        }
        h1 {
            padding: 30px;
            text-align: center;
            background: #34b4eb;
            color: white;
            font-size: 30px;
            border-radius: 10px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
            
            
        }
        th {
            background-color: #B8CD76;
            color: #2B96BB;
            border-radius: 10px;
        }
        button {
            padding: 8px 15px;
            background-color: #3498db;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            
        }
        button:hover {
            background-color: #2980b9;
        }
        .user-icon {
            position: absolute;
            top: 10px;
            right:10px
        }
        .rounded-button {
        background-color: #C1272D;
        color: white;
        padding: 10px 25px;
     	border: none;
    	border-radius: 8px;
    	cursor: pointer;
    	transition: background-color 0.3s, color 0.3s, border-color 0.3s;
		}

		/* Button styles on hover */
		.rounded-button:hover {
   		 background-color: white;
    	 color: #C1272D;
    	border: 1px solid #C1272D;
        }
        body

/* Center the button */
       .button-container {
       text-align: center;
       margin-top: 15px; /* Add some top margin */
       }
       </style>
<script>
        function sendData(id) {
            document.getElementById('selectedId').value = id;
            document.getElementById('form').submit();
        }
        function sendData2(id) {
            document.getElementById('selectedId1').value = id;
            document.getElementById('form1').submit();
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

<h1>MY BOOKINGS</h1></p>
<hr style="border-top: 2px solid #333;">
<%
String uid=(String)session.getAttribute("Username");
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
		PreparedStatement ps = con.prepareStatement("select BOOK_ID,JOURNEY_DATE,TRAIN_NUMBER,TRAIN_NAME,PASSENGERS,CLASS,SOURCE,BOARDINGTIME, AMOUNT from bookingdetails where username=?");
		ps.setString(1,"Messi");
		ResultSet rs=ps.executeQuery();
		ResultSetMetaData rsm=rs.getMetaData();
		int col=rsm.getColumnCount();
		if(rs.next())
		{
			%>
			<table border=9>
		        <th>PNR</th>
			    <th>JOURNEY DATE</th>
			    <th>TRAIN NUMBER</th>
			    <th>TRAIN NAME</th>
			    <th>PASSENGERS</th>
			    <th>CLASS</th>
			    <th>BOARDING AT</th>
				<th>BOARDING TIME</th>
				<th>TOTAL AMOUNT</th>
			
			<%
			do
			{%>
			<tr>
				<%
				for(int i=1;i<=col;i++)
				{%>
					<td><b><%=rs.getString(i) %></b></td>
				<%}%>
				<td>
				 <button onclick="sendData('<%=rs.getString(1) %>')" class="rounded-button">View Details</button>
				</td>
				<td>
				 <button onclick="sendData2('<%=rs.getString(1) %>')" class="rounded-button">Cancel</button>
				</td>
			</tr>
			<%}while(rs.next());
			%>
			</table>
			<form id="form" action="showBookingDetails.jsp" method="post">
		        <input type="hidden" id="selectedId" name="selectedId">
		        <input type="hidden" id="class" name="class">
		    </form>
		    <form id="form1" action="startCancellation.jsp" method="post">
		        <input type="hidden" id="selectedId1" name="selectedId1">
		        <input type="hidden" id="class" name="class">
		    </form>
			<%
			
		}else{
			out.println("You dont have any journey booked");
			
		}
	
	}
	con.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>

</body>
</html>