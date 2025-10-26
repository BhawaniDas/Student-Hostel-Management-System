package com.shms.controller;

import com.shms.dao.RoomDAO;
import com.shms.model.Room;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class EditRoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        RoomDAO dao = new RoomDAO();
        Room room = null;
		try {
			room = dao.getRoomById(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        req.setAttribute("room", room);
        req.getRequestDispatcher("edit_room.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String roomNo = req.getParameter("room_no");
            String floor = req.getParameter("floor");
            int capacity = Integer.parseInt(req.getParameter("capacity"));
            Room room = new Room();
            room.setId(id);
            room.setRoomNo(roomNo);
            room.setFloor(floor);
            room.setCapacity(capacity);
            RoomDAO dao = new RoomDAO();
            dao.updateRoom(room);
            req.getSession().setAttribute("message", "Room updated successfully!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Failed to update room!");
        }
        resp.sendRedirect("RoomListServlet");
    }
}