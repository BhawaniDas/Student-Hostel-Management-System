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

    private boolean hasEditFeePermission(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        return username != null && role != null &&
                (role.equalsIgnoreCase("warden") || role.equalsIgnoreCase("superintendent"));
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasEditFeePermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            FeePaymentDAO dao = new FeePaymentDAO();
            FeePayment payment = dao.getPaymentById(id);

            List<Student> students = new StudentDAO().getAllStudents();
            req.setAttribute("students", students);
            req.setAttribute("payment", payment);

            req.getRequestDispatcher("edit_fee.jsp").forward(req, resp);
        } catch (Exception e) {
            session.setAttribute("error", "Error loading payment for edit: " + e.getMessage());
            resp.sendRedirect("FeeListServlet");
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasEditFeePermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
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

            session.setAttribute("message", "Fee payment updated successfully!");
        } catch (Exception e) {
            session.setAttribute("error", "Error updating payment: " + e.getMessage());
        }
        resp.sendRedirect("FeeListServlet");
    }
}
