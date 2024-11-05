<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Bill</title>

<link href="style2.css" rel="stylesheet">
</head>
<body>

<% String bill = (String)request.getAttribute("bill"); 
	String name = (String)request.getSession().getAttribute("name");
%>

<div class="navbar">
        <a class="navbar-brand" href="#">NLEGS</a>
        <ul class="nav-right">
            <li class="nav-item"><a class="nav-link" href="shop.jsp">Shop</a></li>
            <li class="nav-item"><a href="#cart" class="nav-link"><img
					class="icns" src="images/cart.png" onclick="showCart()"></a></li>
            <li class="nav-item"><a href="Logout" class="nav-link">Logout</a></li>
            <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
        </ul>
    </div>
    <section class="bill-table con">
    <table class="bill"><tr><th>S.No</th><th>Item</th><th>Quantity</th><th>Item price</th><th>Price</th></tr>
    	<h1 class="bg-limegreen">Thank you for Purchasing. Here is your Bill.</h1>
    	<%= bill %>
    	</table>
    </section>
    
    <script src="openClose.jsp"></script>
    <%@ include file="cart.html" %>
    <%@ include file="footer.html" %>
</body>
</html>