package com.shms.controller;

import com.shms.dao.StudentDAO;
import com.shms.model.Student;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class FeePageServlet extends HttpServlet {

    private boolean hasFeePagePermission(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        return username != null && role != null &&
                (role.equalsIgnoreCase("warden") || role.equalsIgnoreCase("superintendent"));
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasFeePagePermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            List<Student> students = new StudentDAO().getAllStudents(); // Assumes you have this method
            req.setAttribute("students", students);
            req.getRequestDispatcher("add_fee.jsp").forward(req, resp);
        } catch (Exception e) {
            session.setAttribute("error", "Could not load students list!");
            resp.sendRedirect("StudentListServlet");
        }
    }
}
