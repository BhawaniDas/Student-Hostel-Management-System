package com.shms.controller;

import com.shms.dao.LeaveApplicationDAO;
import com.shms.model.LeaveApplication;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/StudentViewLeaveServlet")
public class StudentViewLeaveServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Use false to avoid creating a new session if none exists
        HttpSession session = req.getSession(false);

        // Session validation: only allow access if student is logged in
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp"); // Redirect to login page if session is invalid
            return;
        }

        String rollNo = (String) session.getAttribute("username");

        try {
            LeaveApplicationDAO dao = new LeaveApplicationDAO();
            List<LeaveApplication> myLeaves = dao.getLeavesByRollNo(rollNo);
            req.setAttribute("leaves", myLeaves);
            req.getRequestDispatcher("student_view_leave.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch your leave applications.");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // For viewing, just call doGet
        doGet(req, resp);
    }
}