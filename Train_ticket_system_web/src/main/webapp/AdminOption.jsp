<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="AdminOption_styles.css">
</head>
<body background="image/background.jpg">
	<div class="glass-container">
	<h2 class="pay"> Admin Controls</h2>
	<p>Hello, Admin, here are your tasks..</p>
	<br>
		<div class="button-container">
			<form action="AdminHome.html" method="post">
				<input type="submit" value="Add Train" class="rounded-button">
			</form>
			<div class="button-spacing"></div>
			<form action="AdminHome2.jsp" method="post">
				<input type="submit" value="Discontinue Train" class="rounded-button">
			</form>
			<div class="button-spacing"></div>
			<form action="ClientDetails.jsp" method="post">
				<input type="submit" value="View Clients" class="rounded-button">
			</form>
		</div>
	</div>

</body>
</html>