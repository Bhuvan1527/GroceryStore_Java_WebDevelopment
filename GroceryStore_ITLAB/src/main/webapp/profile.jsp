<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile</title>
<link href="style1.css" rel="stylesheet">
</head>
<body>
<div class="navbar">
        <a class="navbar-brand" href="#">NLEGS</a>
        <ul class="nav-right">
            <li class="nav-item"><a class="nav-link" href="shop.jsp">Shop</a></li>
            <li class="nav-item"><a href="profile.jsp" class="nav-link"><img class="icns" src="images/profile.png"></a></li>
            <li class="nav-item"><a href="#cart" class="nav-link"><img class="icns" src="images/cart.png"  onclick="displayForm('cart');"></a></li>
            <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
        </ul>
    </div>

<%@ include file="cart.html" %>
<%@ include file="footer.html" %>
<script src="openClose.js"></script>
</body>
</html>