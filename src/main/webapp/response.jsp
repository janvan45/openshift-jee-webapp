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
					
					String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
					String DB_URL="jdbc:oracle:thin:@" + System.getenv("DB_HOST"); + ":" + System.getenv("DB_PORT"); + ":xe";
					String DB_USER = System.getenv("DB_USER");
					String DB_PASS = System.getenv("DB_PASSWORD");
				
					Connection conn = null;
					Statement stmt = null;
					
					try{
						Class.forName(JDBC_DRIVER);
						conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASS);
						if (conn != null) {
							out.println("Connection successful. </br>");
						}
						
						String username = request.getParameter("username");
						String pwd = request.getParameter("pwd");
				        MessageDigest m=MessageDigest.getInstance("MD5");
				        m.update(pwd.getBytes(), 0 , pwd.length());
				        
				        String pwdmd5 = new BigInteger(1,m.digest()).toString(16);
				        
						
					   try{
					       stmt = conn.createStatement();
					       String sql;
						   sql = "select id, username, lname, fname, password from users where username='" + 
					       			username + "' and password='" + pwdmd5 + "' and ROWNUM <= 1";
						   
						   ResultSet rs = stmt.executeQuery(sql);
						   
						   if(rs.next()){
							   out.print("<p>Welcome <span id='fullname'>" + rs.getString("fname") + " " + rs.getString("lname") + "</span></p>");
							   out.print("<p>Version <span id='version'>" +  prop.getProperty("pj.version") + "</span></p>");
							   
						   }else{
							   out.println("<p>Login failed. Please check your user and password. </p>");
						   }
						   rs.close();
						   
					   }catch(SQLException e){
						   out.print("Queries failed...</br>");
					   }
					   
					   conn.close();
					}catch(Exception ex){
						out.print("Connection failed...</br>");
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
