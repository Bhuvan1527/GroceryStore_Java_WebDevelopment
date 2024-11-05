

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddShopKeeper
 */
@WebServlet("/AddShopKeeper")
public class AddShopKeeper extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddShopKeeper() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ShopKeeper sk = new ShopKeeper();
		int ans = sk.login(request.getParameter("loginUsrname"),request.getParameter("loginPasswd"));
		if(ans == 0) {
			HttpSession session = request.getSession();
			synchronized (session) {
				session.setAttribute("usrname", request.getParameter("loginUsrname"));
				session.setAttribute("name", sk.getShopKeeperName(request.getParameter("loginUsrname")));
				session.setAttribute("type", "shpkp");
			}
			response.sendRedirect("shop.jsp");
		}
		else if(ans == 1) {
			response.sendRedirect("main.jsp?usrnameErr=Incorrect User Name");
		}
		else if(ans == 2) {
			response.sendRedirect("main.jsp?passwdErr=Incorrect Password");
		}
		else {
			response.sendRedirect("main.jsp?loginErr=Error at Server Side. Please try again.");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int ans;
		if(request.getParameter("submit").equals("signup")) {
			ans = new ShopKeeper().signUp(request.getParameter("skUsrname"), request.getParameter("skPasswd"), request.getParameter("skName"));
			if(ans == 0) {
				response.sendRedirect("Admin.jsp?mesg=Successfully Added a shopKeeper");
			}
			else if (ans == 1) {
				response.sendRedirect("Admin.jsp?mesg=Select a different ShopKeeper Usrname");
			}
			else {
				response.sendRedirect("Admin.jsp?mesg=Error in Mysql Server, please for some time and reload");
			}
		}
		else {
			ans = new ShopKeeper().delete(request.getParameter("skUsrname"));
			if(ans == 0) {
				response.sendRedirect("Admin.jsp?mesg=Successfully Deleted a shopKeeper");
			}
			else if(ans == 1) {
				response.sendRedirect("Admin.jsp?mesg=ShopKeeper with given Usrname is Not Found");
			}
			else {
				response.sendRedirect("Admin.jsp?mesg=Error in Mysql Server, please for some time and reload");
			}
		}
	}
}
