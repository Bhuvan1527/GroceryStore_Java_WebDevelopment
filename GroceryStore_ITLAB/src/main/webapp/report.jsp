<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report</title>
<link href="style2.css" rel="stylesheet">
</head>
<body>
<div class="navbar">
        <a class="navbar-brand" href="#">NLEGS</a>
        <ul class="nav-right">
            <li class="nav-item"><a class="nav-link" href="shop.jsp">Shop</a></li>
            <li class="nav-item"><a class="nav-link" href="Logout">Logout</a></li>
            <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
        </ul>
    </div>

<section class="text-center">
     <%
     	String url = "jdbc:mysql://localhost:3306/itLabAss";
		String user = "root";
		String pass = "Bala@123";
     	try{
     		Class.forName("com.mysql.cj.jdbc.Driver");
     		Connection con = DriverManager.getConnection(url, user, pass);
     		String query = "select * from transactions where ";
     		if(request.getParameter("buyerUsrname") != ""){
     			query += " buyer_usrName = '"+request.getParameter("buyerUsrname")+"'";
     		}
     		if(request.getParameter("fromDate") != ""){
     			if(query.equals("select * from transactions where ")){
     				query += " trans_date >= '"+request.getParameter("fromDate")+"'";
     			}
     			else query += "and trans_date >= '"+request.getParameter("fromDate")+"'";
     		}
     		
     		if(request.getParameter("toDate") != ""){
     			if(query.equals("select * from transactions where ")){
     				query += " trans_date <= '"+request.getParameter("toDate")+"'";
     			}
     			else query += " and trans_date <= '"+request.getParameter("toDate")+"'";
     		}
     		
     		Statement stmt = con.createStatement();
     		ResultSet rs = stmt.executeQuery(query);
     		%> <table class="reportTable"><tr><th>User</th><th>Item ID</th><th>Quantity</th><th>Total Price</th><th>Transaction Date</th></tr><%
     		while(rs.next()){
     			%><tr><td><%=rs.getString("buyer_usrname")%></td>
     			<td><%= rs.getString("item_id")%></td>
     			<td><%= rs.getInt("qty_bought")%></td>
     			<td><%= rs.getDouble("tot_price")%></td>
     			<td><%= rs.getDate("trans_date")%></td>
     			</tr>
     			<%
     		}
     		%></table>
     		<%
     	}
     	catch(Exception ex){
     		System.out.println(ex.toString());
     	}
     %>
</section>


<%@ include file="footer.html"%>
</body>
</html>