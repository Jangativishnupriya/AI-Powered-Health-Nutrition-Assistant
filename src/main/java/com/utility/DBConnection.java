package com.utility;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	
	public Connection getConnection() {
		
		Connection con = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/health_nutrition_assistant","root","root");
		}catch(Exception e){
			e.printStackTrace();
		}
			
		return con;
	}

}
