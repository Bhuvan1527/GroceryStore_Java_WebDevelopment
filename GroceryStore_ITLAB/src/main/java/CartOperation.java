

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CartOperation
 */
@WebServlet("/CartOperation")
public class CartOperation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartOperation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		DataBaseCon dbc = new DataBaseCon();
		String usr = (String)request.getSession().getAttribute("usrname");
		try {
			Connection con = dbc.getConnection();
			String query = "select * from cartView where usrname = '"+usr+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			out.append("<ol>");
			while(rs.next()) {
				out.append("<li><div class='cart-item'><img class='cart-img' src='"+rs.getString("item_img")+"' alt='Image Not Found'/>");
				out.append("<div class='cart-desc'><p class='cart-item-desc'>Qty: "+rs.getInt("qty")+"</p>");
				out.append("<p class='cart-item-desc'>Price: "+rs.getDouble("price")+"</p></div>");
				out.append("<button class='cart-item-button' onclick=\"deleteCartItem("+rs.getInt("item_id")+")\" >Delete</button></div></li>");
			}
			out.append("</ol>");
			con.close();
			//dbc.closeConnection();
		}
		catch(Exception ex) {
			out.append("Unable to Load the cart");
			ex.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		int ans = new GroceryItem().addItemToCart((String)request.getSession().getAttribute("usrname"), Integer.parseInt(request.getParameter("add")), Integer.parseInt(request.getParameter("quantity")));
		if(ans == -1) {
			response.sendRedirect("shop.jsp?mesg=Error is SQL Server, Try after some time");
		}
		else {
			response.sendRedirect("shop.jsp?mesg="+ans+" successfully added to cart.");
		}
		
		
	}

}
