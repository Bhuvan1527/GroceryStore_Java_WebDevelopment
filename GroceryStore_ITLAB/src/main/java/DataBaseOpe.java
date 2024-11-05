import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;



public class DataBaseOpe {
	private Connection con;
	private DataBaseCon db;
	
	
	DataBaseOpe(){
		this.db = new DataBaseCon();
	}
	
	int buyerLogin(String usrName, String pass) {
		int ans = 0;
		try{
			this.con = this.db.getConnection();
			String query = "SELECT * FROM buyer WHERE username = '"+usrName+"'";
			Statement stmt1 = this.con.createStatement();
			ResultSet rs = stmt1.executeQuery(query);
			if(rs.next()) {	
				//out.println(rs.getString(1));
				if(usrName.equals(rs.getString("username"))) {
					if(pass.equals(rs.getString("passwd"))) {
						ans = 0;
						//path = "shop.jsp";
						//response.sendRedirect("shop.jsp");
					}
					else {
						ans = 1;
						//path = "main.jsp?passwdErr=Incorrect Password";
					}
					//response.sendRedirect("main.jsp?passwdErr=Incorrect Password");
				}
				else {
					ans = 2;
					//path = "main.jsp?usrnameErr=Incorrect Usrname";
					//response.sendRedirect("main.jsp?usrnameErr=Incorrect Usrname");
				}
			}
			else {
				ans = 3;
				//path = "main.jsp?usrnameErr=Incorrect Usrname";
				//response.sendRedirect("main.jsp?loginErr=Please Sign Up First");
			}
			db.closeConnection();
		}
		catch(Exception exc) {
			ans = -1;
			//path = "main.jsp?loginErr=There seems to be an issue, please wait and reload";
		}
		return ans;
	}
	
	
	int buyerSignUp(String usrName, String passwd, String email, String name, String address) {
		int ans = 0;
		try{
			this.con = this.db.getConnection();
			//Enumeration<String> paraNames = request.getParameterNames();
			String query = "SELECT username FROM buyer WHERE username = '"+usrName+"'";
			Statement stmt1 = this.con.createStatement();
			ResultSet rs = stmt1.executeQuery(query);
			if(rs.next()) {
				//request.setAttribute("signUpError", "Select a different a userName");
				//out.println("<h1>Select a different a UserName</h1>");
				ans = 1;
				//path = "main.jsp?signUpErr=Select a different a user name";
			}
			else {
				
				query = "INSERT INTO buyer VALUES (?,?,?,?,?)";
				PreparedStatement ps = this.con.prepareStatement(query);
				ps.setString(1, usrName);
				ps.setString(2, passwd);
				ps.setString(3, email);
				ps.setString(4, name);
				ps.setString(5, address);
				ps.executeUpdate();
				ans = 0;
				//path = "shop.jsp";
			}
			db.closeConnection();
			this.con.close();
		}
		catch(Exception exc) {
			ans = -1;
		}
		
		return ans;
	}
	
	
	String getBuyerName(String usr) {
		String name ="";
		try {
			this.con = this.db.getConnection();
			String query = "select * from buyer where username = '"+usr+"'";
			Statement stmt = this.con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				name = rs.getString("buyer_name");
			}
		}
		catch(Exception ec) {
			// do nothing
			name = null;
		}
		
		return name;
	}
	
	
	
}
