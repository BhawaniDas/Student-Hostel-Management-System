package com.shms.controller;

import com.shms.dao.StudentDAO;
import com.shms.model.Student;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class FeePageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Student> students = new StudentDAO().getAllStudents(); // Assumes you have this method
            req.setAttribute("students", students);
            req.getRequestDispatcher("add_fee.jsp").forward(req, resp);
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Could not load students list!");
            resp.sendRedirect("StudentListServlet");
        }
    }
}
