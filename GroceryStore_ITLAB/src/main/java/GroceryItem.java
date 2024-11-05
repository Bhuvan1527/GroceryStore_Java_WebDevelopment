import java.sql.*;

public class GroceryItem {
	private int id;
	private String category;
	private String name;
	private String description;
	private int stock;
	private double price;
	private String image;
	
	GroceryItem(){
		
	}
	
	GroceryItem(int itemId, String itemCategory, String itemName, String itemDesc, int qty, double itemPrice, String imgPath){
		this.id = itemId;
		this.category = itemCategory;
		this.name = itemName;
		this.description = itemDesc;
		this.stock = qty;
		this.price = itemPrice;
		this.image = imgPath;
	}

	
	boolean addItem(String name, String category, String imagePath, int stock, double price, String desc) {
		DataBaseCon db = new DataBaseCon();
		try {
			Connection con = db.getConnection();
			String query = "insert into grocery_items(item_category, item_name, item_desc, item_stock, item_price, item_img) values(?,?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, category);
			ps.setString(2, name);
			ps.setString(3, desc);
			ps.setInt(4, stock);
			ps.setDouble(5, price);
			ps.setString(6, "groceryItemImages/"+imagePath);
			ps.executeUpdate();
			
			con.close();
			db.closeConnection();
			return true;
		}
		catch(Exception exc) {
			System.out.println(exc.toString());
			return false;
		}
		
	}
	
	int updateItemQuantity(int itemId, int newStockCount){
		DataBaseCon db = new DataBaseCon();
		try {
			Connection con = db.getConnection();
			String query = "select item_id, item_stock from grocery_items where item_id = "+itemId;
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				newStockCount += rs.getInt("item_stock");
			}
			else {
				return 1;                 // No item with the given item_id.
			}
			query = "update grocery_items set item_stock = "+newStockCount+" where item_id = "+itemId;
			stmt.executeUpdate(query);
			con.close();
			db.closeConnection();
			return 0;                     // Successfully updated.
		}
		catch(Exception exc){
			return -1;                    // Error in SQL
		}
	}
	
	double getPrice(int itemId) throws Exception {
		DataBaseCon dbc = new DataBaseCon();
		double res = 0;
		Connection con = dbc.getConnection();
		String query = "select item_price from grocery_items where item_id = "+itemId;
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		if(rs.next()) {
			res = rs.getDouble("item_price");
		}
		con.close();
		dbc.closeConnection();
		return res;
	}
	
	String getName(int itemId) throws Exception {
		DataBaseCon dbc = new DataBaseCon();
		String res = "";
		Connection con = dbc.getConnection();
		String query = "select * from grocery_items where item_id = "+itemId;
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		if(rs.next()) {
			res = rs.getString("item_name");
			res += "<br>"+rs.getString("item_desc");
		}
		con.close();
		dbc.closeConnection();
		return res;
	}
	
	int addItemToCart(String usr, int itemId, int qty) {
		int res = 0;
		DataBaseCon dbc = new DataBaseCon();
		try {
			double price = this.getPrice(itemId);
			Connection con = dbc.getConnection();
			String q = "select buyer_usrName, item_id from cart where buyer_usrName = '"+usr+"' and item_id = "+itemId;
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(q);
			String query;
			Statement st = con.createStatement();
			if(!rs.next()) {
				query = "Insert into cart values ('"+usr+"',"+itemId+","+qty+","+price*qty+")";
				res = st.executeUpdate(query);
			}
			else {
				query = "update cart set qty_ordered = qty_ordered + "+qty+", price = price + "+price+" where buyer_usrName = '"+usr+"' and item_id = "+itemId;
				res = st.executeUpdate(query);
			}
			
			con.close();
			dbc.closeConnection();
		}
		catch(Exception ex) {
			ex.printStackTrace();
			return -1;
		}
		return res;
	}
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
}
