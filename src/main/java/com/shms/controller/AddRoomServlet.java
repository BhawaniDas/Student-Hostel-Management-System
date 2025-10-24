package com.shms.controller;

import com.shms.dao.RoomDAO;
import com.shms.model.Room;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
//room servlet
public class AddRoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String roomNo = req.getParameter("room_no");
            String floor = req.getParameter("floor");
            int capacity = Integer.parseInt(req.getParameter("capacity"));
            Room room = new Room();
            room.setRoomNo(roomNo);
            room.setFloor(floor);
            room.setCapacity(capacity);
            RoomDAO dao = new RoomDAO();
            dao.insertRoom(room);
            req.getSession().setAttribute("message", "Room added successfully!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Failed to add room!");
        }
        resp.sendRedirect("RoomListServlet");
    }
}