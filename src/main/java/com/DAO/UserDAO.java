package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.UserModel;
import com.utility.DBConnection;

public class UserDAO {

	Connection con = null;
	String status = "fail";
	DBConnection db = new DBConnection();

	public String insertUser(UserModel um) {

		try {
			con = db.getConnection();

			if (con == null) {
				System.out.println("Database connection is NULL");
				return "fail";
			}

			String query = "INSERT INTO users " + "(Fullname, email, passwordkey, age, gender) "
					+ "VALUES (?, ?, ?, ?, ?)";

			PreparedStatement ps = con.prepareStatement(query);

			ps.setString(1, um.getName());
			ps.setString(2, um.getEmail());
			ps.setString(3, um.getPassword());
			ps.setInt(4, um.getAge());
			ps.setString(5, um.getGender());

			int n = ps.executeUpdate();

			if (n > 0) {
				status = "success";
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return status;
	}

	public String validateUser(String email, String passwordKey) {

		con = db.getConnection();

		String query = "SELECT * FROM users WHERE email = ? AND passwordkey = ?";

		try {
			PreparedStatement st = con.prepareStatement(query);

			st.setString(1, email);
			st.setString(2, passwordKey);

			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				System.out.println("Valid user from UserDAO");
				status = "success";
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return status;
	}
	
	// =====================================================
	// GET ALL NORMAL USERS
	// =====================================================

	public List<UserModel> getAllUsers() {

	
		List<UserModel> users = new ArrayList<>();

		String sql = "SELECT Fullname, email, age, gender, rol, status "
		           + "FROM users "
		           + "WHERE rol = 'USER'";

		con = db.getConnection();

		try {

		    PreparedStatement ps = con.prepareStatement(sql);

		    ResultSet rs = ps.executeQuery();

		    while (rs.next()) {

		        UserModel user = new UserModel();

		        user.setName(rs.getString("Fullname"));
		        user.setEmail(rs.getString("email"));
		        user.setAge(rs.getInt("age"));
		        user.setGender(rs.getString("gender"));
		        user.setRol(rs.getString("rol"));
		        user.setStatus(rs.getString("status"));

		        users.add(user);
		    }

		    rs.close();
		    ps.close();
		    con.close();

		} catch (Exception e) {

		    e.printStackTrace();
		}

		return users;
	

		}


	// =====================================================
	// ACTIVATE USER
	// =====================================================

	public boolean activateUser(String email) {

	
		boolean result = false;

		String sql = "UPDATE users "
		           + "SET status = 'Active' "
		           + "WHERE email = ? AND rol = 'USER'";

		con = db.getConnection();

		try {

		    PreparedStatement ps = con.prepareStatement(sql);

		    ps.setString(1, email);

		    int rows = ps.executeUpdate();

		    if (rows > 0) {
		        result = true;
		    }

		    ps.close();
		    con.close();

		} catch (Exception e) {

		    e.printStackTrace();
		}

		return result;


		}



	// =====================================================
	// DELETE USER
	// =====================================================

	public boolean deleteUser(String email) {

	    boolean result = false;

	    String sql = "DELETE FROM users "
	               + "WHERE email = ? AND rol = 'USER'";

	    con = db.getConnection();

	    try {

	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, email);

	        int rows = ps.executeUpdate();

	        if (rows > 0) {
	            result = true;
	        }

	        ps.close();
	        con.close();

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return result;
	}
	
	public String validateAdmin(String fullname, String passwordKey) {

	    con = db.getConnection();

	    String query = "SELECT * FROM users "
	                 + "WHERE Fullname = ? "
	                 + "AND passwordkey = ? "
	                 + "AND rol = 'ADMIN'";

	    try {

	        PreparedStatement st = con.prepareStatement(query);

	        st.setString(1, fullname);
	        st.setString(2, passwordKey);

	        ResultSet rs = st.executeQuery();

	        if (rs.next()) {

	            System.out.println("Valid admin found");
	            status = "success";
	        }

	    } catch (SQLException e) {

	        e.printStackTrace();
	    }

	    return status;
	}
	
	public String getUserNameByEmail(String email) {

	    String fullname = null;

	    con = db.getConnection();

	    String query = "SELECT Fullname FROM users WHERE email = ?";

	    try {

	        PreparedStatement ps = con.prepareStatement(query);

	        ps.setString(1, email);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            fullname = rs.getString("Fullname");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return fullname;
	}
}
