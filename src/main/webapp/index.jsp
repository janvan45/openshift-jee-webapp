<html>
<head>
	<meta charset="UTF-8">
	<title>Demo App</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="main">
		<div class="center">
			<h2>Welcome to Demo App</h2>
			<form id="login" method="post" action="response.jsp">
			  <div class="form-group">
				<label for="email">Username:</label>
				<input type="text" name="username" id="username" required>
			  </div>
			  <div class="form-group">
				<label for="pwd">Password:</label>
				<input type="password" name="pwd" id="pwd" required>
			  </div>
			  <button type="submit" class="btn btn-submit">Submit</button>
			</form>
		</div>
	</div>
</body>
</html>
