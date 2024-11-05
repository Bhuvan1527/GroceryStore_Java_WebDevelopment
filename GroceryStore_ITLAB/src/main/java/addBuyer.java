

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class check
 */
@WebServlet("/addBuyer")
public class addBuyer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	    /**
     * @see HttpServlet#HttpServlet()
     */
    public addBuyer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DataBaseOpe dbo = new DataBaseOpe();
		
		int res = dbo.buyerLogin(request.getParameter("loginUsrname"), request.getParameter("loginPasswd"));
		//System.out.println("eneterd buyer login ");
		if(res == 0) {
			HttpSession session = request.getSession();
			synchronized (session) {
				session.setAttribute("usrname", request.getParameter("loginUsrname"));
				session.setAttribute("name", dbo.getBuyerName(request.getParameter("loginUsrname")));
				session.setAttribute("type", "buyer");
			}
			response.sendRedirect("shop.jsp");
		}
		else if(res == 1) {
			response.sendRedirect("main.jsp?passwdErr=Incorrect Password");
		}
		else if(res == 2) {
			response.sendRedirect("main.jsp?usrnameErr=Incorrect Usrname");
		}
		else if(res == 3) {
			response.sendRedirect("main.jsp?usrnameErr=Incorrect Usrname");
		}
		else {
			response.sendRedirect("main.jsp?loginErr=There seems to be an issue, please wait and reload");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		DataBaseOpe dbo = new DataBaseOpe();
		
		int res = dbo.buyerSignUp(request.getParameter("signUpUsrname"), request.getParameter("signUpPasswd"), request.getParameter("signUpEmail"), request.getParameter("signUpname"), request.getParameter("signUpAddress"));
		
		if(res == 0) {
			HttpSession session = request.getSession();
			synchronized (session) {
				session.setAttribute("usrname", request.getParameter("signUpUsrname"));
				session.setAttribute("name",request.getParameter("signUpname"));
				session.setAttribute("type", "buyer");
			}
			response.sendRedirect("shop.jsp");
		}
		else if(res == 1) {
			response.sendRedirect("main.jsp?signUpErr=Select a different a user name");
		}
		else {
			response.sendRedirect("main.jsp?loginErr=There seems to be an issue, please wait and reload");
		}
	}

}
