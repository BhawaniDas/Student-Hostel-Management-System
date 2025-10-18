package com.shms.controller;

import com.shms.dao.RoomDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteRoomServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            RoomDAO dao = new RoomDAO();
            dao.deleteRoom(id);
            req.getSession().setAttribute("message", "Room deleted!!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Delete failed!");
        }
        resp.sendRedirect("RoomListServlet");
    }
}
