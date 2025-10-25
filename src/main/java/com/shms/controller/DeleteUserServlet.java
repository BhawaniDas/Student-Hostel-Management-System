package com.shms.controller;

import com.shms.dao.UserDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        UserDAO dao = new UserDAO();
        try {
            dao.deleteUser(username);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Delete Failed!");
        }
        response.sendRedirect("AdminDashboardServlet");
    }
}