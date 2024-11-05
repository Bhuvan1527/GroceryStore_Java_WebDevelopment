<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.Cookie" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>E-Grocery Store</title>
<link href="style1.css" rel="stylesheet">
</head>
<body>
	<div class="navbar">
        <a class="navbar-brand" href="#">NLEGS</a>
        <ul class="nav-right">
            <li class="nav-item"><a class="nav-link" href="shop.jsp">Shop</a></li>
            <li class="nav-item"><a class="nav-link" href="#signup" onclick="displayForm('signup')">SignUp</a></li>
            <li class="nav-item"><a class="nav-link" href="#login" onclick="displayForm('login')">Login</a></li>
            <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
        </ul>
    </div>
    <section class="bg-white">
        <div class="con flex-container">
            <div class="flex-item-50 text-white font-size-large" style="color:darkcyan; flex-grow: 3;">
                <span style="font-size:50px; font-weight:600;">Welcome</span> to our e-grocery Store.
                You need not stand in a line to take your items home, we will deliver your items to your home.
                You just have to sign up and add items to your Cart and check.<br> Isn't that easy?
            </div>
            <div class="flex-item-50" style="flex-grow: 7;">
                <img id="ecomm" src="images/ecommerce.png">
            </div>
        </div>
    </section>
    <section class="bg-limegreen">
        <div class="con adv flex-container" style="flex-direction:column;">
            <p style="font-size:70px; color: crimson; font-weight: 900;">Upto 50% Off <span style="font-size:medium;">On Prepared foods</span></p>
        </div>
        <section id="login" class="formSec">
        
                <form class="form-auth" name="loginForm" method="get" action="login" accept-charset="utf-8" onsubmit="return loginValidate()">
                    <h2 class="text-center">Login Form <a href=""><img src="images/close.png" style="float:right;" onclick="formclose('login')"></a></h2>
                    <span id="loginErr" class="err"></span>
                    <%
                    	if(request.getParameter("loginErr") != null){
                    		%><h2 class="text-center err"><%= request.getParameter("loginErr") %></h2><%
                    	}
                    %>
                    <div>
                        User Name: <input type="text" name="loginUsrname" placeholder="Enter your username">
                    </div>
                    <%
                    	if(request.getParameter("usrnameErr") != null){
                    		%><p class="err" style="font-size:small;"><%= request.getParameter("usrnameErr") %></p><%
                    	}
                    %>
                    <div>
                        Password:<input type="password" name="loginPasswd" placeholder="atleast 8 characters">
                    </div>
                    <%
                    	if(request.getParameter("passwdErr") != null){
                    		%><p class="err" style="font-size:small;"><%= request.getParameter("passwdErr") %></p><%
                    	}
                    %>
                    <div>
                    	User Type:
                    	<select name="userType">
                    		<option value="buyer" selected>buyer</option>
                    		<option value="shp">shopkeeper</option>
                    	</select>
                    </div>
                    <div>
                        <button class="submit" type="submit" value="Login">Login</button>
                    </div>
                </form>
            
        </section>
        <section id="signup" class="formSec" >
            <form  class="form-auth" name="signUpForm" method="post" onsubmit="return signUpValidate()" action="addBuyer" accept-charset="utf-8" style="height:80vh ;overflow:scroll;">
                <h2 class="text-center">Sign Up Form <a href=""><img src="images/close.png" style="float:right;" onclick="formclose('signup')"></a></h2>
                <span id="signupErr" class="err"></span>
				<%
					if(request.getParameter("signUpErr") != null){
						%><h2 class="text-center err"><%= request.getParameter("signUpErr") %></h2><%
					}
				%>               
                <div>
                    User Name: <input type="text" name="signUpUsrname" placeholder="Enter your username">
                </div>
                <div>
                    Password:<input type="password" name="signUpPasswd" placeholder="atleast 8 characters">
                </div>
                <div>
                	Email: <input type="email" name="signUpEmail" placeholder="example@gmail.com">
                </div>
                <div>Name: <input type="text" name="signUpname" placeholder="Name of the Buyer"></div>
                <div>Address: </div>
                <div><textarea name="signUpAddress" rows="10" cols="50" placeholder="enter your address, eg: plotno:xxx, yyyy colony, near zzzz, Hyderabad"></textarea></div>
                <div>
                    <button class="submit" type="submit" value="SignUp">SignUp</button>
                </div>
            </form>
        
    </section>
        <div class="slideshow-container">

            <!-- Full-width images with number and caption text -->
            <div class="mySlides fade">
                <div class="numbertext">1 / 3</div>
                <img src="images/slideshow1.jpg" style="width:100%">
                <div class="slide-caption">Caption Text</div>
            </div>

            <div class="mySlides fade">
                <div class="numbertext">2 / 3</div>
                <img src="images/slideshow2.jpg" style="width:100%">
                <div class="slide-caption">Caption Two</div>
            </div>

            <div class="mySlides fade">
                <div class="numbertext">3 / 3</div>
                <img src="images/slideshow3.jpg" style="width:100%">
                <div class="slide-caption">Caption Three</div>
            </div>

            <!-- Next and previous buttons -->
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
        <br>

        <!-- The dots/circles -->
        <div style="text-align:center">
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(3)"></span>
        </div>

    </section>
    <section class="bg-grey">
        <div class="con flex-container padding-20" style="justify-content:space-evenly;">
            <div class="flex-item bg-bright offers" >
                <h3 class="text-center underline">Delivery</h3>
                <ul>
                    <li>We deliver your items at your doorstep</li>
                    <li>Free delivery for orders above 500/-</li>
                </ul>
            </div>
            <div class="flex-item bg-bright offers">
                <h3 class="text-center underline">Member Ship offers</h3>
                <ul>
                    <li>6 months member ship at just 499/-</li>
                    <li>Higher discount on selected items</li>
                </ul>
            </div>
        </div>
    </section>

    <%@ include file="footer.html" %>
	<script type="text/javascript" src="openClose.js"></script>
</body>
</html>