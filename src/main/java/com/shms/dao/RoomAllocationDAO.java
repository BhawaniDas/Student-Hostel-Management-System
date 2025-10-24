package com.shms.dao;

import com.shms.model.RoomAllocation;
import com.shms.util.JDBCUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomAllocationDAO {

    // Allocate a room
    public void allocateRoom(RoomAllocation alloc) throws SQLException {
        String sql = "INSERT INTO room_allocation (room_id, student_id, date_from, date_to) VALUES (?, ?, ?, ?)";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, alloc.getRoomId());
            ps.setInt(2, alloc.getStudentId());
            ps.setDate(3, new java.sql.Date(alloc.getDateFrom().getTime()));
            ps.setDate(4, new java.sql.Date(alloc.getDateTo().getTime()));
            ps.executeUpdate();
        }
        new RoomDAO().incrementOccupancy(alloc.getRoomId());
    }

    // Get allocations for a student
    public List<RoomAllocation> getAllocationsByStudent(int studentId) throws SQLException {
        List<RoomAllocation> allocations = new ArrayList<>();
        String sql = "SELECT * FROM room_allocation WHERE student_id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoomAllocation alloc = new RoomAllocation();
                    alloc.setId(rs.getInt("id"));
                    alloc.setRoomId(rs.getInt("room_id"));
                    alloc.setStudentId(rs.getInt("student_id"));
                    alloc.setDateFrom(rs.getDate("date_from"));
                    alloc.setDateTo(rs.getDate("date_to"));
                    allocations.add(alloc);
                }
            }
        }
        return allocations;
    }

    // Delete allocation by ID (decrement occupancy)
    public void deleteAllocation(int allocationId) throws SQLException {
        int roomId = getRoomIdByAllocationId(allocationId);
        String sql = "DELETE FROM room_allocation WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, allocationId);
            ps.executeUpdate();
        }
        if (roomId > 0) {
            new RoomDAO().decrementOccupancy(roomId);
        }
    }

    // Get roomId from allocation ID
    public int getRoomIdByAllocationId(int allocationId) throws SQLException {
        int roomId = 0;
        String sql = "SELECT room_id FROM room_allocation WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, allocationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    roomId = rs.getInt("room_id");
                }
            }
        }
        return roomId;
    }

    // Delete all allocations for a student
    public void deleteAllocationsByStudentId(int studentId) throws SQLException {
        // For proper occupancy management, first decrement occupancy
        List<RoomAllocation> allocations = getAllocationsByStudent(studentId);
        for (RoomAllocation alloc : allocations) {
            new RoomDAO().decrementOccupancy(alloc.getRoomId());
        }
        String sql = "DELETE FROM room_allocation WHERE student_id = ?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.executeUpdate();
        }
    }
}
