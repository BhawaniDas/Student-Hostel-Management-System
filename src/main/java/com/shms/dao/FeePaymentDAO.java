package com.shms.dao;

import com.shms.model.FeePayment;
import com.shms.util.JDBCUtils;
import java.sql.*;
import java.util.*;

public class FeePaymentDAO {

    // Add payment
    public void addPayment(FeePayment fee) throws SQLException {
        String sql = "INSERT INTO fee_payment (student_id, amount, payment_date, fee_status) VALUES (?, ?, ?, ?)";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, fee.getStudentId());
            ps.setDouble(2, fee.getAmount());
            ps.setDate(3, new java.sql.Date(fee.getPaymentDate().getTime()));
            ps.setString(4, fee.getFeeStatus());
            ps.executeUpdate();
        }
    }

    // Edit/Update payment
    public void updatePayment(FeePayment fee) throws SQLException {
        String sql = "UPDATE fee_payment SET student_id=?, amount=?, payment_date=?, fee_status=? WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, fee.getStudentId());
            ps.setDouble(2, fee.getAmount());
            ps.setDate(3, new java.sql.Date(fee.getPaymentDate().getTime()));
            ps.setString(4, fee.getFeeStatus());
            ps.setInt(5, fee.getId());
            ps.executeUpdate();
        }
    }

    // Delete payment
    public void deletePayment(int id) throws SQLException {
        String sql = "DELETE FROM fee_payment WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    // Sum of all payments for a studentss
    public double getTotalPaidByStudent(int studentId) throws SQLException {
        double totalPaid = 0.0;
        String sql = "SELECT IFNULL(SUM(amount), 0) FROM fee_payment WHERE student_id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) totalPaid = rs.getDouble(1);
            rs.close();
        }
        return totalPaid;
    }

    // Get all payments for a student (including status)
    public List<FeePayment> getPaymentsByStudent(int studentId) throws SQLException {
        List<FeePayment> payments = new ArrayList<>();
        String sql = "SELECT * FROM fee_payment WHERE student_id=? ORDER BY payment_date DESC";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FeePayment fee = new FeePayment();
                    fee.setId(rs.getInt("id"));
                    fee.setStudentId(rs.getInt("student_id"));
                    fee.setAmount(rs.getDouble("amount"));
                    fee.setPaymentDate(rs.getDate("payment_date"));
                    fee.setFeeStatus(rs.getString("fee_status"));
                    payments.add(fee);
                }
            }
        }
        return payments;
    }

    // Get all fee payments for all students (for fee list JSP)
    public List<FeePayment> getAllPayments() throws SQLException {
        List<FeePayment> payments = new ArrayList<>();
        String sql = "SELECT * FROM fee_payment ORDER BY payment_date DESC";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                FeePayment fee = new FeePayment();
                fee.setId(rs.getInt("id"));
                fee.setStudentId(rs.getInt("student_id"));
                fee.setAmount(rs.getDouble("amount"));
                fee.setPaymentDate(rs.getDate("payment_date"));
                fee.setFeeStatus(rs.getString("fee_status"));
                payments.add(fee);
            }
        }
        return payments;
    }

    // Get single payment by id (for editing)
    public FeePayment getPaymentById(int id) throws SQLException {
        FeePayment fee = null;
        String sql = "SELECT * FROM fee_payment WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    fee = new FeePayment();
                    fee.setId(rs.getInt("id"));
                    fee.setStudentId(rs.getInt("student_id"));
                    fee.setAmount(rs.getDouble("amount"));
                    fee.setPaymentDate(rs.getDate("payment_date"));
                    fee.setFeeStatus(rs.getString("fee_status"));
                }
            }
        }
        return fee;
    }

    // Get all payments by student roll number
    public List<FeePayment> getPaymentsByRollNo(String rollNo) throws SQLException {
        List<FeePayment> payments = new ArrayList<>();
        String sql = "SELECT fp.* FROM fee_payment fp INNER JOIN student s ON fp.student_id = s.id WHERE s.roll_no = ? ORDER BY fp.payment_date DESC";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, rollNo);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FeePayment fee = new FeePayment();
                    fee.setId(rs.getInt("id"));
                    fee.setStudentId(rs.getInt("student_id"));
                    fee.setAmount(rs.getDouble("amount"));
                    fee.setPaymentDate(rs.getDate("payment_date"));
                    fee.setFeeStatus(rs.getString("fee_status"));
                    payments.add(fee);
                }
            }
        }
        return payments;
    }
}
