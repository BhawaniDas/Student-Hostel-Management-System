package com.shms.dao;

import com.shms.model.Student;
import com.shms.util.JDBCUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAO {

    // Insert new student (no user_id)
    public void insertStudent(Student student) throws SQLException {
        String sql = "INSERT INTO student (roll_no, name, contact, address, fee_status) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, student.getRollNo());
            ps.setString(2, student.getName());
            ps.setString(3, student.getContact());
            ps.setString(4, student.getAddress());
            ps.setString(5, student.getFeeStatus());
            ps.executeUpdate();
        }
    }

    // Update (edit) existing student details (no user_ids)
    public boolean updateStudent(Student student) {
        int rows = 0;
        String sql = "UPDATE student SET roll_no=?, name=?, contact=?, address=?, fee_status=? WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, student.getRollNo());
            ps.setString(2, student.getName());
            ps.setString(3, student.getContact());
            ps.setString(4, student.getAddress());
            ps.setString(5, student.getFeeStatus());
            ps.setInt(6, student.getId());
            rows = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return rows == 1;
    }

    // Update only the fee_status
    public boolean updateFeeStatus(int studentId, String feeStatus) {
        boolean success = false;
        String sql = "UPDATE student SET fee_status = ? WHERE id = ?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, feeStatus);
            ps.setInt(2, studentId);
            success = ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Get all students including fee_status
    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setRollNo(rs.getString("roll_no"));
                student.setName(rs.getString("name"));
                student.setContact(rs.getString("contact"));
                student.setAddress(rs.getString("address"));
                student.setFeeStatus(rs.getString("fee_status"));
                students.add(student);
            }
        }
        return students;
    }

    // Search students by optional filters (rollNo, name, contact)
    public List<Student> searchStudents(String rollNo, String name, String contact) throws SQLException {
        List<Student> students = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM student WHERE 1=1");
        if (rollNo != null && !rollNo.trim().isEmpty()) sql.append(" AND roll_no LIKE ?");
        if (name != null && !name.trim().isEmpty()) sql.append(" AND name LIKE ?");
        if (contact != null && !contact.trim().isEmpty()) sql.append(" AND contact LIKE ?");
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (rollNo != null && !rollNo.trim().isEmpty())
                ps.setString(paramIndex++, "%" + rollNo.trim() + "%");
            if (name != null && !name.trim().isEmpty())
                ps.setString(paramIndex++, "%" + name.trim() + "%");
            if (contact != null && !contact.trim().isEmpty())
                ps.setString(paramIndex++, "%" + contact.trim() + "%");
            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setRollNo(rs.getString("roll_no"));
                    student.setName(rs.getString("name"));
                    student.setContact(rs.getString("contact"));
                    student.setAddress(rs.getString("address"));
                    student.setFeeStatus(rs.getString("fee_status"));
                    students.add(student);
                }
            }
        }
        return students;
    }

    // Get students for pagination (with fee status)
    public List<Student> getStudentsByPage(int offset, int pageSize, String rollNo, String name, String contact) throws SQLException {
        List<Student> students = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM student WHERE 1=1");
        if (rollNo != null && !rollNo.trim().isEmpty()) sql.append(" AND roll_no LIKE ?");
        if (name != null && !name.trim().isEmpty()) sql.append(" AND name LIKE ?");
        if (contact != null && !contact.trim().isEmpty()) sql.append(" AND contact LIKE ?");
        sql.append(" LIMIT ? OFFSET ?");
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (rollNo != null && !rollNo.trim().isEmpty())
                ps.setString(paramIndex++, "%" + rollNo.trim() + "%");
            if (name != null && !name.trim().isEmpty())
                ps.setString(paramIndex++, "%" + name.trim() + "%");
            if (contact != null && !contact.trim().isEmpty())
                ps.setString(paramIndex++, "%" + contact.trim() + "%");
            ps.setInt(paramIndex++, pageSize);
            ps.setInt(paramIndex++, offset);
            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setRollNo(rs.getString("roll_no"));
                    student.setName(rs.getString("name"));
                    student.setContact(rs.getString("contact"));
                    student.setAddress(rs.getString("address"));
                    student.setFeeStatus(rs.getString("fee_status"));
                    students.add(student);
                }
            }
        }
        return students;
    }

    // Count students for pagination
    public int getStudentCount(String rollNo, String name, String contact) throws SQLException {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM student WHERE 1=1");
        if (rollNo != null && !rollNo.trim().isEmpty()) sql.append(" AND roll_no LIKE ?");
        if (name != null && !name.trim().isEmpty()) sql.append(" AND name LIKE ?");
        if (contact != null && !contact.trim().isEmpty()) sql.append(" AND contact LIKE ?");
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            int paramIndex = 1;
            if (rollNo != null && !rollNo.trim().isEmpty())
                ps.setString(paramIndex++, "%" + rollNo.trim() + "%");
            if (name != null && !name.trim().isEmpty())
                ps.setString(paramIndex++, "%" + name.trim() + "%");
            if (contact != null && !contact.trim().isEmpty())
                ps.setString(paramIndex++, "%" + contact.trim() + "%");
            try(ResultSet rs = ps.executeQuery()) {
                if (rs.next()) count = rs.getInt(1);
            }
        }
        return count;
    }

    // Get student by id (includes fee status)
    public Student getStudentById(int id) throws SQLException {
        String sql = "SELECT * FROM student WHERE id = ?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setRollNo(rs.getString("roll_no"));
                    student.setName(rs.getString("name"));
                    student.setContact(rs.getString("contact"));
                    student.setAddress(rs.getString("address"));
                    student.setFeeStatus(rs.getString("fee_status"));
                    return student;
                }
            }
        }
        return null;
    }

    // Delete student by id
    public boolean deleteStudent(int studentId) throws SQLException {
        String sql = "DELETE FROM student WHERE id = ?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
