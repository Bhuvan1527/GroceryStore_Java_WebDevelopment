<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ page import="java.sql.*" %>
<%
				String url = "jdbc:mysql://localhost:3306/itLabAss";
				String user = "root";
				String pass = "Bala@123";
				int pageCount = 0;
				int itemCount = Integer.parseInt(request.getParameter("count"));
				try{
					Class.forName("com.mysql.cj.jdbc.Driver");
					Connection con = DriverManager.getConnection(url, user, pass);
					String query;
					if(request.getParameter("searchItem") == null || request.getParameter("searchItem") == ""){
						query = "select count(*) from grocery_items";
					}
					else{
						query = "select count(*) from grocery_items where item_name LIKE '%"+request.getParameter("searchItem")+"%'";
					}
					
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(query);
					if(rs.next()){
						pageCount = rs.getInt("count(*)");
						if(pageCount % itemCount == 0)pageCount /= itemCount;
						else{
							if(pageCount > itemCount) pageCount = pageCount / itemCount + 1;
							else pageCount = 1;
						}
						%> <a href='#'>&laquo;</a> <%
						for(int i = 1; i <= pageCount;i++){
							%> <a onclick="nextItems(<%= i %>)"><%= i %></a><%
						}
						%><a href="#">&raquo;</a><%
					}
					
					
				}
				catch(Exception ex){
					ex.printStackTrace();
				}
				%>