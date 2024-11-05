<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>NLEGS/Shop</title>
<link href="style2.css" rel="stylesheet">
</head>
<body  onload="showItems()">
	<div class="navbar">
		<a class="navbar-brand" href="main.jsp">NLEGS</a>
		<ul class="nav-right">
			<li class="nav-item"><a href="Logout" class="nav-link">Logout</a></li>
			<%
            String name = (String)request.getSession().getAttribute("name");
    		String type = (String)request.getSession().getAttribute("type");
            	if(type != null && type.equals("buyer")){
            		%>
			<li class="nav-item"><a href="#cart" class="nav-link"><img
					class="icns" src="images/cart.png" onclick="showCart()"></a></li>
			<%
            	}
            %>

			<li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
		</ul>
	</div>



	<section>
		<div class="con">
			<%
        		
        		if(name != null){
        			name = "Welcome Back "+ name; //+"<br>Add Items to your Cart";
        			if(type != null && type.equals("buyer")){
        				name = name + "<br>Add Items to your Cart";
        			}
        		}
        		else{
        			name = "Welcome User";
        		}
        	%>
			<h1 class="text-center" style="margin: 2%; padding: 2%">
				Hello,
				<%= name %></h1>

			<div>
				Show-Items: <select id="item_count">
					<option value="10"onclick="showItems()">10</option>
					<option value="5"onclick="showItems()">5</option>
					<option value="15"onclick="showItems()">15</option>
					<option value="20"onclick="showItems()">20</option>
				</select>
				<%
				if(request.getParameter("mesg") != null){
					%>
				<h2 class="text-center msgSk"><%= request.getParameter("mesg") %></h2>
				<%
				}
            		if(type != null && type.equals("shpkp")){
            			
				
			%>

				<div class="con flex-container "
					style="justify-content: space-evenly;">
					<a class="flex-item" href="#add-item"><button
							class="shpkpLogin" type="button"
							onclick="displayForm('add-item');">Press to Add Items</button></a> 
					<a class="flex-item" href="#report"><button class="shpkpLogin"
							type="button" onclick="displayForm('report')">Report</button></a>
				</div>
				<div class="shopkep-forms con">
					<!-- For to Add grocery Items -->
					<form  action="AddItem" method="post" id="add-item" onsubmit="return addItemValidate()">
						<h2 class="text-center underline">
							Add Item <a class="float-right" href=""><img
								src="images/close.png"></a>
						</h2>
						<span id="add-item-err" class="err"></span>
						<div class="flex-container" style="justify-content: flex-start;">
							<!-- 					<div class="flex-item"> -->
							<!-- 						Item-ID: <input type="number" name="add-item-id" -->
							<!-- 							style="min-width: 40%" placeholder="Item Id"> -->
							<!-- 					</div> -->
							<div class="flex-item">
								Item-Name: <input type="text" name="add-item-name"
									style="min-width: 40%" placeholder="Item Name">
							</div>
							<div class="flex-item">
								Item-Category: <select name="add-item-category">
									<option value="default">Select a category</option>
									<option value="Prepared Food">Prepared Food</option>
									<option value="Snack">Snack</option>
									<option value="Diary">Dairy</option>
									<option value="Bewerage">Bewerage</option>
									<option value="Chocolate">Chocolate</option>
									<option value="Personal Use">Personal Use</option>
								</select>
							</div>
						</div>
						<div class="flex-container-col">

							<div class="flex-item-col">
								Item-Image: <input type="text" placeholder="image file name"
									name="add-item-image">
							</div>
							<div class="flex-item-col flex-container">
								<div class="flex-item">
									Item-Quantity: <input type="number" name="add-item-qty"
										style="max-width: 40%" placeholder="quantity">
								</div>
								<div class="flex-item">
									Item-Price: <input type="text" name="add-item-price"
										style="max-width: 40%" placeholder="price">
								</div>
							</div>
						</div>
						<div class="flex-container-col">
							<div class="flex-item-col">Item-Description:</div>
							<div class="flex-item-col">
								<textarea rows="5" cols="30"
									placeholder="Describe the grocery item" name="add-item-desc"></textarea>
							</div>
							<div class="flex-item-col">
								<button type="submit">Add</button>
							</div>
						</div>
					</form>

					<form action="AddItem" method="get" id="update-qty">
						<h2 class="text-center underline">
							Update Qty of an Item <a class="float-right" href=""><img
								src="images/close.png"></a>
						</h2>
						<div class="flex-container-col" style="flex-direction: column;">
							Item-ID: <input class="flex-item-col" type="number" name="itemId" />
							Item-Qty: <input class="flex-item-col" type="number"
								name="itemQty" />
						</div>
						<div class="flex-container-col">
							<button class="flex-item-col" type="submit">Update</button>
						</div>
					</form>
					
					<form action="report.jsp" method="get" id="report">
						<h2 class="text-center underline">
							Report <a class="float-right" href=""><img
								src="images/close.png"></a>
						</h2>
						<div class="flex-container-col" style="flex-direction: column;">
							Buyer User Name: <input class="flex-item-col" type="text" name="buyerUsrname" />
							from Date: <input class="flex-item-col" type="Date"
								name="fromDate" />
								to Date: <input class="flex-item-col" type="Date" name="toDate"/>
						</div>
						<div class="flex-container-col">
							<button class="flex-item-col" type="submit">Get Report</button>
						</div>
					</form>
				</div>
				<%           			
            			
            		}
            	%>
				<form name="searchForm" class="form-filter flex-container">

					<input class="flex-item" type="search"
						placeholder="search by item name" name="searchItem">
					<button class="flex-item" type="button" value="Search"
						onclick="showItems()">Search</button>

				</form>
			</div>
			<div>
				
	
<div id="groceryItemsDiv">
				
				</div>
			</div>
		</div>
		
		<div class="text-center">
			<div class="pagination" id="pagination">
				<!-- <a href='#'>&laquo;</a> <a href="#">1</a> <a href="#">2</a> <a
					href="#">3</a> <a href="#">4</a> <a href="#">5</a> <a href="#">6</a> -->
				
			</div>
		</div>
	</section>
	<%@ include file="cart.html"%>
	<%@ include file="footer.html"%>
	<script src="openClose.js"></script>
	
</body>
</html>