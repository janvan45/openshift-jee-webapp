<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.math.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.security.*" %>

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
			
			<div class="content">
			<%
				Properties prop = new Properties();
				InputStream input = null;
		
				try {
			
					input = this.getClass().getClassLoader().getResourceAsStream("/database.properties");
					
					prop.load(input);
					String JDBC_DRIVER = prop.getProperty("db.driver");
					
					String DB_URL = "jdbc:mysql://" + System.getenv("MYSQL_SERVICE_HOST") + ":" + System.getenv("MYSQL_SERVICE_PORT") + "/" + System.getenv("MYSQL_DATABASE");
					String DB_USER = System.getenv("MYSQL_USER");
					String DB_PASS = System.getenv("MYSQL_PASSWORD");
					
					//String DB_URL = prop.getProperty("db.url");
					//String DB_USER = prop.getProperty("db.username");
					//String DB_PASS = prop.getProperty("db.password");
				
					Connection conn = null;
					Statement stmt = null;
					
					try{
						Class.forName(JDBC_DRIVER);
						conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASS);
						
						String username = request.getParameter("username");
						
						String pwd = request.getParameter("pwd");
				        MessageDigest m=MessageDigest.getInstance("MD5");
				        m.update(pwd.getBytes(), 0 , pwd.length());
				        
				        String pwdmd5 = new BigInteger(1,m.digest()).toString(16);
				        
						
					   try{
					       stmt = conn.createStatement();
					       String sql;
						   sql = "select id, username, lname, fname, password from users where username='" + 
					       			username + "' and password='" + pwdmd5 + "' limit 1";
						   
						   ResultSet rs = stmt.executeQuery(sql);
						   
						   if(rs.next()){
							   out.print("<p>Welcome <span id='fullname'>" + rs.getString("fname") + " " + rs.getString("lname") + "</span></p>");
							   out.print("<p>Version <span id='version'>" +  prop.getProperty("pj.version") + "</span></p>");
							   
						   }else{
							   out.println("<p>Login failed. Please check your user and password. </p>");
						   }
						   rs.close();
						   
					   }catch(Exception ex){
						   out.print("Query failed...</br>");
					   }
					   
					   conn.close();
					}catch(Exception e){
						out.print("Database connect failed...</br>");
					}
					
					input.close();
				} catch (IOException ex) {
					out.print("FileInputStream failed...</br>");
				} 
				out.println("Goodbye!");
		    %>
		    </div>
		</div>
	</div>
</body>
</html>
