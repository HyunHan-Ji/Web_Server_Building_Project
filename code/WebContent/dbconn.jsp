<%@ page import="java.sql.*"%>
<%
	Connection dbconn = null;
	
	String dburl = "jdbc:mysql://localhost:3306/JSPBookDB";
	String dbuser = "root";
	String dbpassword = "1234";
	
	Class.forName("com.mysql.jdbc.Driver");
	dbconn = DriverManager.getConnection(dburl, dbuser, dbpassword);
%>