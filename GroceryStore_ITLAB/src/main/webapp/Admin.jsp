<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="javax.servlet.http.*" %>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin</title>
<link href="style1.css" rel="stylesheet">
</head>
<body>
<%
	//if(request.getSession(false) == null){
		session = request.getSession();
		synchronized(session){
			session.setAttribute("usrname", "admin");
			session.setAttribute("name", "Admin");
			session.setAttribute("type", "shpkp");
		}
	//}
%>
<div class="navbar">
        <a class="navbar-brand" href="">NLEGS</a>
        <ul class="nav-right">
            <li class="nav-item"><a href="profile.jsp" class="nav-link"><img class="icns" src="images/profile.png"></a></li>
            <li class="nav-item"><a class="nav-link" href="shop.jsp">Add Items</a></li>
            <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
        </ul>
    </div>
<section>
	<div class="con" style="padding-top:2%;">
		<%
				if(request.getParameter("mesg") != null){
					%> <h2 class="text-center msgSk"><%= request.getParameter("mesg") %></h2><%
				}
			%>
		<div class = "flex-container" style="justify-content: space-evenly;">
			<button type="button" onclick="displayForm('add-sk-form')">Add Shopkeeper</button>
			<button type="button" onclick="displayForm('delete-sk-form')">Delete ShopKeeper</button>
		</div>
		<div id="add-sk-form" style="display:none;">
			<form  class="form-auth" name="addskform" method="post" action="AddShopKeeper" accept-charset="utf-8" >
                <h2 class="text-center">Add Shop Keeper<a href=""><img src="images/close.png" style="float:right;" onclick="formclose('add-sk-form')"></a></h2>
                
                <div>
                    User Name: <input type="text" name="skUsrname" placeholder="Enter your username">
                </div>
                <div>
                    Password:<input type="password" name="skPasswd" placeholder="atleast 8 characters">
                </div>
                <div>Name: <input type="text" name="skName" placeholder="Name of the Shop Keeper"></div>
                <div>
                    <button class="submit" type="submit" value="signup"name ="submit">Add</button>
                </div>
            </form>
		</div>
		<div id="delete-sk-form" style="display:none;">
			<form  class="form-auth" name="deleteskform" method="post" action="AddShopKeeper" accept-charset="utf-8" >
                <h2 class="text-center">Delete Shop Keeper<a href=""><img src="images/close.png" style="float:right;" onclick="formclose('add-sk-form')"></a></h2>
                
                <div>
                    User Name: <input type="text" name="skUsrname" placeholder="Enter your username">
                </div>
                
                <div>
                    <button class="submit" type="submit" value="delete" name ="submit">Delete</button>
                </div>
            </form>
		</div>
	</div>
</section>
<script src="openClose.js"></script>
<%@ include file="footer.html" %>
</body>
</html>