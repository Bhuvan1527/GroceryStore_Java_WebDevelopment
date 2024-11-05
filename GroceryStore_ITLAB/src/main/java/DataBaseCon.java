
import java.sql.*;

public class DataBaseCon {
	private String url;// = "jdbc:mysql://localhost:3306/itLabAss"
	private String user;
	private String pass;
	private Connection c;
	
	public DataBaseCon(){
		this.url = "jdbc:mysql://localhost:3306/itLabAss";
		this.user = "root";
		this.pass = "Bala@123";
	}
	
	public Connection getConnection() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		this.c = DriverManager.getConnection(this.url, this.user, this.pass);
		return this.c;
	}
	
	public void closeConnection() throws SQLException{
		this.c.close();
	}
}
