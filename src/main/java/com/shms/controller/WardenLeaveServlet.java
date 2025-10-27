package com.shms.controller;

import com.shms.dao.LeaveApplicationDAO;
import com.shms.model.LeaveApplication;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/WardenLeaveServlet")
public class WardenLeaveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // Check session and role
        if (session == null || !"warden".equals(session.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            LeaveApplicationDAO dao = new LeaveApplicationDAO();
            List<LeaveApplication> pending = dao.getPendingLeaves();
            req.setAttribute("pendingLeaves", pending);
            req.getRequestDispatcher("warden_leave_review.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch pending leaves.");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // Check session and role for post as well
        if (session == null || !"warden".equals(session.getAttribute("role"))) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String status = req.getParameter("status");
            String remarks = req.getParameter("remarks");
            LeaveApplicationDAO dao = new LeaveApplicationDAO();
            dao.updateLeaveStatus(id, status, remarks);
            resp.sendRedirect("WardenLeaveServlet"); // Reloads updated list
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update leave status.");
        }
    }
}