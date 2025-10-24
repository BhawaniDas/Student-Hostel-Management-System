package com.shms.dao;

import com.shms.model.Room;
import com.shms.util.JDBCUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    // Add room
    public void insertRoom(Room room) throws SQLException {
        String sql = "INSERT INTO room (room_no, floor, capacity, occupancy) VALUES (?, ?, ?, ?)";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, room.getRoomNo());
            ps.setString(2, room.getFloor());
            ps.setInt(3, room.getCapacity());
            ps.setInt(4, 0); // New room, occupancy is zero
            ps.executeUpdate();
        }
    }

    // Get all rooms
    public List<Room> getAllRooms() throws SQLException {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM room";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Room r = new Room();
                r.setId(rs.getInt("id"));
                r.setRoomNo(rs.getString("room_no"));
                r.setFloor(rs.getString("floor"));
                r.setCapacity(rs.getInt("capacity"));
                r.setOccupancy(rs.getInt("occupancy"));   // <--- Occupancy from DB
                rooms.add(r);
            }
        }
        return rooms;
    }

    // Get room by ID
    public Room getRoomById(int id) throws SQLException {
        String sql = "SELECT * FROM room WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Room r = new Room();
                    r.setId(rs.getInt("id"));
                    r.setRoomNo(rs.getString("room_no"));
                    r.setFloor(rs.getString("floor"));
                    r.setCapacity(rs.getInt("capacity"));
                    r.setOccupancy(rs.getInt("occupancy"));
                    return r;
                }
            }
        }
        return null;
    }

    // Update room
    public boolean updateRoom(Room room) throws SQLException {
        String sql = "UPDATE room SET room_no=?, floor=?, capacity=?, occupancy=? WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, room.getRoomNo());
            ps.setString(2, room.getFloor());
            ps.setInt(3, room.getCapacity());
            ps.setInt(4, room.getOccupancy());
            ps.setInt(5, room.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // Delete room
    public boolean deleteRoom(int id) throws SQLException {
        String sql = "DELETE FROM room WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Increment occupancy (call after allocation)
    public void incrementOccupancy(int roomId) throws SQLException {
        String sql = "UPDATE room SET occupancy = occupancy + 1 WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.executeUpdate();
        }
    }

    // Decrement occupancy (call after deallocation)
    public void decrementOccupancy(int roomId) throws SQLException {
        String sql = "UPDATE room SET occupancy = occupancy - 1 WHERE id=?";
        try (Connection con = JDBCUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.executeUpdate();
        }
    }
}
