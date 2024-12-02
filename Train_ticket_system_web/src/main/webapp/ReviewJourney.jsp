<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Review Journey</title>
    <link rel="icon" sizes="180x180" href="image/title.png">
    <link rel="stylesheet" href="all.css">
    <link rel="stylesheet" href="booked_styles.css">
	<style>
	.glass-container {
	    background: rgba(255, 255, 255, 0.1);
	    border-radius: 16px;
	    box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
	    backdrop-filter: blur(7.1px);
	    border: 1px solid rgba(255, 255, 255, 0.3);
	    padding: 20px;
	}
	form {
	    width: 300px;
	    margin: 0 auto;
	    background-color: #fff;
	    padding: 20px;
	    border-radius: 8px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	}
	label {
	    display: block;
	    margin-bottom: 8px;
	    text-align: center;
	}
	input[type="number"] {
	    padding: 4px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	.pricing {
	    width: 400px;
	    margin-top: 40px;
	    margin: auto;
	    border: 1px solid #ccc;
	    border-radius: 8px;
	    padding: 15px;
	    background-color: #f9f9f9;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    flex-direction: column;
	    text-align: left;
	}
	.pricing h2 {
	    margin-bottom: 10px;
	    color: #333;
	}
	.pricing p {
	    color: #666;
	}
	.main > div {
	    flex:1;
	    text-align: center;
	}
	</style>
           
</head>
<body background="image/background.jpg">
    <!-- Header Section -->
    <header style="background-color: #fff; padding: 20px; border-radius: 10px;">
        <div style="display: flex; align-items: center; justify-content: space-between;">
            <div>
                <!-- Logo -->
                <img src="image/Air_Trips1.png" alt="Logo" style="height: 50px; width: auto;">
            </div>
            <div>
                <!-- Username -->
                <span style="font-size: 20px;">Welcome, <%=(String)session.getAttribute("Username") %></span>
                <img src="image/icon.png" alt="Icon" style="height: 25px;">
            </div>
        </div>
    </header>

    <h1>REVIEW JOURNEY</h1>

    <!-- Journey Details -->
    <div class="main">
    <div class="date">
    <%
    String trainName = (String) session.getAttribute("trainName");
    String src = "logo/" + trainName.toLowerCase() + ".png";
    %>
    
    <div class="trains"><%=(String)session.getAttribute("trainNumber")%>-<%=(String)session.getAttribute("trainName")%></div>
    </div>
    <div class="tofrom">
    <%=(String)session.getAttribute("source")%>&#8594;<%=(String)session.getAttribute("destination")%>
    <br>
    <%=(String)session.getAttribute("arrival")%> --<span class="spanclass"><%=(String)session.getAttribute("journeyTime")%></span>--><%=(String)session.getAttribute("departure")%>
    </div>
    <div class="date">
    <%=(String)session.getAttribute("yyyy_mm_dd") %> 
    </div>
</div>

    <!-- Passenger Details and Payment -->
    <div class="pricing">
        <h4>Passengers Details</h4>
        <%
        int passengerNum = (Integer) session.getAttribute("pass_num");
        for (int i = 1; i <= passengerNum; i++) {
            String passengerName = request.getParameter("name_" + i);
            String passengerAge = request.getParameter("age_" + i);
            String gender = request.getParameter("gender_" + i);

            // Save to session for further usage
            session.setAttribute("name_" + i, passengerName);
            session.setAttribute("age_" + i, passengerAge);
            session.setAttribute("gender_" + i, gender);
        %>
            <h3><%= i + ". " + passengerName + " " + passengerAge + " " + gender %></h3>
        <%
        }
        int payable=(Integer)session.getAttribute("pay");
        payable=payable*passengerNum;
        session.setAttribute("paid",payable);
        %>

        <br>
        <form method="post" action="paymentMethod.html">
            <%String classTravel = (String)session.getAttribute("cl"); %>
            <p><%= classTravel.toUpperCase() %> ( <%=(String) session.getAttribute("fareType") %> )</p>
            <p>Total Payable: <%= "Rs " + payable %></p>
            <div class="button-container">
                <input type="submit" value="Pay" class="rounded-button">
            </div>
        </form>
    </div>
</body>
</html>
