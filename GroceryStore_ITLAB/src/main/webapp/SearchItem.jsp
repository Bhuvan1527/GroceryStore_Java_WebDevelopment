<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ page import="java.sql.*"%>
<table class="grocery-items">
	<thead class="grocery-items-head">
		<tr>

			<th>Item</th>
			<th>Name</th>
			<th>Description</th>
			<th>Stock Available</th>
			<th>Price</th>
			<th>Category</th>
			<th>Cart</th>
		</tr>
	</thead>



	<tbody>
		<%
		String type = (String) request.getSession().getAttribute("type");
		String url = "jdbc:mysql://localhost:3306/itLabAss";
		String user = "root";
		String pass = "Bala@123";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, user, pass);
			String query;
			Statement stmt = con.createStatement();
			ResultSet rs;
			int pageNum;
			if (request.getParameter("searchItem") == null || request.getParameter("searchItem") == "") {
				if (request.getParameter("pageCount") == null) {
			query = "select * from grocery_items limit " + request.getParameter("count");
				} else {
			pageNum = Integer.parseInt(request.getParameter("pageCount"));
			pageNum = (pageNum - 1) * Integer.parseInt(request.getParameter("count"));
			query = "select * from grocery_items limit " + request.getParameter("count") + " offset " + pageNum;
				}
			} else {
				if (request.getParameter("pageCount") == null) {
			query = "select * from grocery_items where item_name LIKE '%" + request.getParameter("searchItem")
					+ "%' limit " + request.getParameter("count");
				} else {
			pageNum = Integer.parseInt(request.getParameter("pageCount"));
			pageNum = (pageNum - 1) * Integer.parseInt(request.getParameter("count"));
			query = "select * from grocery_items where item_name LIKE '%" + request.getParameter("searchItem")
					+ "%' limit " + request.getParameter("count") + " offset " + pageNum;
				}
			}
			rs = stmt.executeQuery(query);
			while (rs.next()) {
		%><tr>
			<td><img src="<%=rs.getString("item_img")%>"
				alt="no Image Found"></td>
			<td><%=rs.getString("item_category")%></td>
			<td><%=rs.getString("item_name")%></td>
			<td><%=rs.getString("item_desc")%></td>
			<td><%=rs.getInt("item_stock")%></td>
			<td><%=rs.getDouble("item_price")%></td>
			<td>
				<%
				if (type != null && type.equals("buyer")) {
				%>
				<p id="cart-err" class="text-center err"></p>
				<form name="cart-form" action="CartOperation" method="POST"
					class="addtocart-form flex-container" onsubmit="return addCartCheck()">
					<input class="flex-item" type="number" name="quantity" value="1"
						style="width: 25%;">
					<button class="flex-item ac" type="submit" name="add"
						value="<%=rs.getInt("item_id")%>">Add</button>
				</form> <%
 } else {
 if (type != null && type.equals("shpkp")) {
 %>
				<form action="AddItem" method="get"
					class="addtocart-form flex-container">
					<input class="flex-item" type="number" name="itemQty" value="1"
						style="width: 25%;">
					<button class="flex-item ac" type="submit" name="itemId"
						value="<%=rs.getInt("item_id")%>">Update</button>
				</form> <%
 }
 %> <%
 }
 %>
			</td>
		</tr>
		<%
		}
		con.close();
		} catch (SQLException exc) {
		exc.printStackTrace();
		} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
		}
		%>

	</tbody>
</table>
