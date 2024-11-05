

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddItem
 */
@WebServlet("/AddItem")
public class AddItem extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddItem() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int ans = new GroceryItem().updateItemQuantity(Integer.parseInt(request.getParameter("itemId")), Integer.parseInt(request.getParameter("itemQty")));
		if(ans == 0){
			response.sendRedirect("shop.jsp?mesg=Successfully Updated the Quantity of the item.");
		}
		else if(ans == 1) {
			response.sendRedirect("shop.jsp?mesg=Item with the given ID is not Found.");
		}
		else {
			response.sendRedirect("shop.jsp?mesg=Error in mysql server");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		if(new GroceryItem().addItem(request.getParameter("add-item-name"), request.getParameter("add-item-category"), request.getParameter("add-item-image"), Integer.parseInt(request.getParameter("add-item-qty")), Double.parseDouble(request.getParameter("add-item-price")), request.getParameter("add-item-desc"))){
			response.sendRedirect("shop.jsp?mesg=Successfully Added the item.");
		}
		else {
			response.sendRedirect("shop.jsp?mesg=Error");
		}
	}

}
