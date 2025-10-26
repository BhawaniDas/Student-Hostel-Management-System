package com.shms.controller;

import com.shms.dao.LeaveApplicationDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/StudentLeaveApplyServlet")
public class StudentLeaveApplyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get the session and user info
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }
        String rollNo = (String) session.getAttribute("username");

        // Get leave form parameters
        String fromDate = req.getParameter("from_date");
        String toDate = req.getParameter("to_date");
        String reason = req.getParameter("reason");
        String guardianNumber = req.getParameter("guardian_number");

        // Input validation (basic)
        if (fromDate == null || toDate == null || reason == null || guardianNumber == null
                || fromDate.isEmpty() || toDate.isEmpty() || reason.isEmpty() || guardianNumber.isEmpty()) {
            resp.sendRedirect("student_apply_leave.jsp?error=1");
            return;
        }
        try {
            // Call DAO to insert leave
            LeaveApplicationDAO dao = new LeaveApplicationDAO();
            dao.addLeave(reason, fromDate, toDate, "Pending", guardianNumber, rollNo);

            // Redirect to dashboard or leave view page with success message
            resp.sendRedirect("StudentViewLeaveServlet?success=1");


        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("student_apply_leave.jsp?error=db");
        }
    }
}