package com.shms.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/SuperintendentDashboardServlet")
public class SuperintendentDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"superintendent".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("WEB-INF/superintendent_dashboard.jsp").forward(request, response);
    }
}