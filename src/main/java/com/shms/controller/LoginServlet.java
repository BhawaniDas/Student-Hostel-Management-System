package com.shms.controller;

import com.shms.model.User;
import com.shms.dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // Get role from login form

        UserDAO userDao = new UserDAO();
        // Validate user by username, password, role
        User user = userDao.validateUser(username, password, role);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("username", user.getUsername()); // student's rollNo or warden's username
            session.setAttribute("role", user.getRole().toLowerCase().trim()); // store normalized role

            // Optional: set more info, e.g. session.setAttribute("name", user.getName());

            switch (user.getRole().toLowerCase().trim()) {
                case "admin":
                    response.sendRedirect("AdminDashboardServlet");
                    break;
                case "superintendent":
                    response.sendRedirect("SuperintendentDashboardServlet");
                    break;
                case "warden":
                    // For warden-specific dashboards
                    // username can be warden login or ID as needed
                    response.sendRedirect("WardenDashboardServlet");
                    break;
                case "student":
                    // For students, username is rollNo
                    response.sendRedirect("StudentDashboardServlet");
                    break;
                default:
                    // Invalid role after authentication
                    session.invalidate();
                    response.sendRedirect("login.jsp?error=Invalid+role");
            }
        } else {
            // Failed login
            response.sendRedirect("login.jsp?error=Invalid+username+or+password+or+role");
        }
    }
}