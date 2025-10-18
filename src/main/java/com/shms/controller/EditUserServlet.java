package com.shms.controller;

import com.shms.dao.UserDAO;
import com.shms.model.User;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/EditUserServlet")
public class EditUserServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        return username != null && role != null && role.equalsIgnoreCase("admin");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect("login.jsp");
            return;
        }
        String username = request.getParameter("username");
        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username);
        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("edit_user.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) {
            response.sendRedirect("login.jsp");
            return;
        }
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
            dao.updateUser(user);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("AdminDashboardServlet");
    }
}
