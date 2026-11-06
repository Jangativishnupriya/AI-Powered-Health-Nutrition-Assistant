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

    DBConnection db = new DBConnection();

    // ==========================================
    // INSERT USER
    // ==========================================

    public String insertUser(UserModel um) {

        String result = "fail";

        String query = "INSERT INTO users "
                + "(Fullname, email, passwordkey, age, gender) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            if (con == null) {
                return "fail";
            }

            ps.setString(1, um.getName());
            ps.setString(2, um.getEmail());
            ps.setString(3, um.getPassword());
            ps.setInt(4, um.getAge());
            ps.setString(5, um.getGender());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                result = "success";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // ==========================================
    // VALIDATE USER
    // ==========================================

    public String validateUser(String email, String passwordKey) {

        String result = "fail";

        String query = "SELECT * FROM users "
                + "WHERE email = ? AND passwordkey = ?";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);
            ps.setString(2, passwordKey);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    System.out.println("Valid user from UserDAO");
                    result = "success";
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    // ==========================================
    // GET ALL NORMAL USERS
    // ==========================================

    public List<UserModel> getAllUsers() {

        List<UserModel> users = new ArrayList<>();

        String sql = "SELECT Fullname, email, age, gender, rol, status, "
                + "CASE "
                + "WHEN last_activity IS NOT NULL "
                + "AND last_activity >= CURRENT_TIMESTAMP - INTERVAL 2 MINUTE "
                + "THEN 'Active' "
                + "ELSE 'Inactive' "
                + "END AS activity_status "
                + "FROM users WHERE rol = 'USER'";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                UserModel user = new UserModel();

                user.setName(rs.getString("Fullname"));
                user.setEmail(rs.getString("email"));
                user.setAge(rs.getInt("age"));
                user.setGender(rs.getString("gender"));
                user.setRol(rs.getString("rol"));
                user.setStatus(rs.getString("status"));

                // Set live activity status
                user.setActivityStatus(
                        rs.getString("activity_status"));

                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    // ==========================================
    // UPDATE USER LAST ACTIVITY
    // ==========================================

    public void updateLastActivity(String email) {

        String sql = "UPDATE users "
                + "SET last_activity = CURRENT_TIMESTAMP "
                + "WHERE email = ? AND rol = 'USER'";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ==========================================
    // MARK USER INACTIVE
    // ==========================================

    public void markInactive(String email) {

        String sql = "UPDATE users "
                + "SET last_activity = NULL "
                + "WHERE email = ? AND rol = 'USER'";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ==========================================
    // DELETE USER
    // ==========================================

    public boolean deleteUser(String email) {

        String sql = "DELETE FROM users "
                + "WHERE email = ? AND rol = 'USER'";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    // ==========================================
    // VALIDATE ADMIN
    // ==========================================

    public String validateAdmin(String fullname, String passwordKey) {

        String result = "fail";

        String query = "SELECT * FROM users "
                + "WHERE Fullname = ? "
                + "AND passwordkey = ? "
                + "AND rol = 'ADMIN'";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, fullname);
            ps.setString(2, passwordKey);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    System.out.println("Valid admin found");
                    result = "success";
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    // ==========================================
    // GET USER NAME BY EMAIL
    // ==========================================

    public String getUserNameByEmail(String email) {

        String fullname = null;

        String query = "SELECT Fullname FROM users WHERE email = ?";

        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    fullname = rs.getString("Fullname");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return fullname;
    }
}
