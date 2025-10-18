package com.shms.dao;

import com.shms.model.User;
import com.shms.util.JDBCUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // Validate user for login
    public User validateUser(String username, String password, String role) {
        User user = null;
        try {
            Connection con = JDBCUtils.getConnection();
            String sql = "SELECT * FROM user WHERE username=? AND password=? AND role=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                user.setContact(rs.getString("contact"));
                user.setAddress(rs.getString("address"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // List all users for admin table
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        try {
            Connection con = JDBCUtils.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM user");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                user.setContact(rs.getString("contact"));
                user.setAddress(rs.getString("address"));
                users.add(user);
            }
            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return users;
    }

    // Get single user (for edit form)
    public User getUserByUsername(String username) {
        User user = null;
        try {
            Connection con = JDBCUtils.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM user WHERE username=?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setEmail(rs.getString("email"));
                user.setName(rs.getString("name"));
                user.setContact(rs.getString("contact"));
                user.setAddress(rs.getString("address"));
            }
            rs.close();
            ps.close();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Get user name using roll number (username)
    public String getNameByRollNo(String rollNo) {
        String name = "";
        try {
            Connection con = JDBCUtils.getConnection();
            String sql = "SELECT name FROM user WHERE username = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, rollNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    // Update user (for admin edit)
    public void updateUser(User updatedUser) throws SQLException {
        String sql = "UPDATE user SET password=?, role=?, email=?, name=?, contact=?, address=? WHERE username=?";
        try (
            Connection con = JDBCUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, updatedUser.getPassword());
            ps.setString(2, updatedUser.getRole());
            ps.setString(3, updatedUser.getEmail());
            ps.setString(4, updatedUser.getName());
            ps.setString(5, updatedUser.getContact());
            ps.setString(6, updatedUser.getAddress());
            ps.setString(7, updatedUser.getUsername());
            ps.executeUpdate();
        }
    }

    // Insert user with all details
    public int insertUser(User user) throws SQLException {
        int userId = 0;
        String sql = "INSERT INTO user (username, password, role, email, name, contact, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getName());
            ps.setString(6, user.getContact());
            ps.setString(7, user.getAddress());
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    userId = generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }
        }
        return userId;
    }

    // Delete user by username
    public void deleteUser(String username) throws SQLException {
        String sql = "DELETE FROM user WHERE username = ?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();
        }
    }
}
