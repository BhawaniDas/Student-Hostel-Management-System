package com.shms.controller;

import com.shms.dao.UserDAO;
import com.shms.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String originalUsername = request.getParameter("originalUsername");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        User updatedUser = new User();
        updatedUser.setUsername(username);
        updatedUser.setPassword(password);
        updatedUser.setEmail(email);
        updatedUser.setName(name);
        updatedUser.setContact(contact);
        updatedUser.setAddress(address);
        updatedUser.setRole(role);

        UserDAO dao = new UserDAO();
        try {
            dao.updateUser(updatedUser);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Update Failed!");
        }
        response.sendRedirect("AdminDashboardServlet");
    }
}
