package com.shms.controller;

import javax.servlet.*;
import javax.servlet.http.*;

import com.shms.dao.UserDAO;
import com.shms.model.User;

import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDao = new UserDAO();
        List<User> userList = userDao.getAllUsers(); // Implement this method in UserDAO
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/WEB-INF/admin_dashboard.jsp").forward(request, response);
    }
}

