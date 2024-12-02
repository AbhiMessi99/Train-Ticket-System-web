<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Train</title>
    <link rel="icon" sizes="180x180" href="image/title.png">
    <link rel="stylesheet" href="showTrains.css">
</head>
<body background="image/background.jpg">
	<header>
        <div style="display: flex; align-items: center; justify-content: space-between;">
            <div>
                <!-- Logo -->
                <img src="image/Air_Trips1.png" alt="Logo" style="height: 50px; width: auto;">
            </div>
            <div>
            </div>
            <div>
                <!-- Username -->
                <span style="font-size: 20px;">Welcome , <%=(String)session.getAttribute("Username")%></span>
               <a href="updateProfile.jsp">
                    <img src="image/icon.png" alt="Logo" style="height: 25px;">
                </a>
            </div>
        </div>
    </header>


    <div class="container">
        <form method="post" action="AvailableTrains.jsp" class="glass-container">
            <div class="form-grid">
                <div class="column">
                    <div class="form-section">
                        <label for="from">From:</label>
                        <input type="text" name="from" placeholder="Enter source location" class="textbox" required>
                    </div>
                    <label for="class">Select Class:</label>
                    <select id="class" name="class" class="selectbox">
                        <option value="SLEEPER">SLEEPER</option>
                        <option value="THIRDAC">THIRD AC</option>
                        <option value="SECONDAC">SECOND AC</option>
                        <option value="FIRSTAC">FIRST AC</option>   
                    </select>
                </div>
                <div class="column">
                    <div class="form-section">
                        <label for="to">To:</label>
                        <input type="text" name="to" placeholder="Enter destination location" class="textbox" required>
                    </div>
                    <label for="Date">Departure Date:</label>
                    <input type="date" name="Date" value="2024-12-01" max="2024-12-10" min="2024-12-01" class="textbox">
                </div>
            </div>
            
            <div class="fare-container">
                <div class="fare-section">
                    <label><b>Select Quota:</b></label>
                </div>
                <div class="fare-section">
                    <label>
                        <input type="radio" name="faretype" value="General" checked>
                        General
                    </label>
                </div>
                <div class="fare-section">
                    <label>
                        <input type="radio" name="faretype" value="Tatkal">
                        Tatkal
                    </label>
                </div>
                <div class="fare-section">
                    <label>
                        <input type="radio" name="faretype" value="SR Citizen">
                        SR Citizen
                    </label>
                </div>
                <div class="fare-section">
                    <label>
                        <input type="radio" name="faretype" value="Ladies">
                        Ladies
                    </label>
                </div>
            </div>

            <div class="button-container">
                <input type="submit" name="Search" value="Search Trains" class="rounded-button">
            </div>
        </form>
        <br>
        
        <div class="button-container-3">
		    <form id="myForm" method="post" action="showMybooking.jsp" class="button-container-1">
		        <a href="showMybooking.jsp"
		            class="cancel-link"
		            style="text-decoration: none; color: black;"
		            onmouseover="this.style.color='#777'; this.style.textDecoration='underline';"
		            onmouseout="this.style.color='black'; this.style.textDecoration='none';">
		            <b>My Booking</b>
		        </a>
		    </form>
		
		    <form method="post" action="AccountSignIn.html" class="button-container-2">
		        <a href="AccountSignIn.html"
		            class="cancel-link"
		            style="text-decoration: none; color: black;"
		            onmouseover="this.style.color='#777'; this.style.textDecoration='underline';"
		            onmouseout="this.style.color='black'; this.style.textDecoration='none';">
		            <b>Sign Out</b>
		        </a>
		    </form>
		</div>
    </div>
</body>
</html>