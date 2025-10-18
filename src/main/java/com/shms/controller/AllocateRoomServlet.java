package com.shms.controller;

import com.shms.dao.RoomAllocationDAO;
import com.shms.dao.RoomDAO;
import com.shms.dao.StudentDAO;
import com.shms.model.Room;
import com.shms.model.Student;
import com.shms.model.RoomAllocation;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;

public class AllocateRoomServlet extends HttpServlet {
    // Helper to check session role
    private boolean hasRoomAllocationPermission(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        return username != null && role != null &&
                (role.equalsIgnoreCase("warden") || role.equalsIgnoreCase("superintendent"));
    }

    // Show allocation form with students and rooms
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasRoomAllocationPermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
        RoomDAO roomDao = new RoomDAO();
        StudentDAO studentDao = new StudentDAO();
        List<Room> rooms = null;
        try {
            rooms = roomDao.getAllRooms();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<Student> students = null;
        try {
            students = studentDao.getAllStudents();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        req.setAttribute("rooms", rooms);
        req.setAttribute("students", students);
        req.getRequestDispatcher("allocate_room.jsp").forward(req, resp);
    }

    // Handle allocation submit
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasRoomAllocationPermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
        int roomId = Integer.parseInt(req.getParameter("room_id"));
        int studentId = Integer.parseInt(req.getParameter("student_id"));
        String dateFromStr = req.getParameter("date_from");
        String dateToStr = req.getParameter("date_to");
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            RoomAllocation alloc = new RoomAllocation();
            alloc.setRoomId(roomId);
            alloc.setStudentId(studentId);
            alloc.setDateFrom(sdf.parse(dateFromStr));
            alloc.setDateTo(sdf.parse(dateToStr));
            RoomAllocationDAO dao = new RoomAllocationDAO();
            dao.allocateRoom(alloc);
            session.setAttribute("message", "Room allocated successfully!");
        } catch (Exception e) {
            session.setAttribute("error", "Failed to allocate room!");
        }
        resp.sendRedirect("RoomListServlet");
    }
}
