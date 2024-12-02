<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancelled</title>
<link rel="icon" sizes="180x180" href="image/title.png">
<link rel="stylesheet" href="redirect_styles.css">
</head>
<body background="image/background.jpg">

<div class="glass-container">
		<p class="font" style="color:red"><b>Your PNR - <%=(String)session.getAttribute("cancel_id") %> is Cancelled.</b> </p>
		<p class="font"> A refund of Rs. <%=(Double)session.getAttribute("refund")%> is initiated to your original payment method(<%=(String)session.getAttribute("method")%>) will be reflected in your bank in 5-7 working days </p>
		<div class="button-container">
			<form method="post" action="showTrains.jsp">
				<input type="Submit" value="Home"  class="rounded-button">
			</form>
		</div>
	</div>

</body>
</html>