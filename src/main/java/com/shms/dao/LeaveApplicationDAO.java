package com.shms.dao;

import com.shms.model.LeaveApplication;
import java.sql.*;
import java.sql.Date;
import java.util.*;

public class LeaveApplicationDAO {

    private Connection getConnection() throws SQLException {
        // Use your DBConnection utility
        // Example: return DBConnection.getConnection();
        return DriverManager.getConnection("jdbc:mysql://localhost:3306/shmsdb", "root", "chinmayadas");
    }

    public void addLeave(String reason, String fromDate, String toDate,
                         String status, String guardianNumber, String rollNo) throws SQLException {
        String sql = "INSERT INTO leave_applications (reason, from_date, to_date, status, guardian_number, roll_no) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, reason);
            stmt.setDate(2, Date.valueOf(fromDate));
            stmt.setDate(3, Date.valueOf(toDate));
            stmt.setString(4, status);
            stmt.setString(5, guardianNumber);
            stmt.setString(6, rollNo);
            stmt.executeUpdate();
        }
    }

    public List<LeaveApplication> getPendingLeaves() throws SQLException {
        List<LeaveApplication> list = new ArrayList<>();
        String sql = "SELECT * FROM leave_applications WHERE status = 'Pending'";
        try (Connection conn = getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                LeaveApplication leave = buildLeaveFromResultSet(rs);
                list.add(leave);
            }
        }
        return list;
    }

    public void updateLeaveStatus(int id, String status, String remarks) throws SQLException {
        String sql = "UPDATE leave_applications SET status = ?, remarks = ? WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setString(2, remarks);
            stmt.setInt(3, id);
            stmt.executeUpdate();
        }
    }

    public List<LeaveApplication> getLeavesByRollNo(String rollNo) throws SQLException {
        List<LeaveApplication> list = new ArrayList<>();
        String sql = "SELECT * FROM leave_applications WHERE roll_no = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, rollNo);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                LeaveApplication leave = buildLeaveFromResultSet(rs);
                list.add(leave);
            }
        }
        return list;
    }

    private LeaveApplication buildLeaveFromResultSet(ResultSet rs) throws SQLException {
        LeaveApplication leave = new LeaveApplication();
        leave.setId(rs.getInt("id"));
        leave.setReason(rs.getString("reason"));
        leave.setFromDate(rs.getDate("from_date"));
        leave.setToDate(rs.getDate("to_date"));
        leave.setStatus(rs.getString("status"));
        leave.setGuardianNumber(rs.getString("guardian_number"));
        leave.setRollNo(rs.getString("roll_no"));
        leave.setRemarks(rs.getString("remarks"));
        return leave;
    }
}
