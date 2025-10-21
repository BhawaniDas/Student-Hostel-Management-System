package com.shms.controller;

import com.shms.dao.FeePaymentDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteFeeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            FeePaymentDAO dao = new FeePaymentDAO();
            dao.deletePayment(id);
            req.getSession().setAttribute("message", "Feee payment deleted successfully!!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Could not delete payment: " + e.getMessage());
        }
        resp.sendRedirect("FeeListServlet");
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
