

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import java.time.LocalDate; 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CartOperation2
 */
@WebServlet("/CartOperation2")
public class CartOperation2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CartOperation2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String usr = (String)request.getSession().getAttribute("usrname");
		int itemId = Integer.parseInt(request.getParameter("itemId"));
		DataBaseCon dbc = new DataBaseCon();
		try {
			Connection con = dbc.getConnection();
			String query = "delete from cart where buyer_usrName = '"+usr+"' and item_id = "+itemId;
			Statement stmt = con.createStatement();
			stmt.executeUpdate(query);
			request.getRequestDispatcher("CartOperation").forward(request, response);
		}
		catch(Exception ex) {
			response.sendRedirect("shop.jsp?mesg=Error in Mysql, please try again");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Transactions
		
		String bill = "";
		GroceryItem gi = new GroceryItem();
		String usr = (String)request.getSession().getAttribute("usrname");
		DataBaseCon dbc = new DataBaseCon();
		try {
			Connection con = dbc.getConnection();
			con.setAutoCommit(false);
			String query = "select * from cart where buyer_usrName = '"+usr+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			
			query = "insert into transactions values (?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			int c = 1;
			LocalDate today = LocalDate.now();
			double totPrice = 0.0, price;
			String itemName = "";
			while(rs.next()) {
				price = gi.getPrice(rs.getInt("item_id"));
				itemName = gi.getName(rs.getInt("item_id"));
				bill += "<tr>";
				bill += "<td>"+c+"</td>";
				bill += "<td>"+itemName+"</td>";
				bill += "<td>"+rs.getInt("qty_ordered")+"</td>";
				bill += "<td>"+price+"</td>";
				bill += "<td>"+rs.getDouble("price")+"</td></tr>";
				ps.setString(1, usr);
				ps.setInt(2,rs.getInt("item_id"));
				ps.setInt(3, rs.getInt("qty_ordered"));
				ps.setDouble(4, price);
				ps.setDouble(5, rs.getDouble("price"));
				String date = today.getYear()+"-"+today.getMonthValue()+"-"+today.getDayOfMonth();
				ps.setString(6, date);
				ps.executeUpdate();
				gi.updateItemQuantity(rs.getInt("item_id"), -rs.getInt("qty_ordered"));
				c++;
				totPrice += rs.getDouble("price");
			}
			query = "delete from cart where buyer_usrName = '"+usr+"'";
			stmt.executeUpdate(query);
			bill += "<tr><td rowspan='4'>Total Price</td><td>"+totPrice+"</td></tr>";
			con.commit();
			con.close();
			dbc.closeConnection();
			request.setAttribute("bill", bill);
			request.getRequestDispatcher("billDetails.jsp").forward(request, response);
			
		}
		catch(Exception ex) {
			ex.printStackTrace();
			response.sendRedirect("shop.jsp?mesg=Error in Mysql, Please try again after some time");
		}
		
		
	}

}
