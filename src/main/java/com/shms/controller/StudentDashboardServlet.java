package com.shms.controller;

import com.shms.dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"student".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Fetch student name based on roll number (username)
        String rollNo = (String) session.getAttribute("username");
        UserDAO userDao = new UserDAO();
        String studentName = userDao.getNameByRollNo(rollNo);
        request.setAttribute("studentName", studentName);

        request.getRequestDispatcher("WEB-INF/student_dashboard.jsp").forward(request, response);
    }
}
