package com.shms.controller;

import com.shms.dao.FeePaymentDAO;
import com.shms.dao.StudentDAO;
import com.shms.model.FeePayment;
import com.shms.model.Student;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class EditFeeServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            FeePaymentDAO dao = new FeePaymentDAO();
            FeePayment payment = dao.getPaymentById(id);

            // Get all students for dropdown
            List<Student> students = new StudentDAO().getAllStudents();
            req.setAttribute("students", students);

            req.setAttribute("payment", payment);
            req.getRequestDispatcher("edit_fee.jsp").forward(req, resp);
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error loading payment for edit: " + e.getMessage());
            resp.sendRedirect("FeeListServlet");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            int studentId = Integer.parseInt(req.getParameter("student_id"));
            double amount = Double.parseDouble(req.getParameter("amount"));
            String paymentDateStr = req.getParameter("payment_date");
            String feeStatus = req.getParameter("fee_status");
            java.sql.Date paymentDate = java.sql.Date.valueOf(paymentDateStr);

            FeePayment payment = new FeePayment();
            payment.setId(id);
            payment.setStudentId(studentId);
            payment.setAmount(amount);
            payment.setPaymentDate(paymentDate);
            payment.setFeeStatus(feeStatus);

            FeePaymentDAO dao = new FeePaymentDAO();
            dao.updatePayment(payment);

            req.getSession().setAttribute("message", "Fee payment updated successfully!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error updating payment: " + e.getMessage());
        }
        resp.sendRedirect("FeeListServlet");
    }
}
