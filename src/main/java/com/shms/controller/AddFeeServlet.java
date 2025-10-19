package com.shms.controller;

import com.shms.dao.FeePaymentDAO;
import com.shms.model.FeePayment;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class AddFeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int studentId = Integer.parseInt(req.getParameter("student_id"));
            double amount = Double.parseDouble(req.getParameter("amount"));
            String feeStatus = req.getParameter("fee_status");

            FeePayment fee = new FeePayment();
            fee.setStudentId(studentId);
            fee.setAmount(amount);
            // Use java.sql.Date for database compatibility (today's date).
            java.sql.Date paymentDate = new java.sql.Date(System.currentTimeMillis());
            fee.setPaymentDate(paymentDate);
            fee.setFeeStatus(feeStatus);

            new FeePaymentDAO().addPayment(fee);
            req.getSession().setAttribute("message", "Fee payment added successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Error adding feee payment!");
        }
        resp.sendRedirect("StudentListServlet");
    }
}
