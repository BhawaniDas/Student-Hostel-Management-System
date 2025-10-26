package com.shms.controller;
import com.shms.dao.RoomDAO;
import com.shms.model.Room;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class RoomListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ---- SESSION AND ROLE CHECK START ----
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Only allow superintendent and warden
        if (session == null || session.getAttribute("username") == null
                || role == null
                || !(role.equalsIgnoreCase("superintendent") || role.equalsIgnoreCase("warden"))) {
            resp.sendRedirect("login.jsp");
            return;
        }
        // ---- SESSION AND ROLE CHECK END ----

        try {
            RoomDAO dao = new RoomDAO();
            List<Room> rooms = dao.getAllRooms();
            req.setAttribute("rooms", rooms);
            req.getRequestDispatcher("list_rooms.jsp").forward(req, resp);
        } catch (Exception ex) {
            req.setAttribute("error", "Failed to load rooms: " + ex.getMessage());
            req.getRequestDispatcher("list_rooms.jsp").forward(req, resp);
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
