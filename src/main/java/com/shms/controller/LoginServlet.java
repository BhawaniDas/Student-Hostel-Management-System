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
        // Pass all three: username, password, and role!
        User user = userDao.validateUser(username, password, role);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("role", user.getRole()); // Store role for later

            switch (user.getRole()) {
                case "admin":
                    response.sendRedirect("AdminDashboardServlet");
                    break;
                case "superintendent":
                    response.sendRedirect("SuperintendentDashboardServlet");
                    break;
                case "warden":
                    response.sendRedirect("WardenDashboardServlet");
                    break;
                case "student":
                    response.sendRedirect("StudentDashboardServlet");
                    break;
                default:
                    response.sendRedirect("login.jsp?error=Invalid+role");
            }
        } else {
            response.sendRedirect("login.jsp?error=Invalid+username+or+password+or+role");
        }
    }
}
