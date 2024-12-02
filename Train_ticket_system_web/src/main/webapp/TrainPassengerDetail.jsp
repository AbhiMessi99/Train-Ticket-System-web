<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Passenger Details</title>
    <link rel="icon" sizes="180x180" href="image/title.png">
    <link rel="stylesheet" href="all.css">
    <style>
    .glass-container {
	    background: rgba(255, 255, 255, 0.1);
	    border-radius: 16px;
	    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
	    backdrop-filter: blur(7.1px);
	    border: 1px solid rgba(255, 255, 255, 0.3);
	    padding: 20px;
	}
    form{width: 300px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            color: #161717;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
    input[type="number"] {
            padding: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 10%;
        }
    input[type="text"]
    {
            padding: 4px;
            border: 1px solid #ccc;
            border-radius: 4px;
    }
    </style>
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
    <h1>Enter Passenger Details</h1>
    <% 
        int numPassengers = Integer.parseInt(request.getParameter("numPassengers"));
        session.setAttribute("pass_num", numPassengers);
        for (int i = 1; i <= numPassengers; i++) {
    %>
       
        <form action="ReviewJourney.jsp" method="post" class="glass-container">
         <h3><center>Passenger <%= i %><center></h3>
            <input type="hidden" name="passengerNumber" value="<%= i %>">
            <label for="name_<%= i %>">Name:</label>
            <input type="text" id="name_<%= i %>" name="name_<%= i %>" required>
            <br><br>
            <label for="age_<%= i %>">Age:</label>
            <input type="number" id="age_<%= i %>" name="age_<%= i %>" value="1" min="1" required><br><br>
            <label>
            <input type="radio" name="gender_<%= i %>" value="Male" checked>
            Male
            </label>

            <label>
            <input type="radio" name="gender_<%= i %>" value="Female">
            Female
            </label>

            <label>
            <input type="radio" name="gender_<%= i %>" value="Others">
            Others
            </label> 
        
        <% } %>
        
        <br>
        <div class="button-container">
        <br><input type="submit" value="Submit" class="rounded-button">
        </div>
         
    </form>
</body>
</html>
