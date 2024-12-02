<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Account Details</title>
    <link rel="stylesheet" href="register_styles.css">
    <link rel="icon" sizes="180x180" href="image/title.png">
    <style>
	    .form-group {
	    display: flex;
	    align-items: center;  /* Aligns label and input vertically */
	    margin-bottom: 10px;   /* Optional: Adjust space between rows */
		}
		
		.form-group label {
		    width: 150px;  /* Adjust label width */
		    margin-right: 10px; /* Optional: Add some space between label and input */
		}
		
		.form-group input {
		    flex-grow: 1;  /* Makes input take the remaining space */
		    height: 30px;  /* Adjust this value to your desired height */
		    padding: 5px;  /* Adjust the padding to control the space inside the text box */
		    font-size: 14px;  /* Optional: Adjust font size for better readability */
		} .form-group label {
		    color: #9bb1f2;  /* Change text color to blue */
		    font-size: 14px;  /* Reduce text size */
		} 
		.form-group input {
		    color: grey;  /* Change this to the desired text color */
		    height: 30px;
		    padding: 5px;
		    font-size: 14px;
		    alignment: center
		}
	</style>
</head>
<body background="image/background.jpg">
    
    <%
        // Importing required classes
        try {
            // Load the SQLite JDBC driver
            Class.forName("org.sqlite.JDBC");
	        Connection con=DriverManager.getConnection("jdbc:sqlite:C:\\Users\\abhim\\MySQLiteDB");
            
            // Query to retrieve user details
            String sql = "SELECT * FROM users WHERE username = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            String uid = (String)session.getAttribute("Username");
            pstmt.setString(1, uid);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String fname = rs.getString("FIRSTNAME");
                String lname = rs.getString("LASTNAME");
                String mobile = rs.getString("mobile");
                String email = rs.getString("email");
                String address = rs.getString("address");
            
                
    %>
    <div class="container">
        <img src="image/Air_Trips.png" alt="Company Logo" class="logo">
        <form method="post" action="UpdateAccountServlet" class="glass-container" onsubmit="return validateForm();">
		    <div class="form-group">
		        <label for="fname">First Name</label>
		        <input type="text" id="fname" name="fname" value=<%=fname %> placeholder="First Name" required >
		    </div>
		
		    <div class="form-group">
		        <label for="Lname">Last Name</label>
		        <input type="text" id="Lname" name="Lname" value=<%=lname %> placeholder="Last Name" required >
		    </div>
		
		    <div class="form-group">
		        <label for="Mobile">Mobile Number</label>
		        <input type="text" id="Mobile" name="Mobile" value=<%=mobile %> placeholder="Mobile Number" required readonly>
		    </div>
		
		
		    <div class="form-group">
		        <label for="email">Email</label>
		        <input type="text" id="email" name="email" value=<%=email %> placeholder="Email" required readonly>
		    </div>
		
		    <div class="form-group">
		        <label for="address">Address</label>
		        <textarea id="address" name="address" placeholder="Address" required style="width: 100%; height: 100px;"><%= address %></textarea>
		    </div>
		
		    <div class="button-container">
		        <input type="submit" value="Update Details" class="rounded-button">
		    </div>
		</form>
		<br>
		<form id="myForm" method="post" action="" class="button-container-1">
		        <a href="passwordChange.html"
		            class="cancel-link"
		            style="text-decoration: none; color: black;"
		            onmouseover="this.style.color='#777'; this.style.textDecoration='underline';"
		            onmouseout="this.style.color='black'; this.style.textDecoration='none';">
		            <b>Change Password</b>
		        </a>
		    </form>
    </div>
    <%
            }
            // Close the connection and result set
            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
