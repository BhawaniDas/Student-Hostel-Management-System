package com.shms.controller;

import com.shms.dao.UserDAO;
import com.shms.model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String role = request.getParameter("role");

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setName(name);
        user.setContact(contact);
        user.setAddress(address);
        user.setRole(role);

        UserDAO dao = new UserDAO();
        try {
			dao.insertUser(user);
		} catch (SQLException e) {
			// TODO Auto-generated catch blocks
			e.printStackTrace();
		}
        response.sendRedirect("AdminDashboardServlet");
    }
}