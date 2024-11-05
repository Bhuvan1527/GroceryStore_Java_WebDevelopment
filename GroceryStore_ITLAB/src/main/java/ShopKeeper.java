import java.sql.*;

public class ShopKeeper {
	private String usrname;
	private String passwd;
	private String name;
	
	ShopKeeper(){
		
	}
	
	ShopKeeper(String un, String pass, String name){
		this.usrname = un;
		this.passwd = pass;
		this.name = name;
	}
	
	int signUp(String un, String pass, String name){
		DataBaseCon db = new DataBaseCon();
		
		try {
			Connection con = db.getConnection();
			String query = "select username from shopkeeper where username = '"+un+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				return 1;
			}
			else {
				query = "insert into shopkeeper values (?,?,?)";
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, un);
				ps.setString(2, pass);
				ps.setString(3, name);
				ps.executeUpdate();
				return 0;
			}
		}
		catch(Exception ex) {
			return -1;
		}
	}
	
	int login(String usr, String pass) {
		DataBaseCon db = new DataBaseCon();
		try {
			Connection con = db.getConnection();
			String query = "select * from shopkeeper where username = '"+usr+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next() && rs.getString("username").equals(usr)) {
				if(rs.getString("passwd").equals(pass)) {
					return 0;
				}
				else {
					return 2;
				}
			}
			else {
				return 1;
			}
		}
		catch(Exception ex) {
			return -1;
		}
	}
	
	int delete(String usr) {
		DataBaseCon db = new DataBaseCon();
		try {
			Connection con = db.getConnection();
			String query = "select * from shopkeeper where username = '"+usr+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				query = "delete from shopkeeper where username = '"+usr+"'";
				stmt.execute(query);
				return 0;
			}
			else {
				return 1;
			}
		}
		catch(Exception ex) {
			return -1;
		}
	}
	
	String getShopKeeperName(String usr) {
		String name ="";
		DataBaseCon db = new DataBaseCon();
		try {
			Connection con = db.getConnection();
			String query = "select * from shopkeeper where username = '"+usr+"'";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				name = rs.getString("shopkeeper_name");
			}
		}
		catch(Exception ec) {
			// do nothing
			name = null;
		}
		
		return name;
	}
}
