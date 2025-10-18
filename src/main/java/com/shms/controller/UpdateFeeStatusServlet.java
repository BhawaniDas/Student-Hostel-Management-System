package com.shms.controller;

import com.shms.dao.StudentDAO;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UpdateFeeStatusServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int studentId = Integer.parseInt(req.getParameter("student_id"));
        String feeStatus = req.getParameter("fee_status");

        boolean updated = new StudentDAO().updateFeeStatus(studentId, feeStatus);

        if (updated) {
            req.getSession().setAttribute("message", "Fee status updated successfully!!");
        } else {
            req.getSession().setAttribute("error", "Failed to update fee status.");
        }
        resp.sendRedirect("StudentListServlet");
    }
}
