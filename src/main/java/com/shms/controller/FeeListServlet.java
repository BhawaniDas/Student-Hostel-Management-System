package com.shms.controller;

import com.shms.dao.FeePaymentDAO;
import com.shms.dao.StudentDAO;
import com.shms.model.FeePayment;
import com.shms.model.Student;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class FeeListServlet extends HttpServlet {

    private boolean hasFeeViewPermission(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        return username != null && role != null &&
                (role.equalsIgnoreCase("warden") || role.equalsIgnoreCase("superintendent"));
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasFeeViewPermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
        try {
            FeePaymentDAO feeDao = new FeePaymentDAO();
            StudentDAO studentDao = new StudentDAO();
            List<FeePayment> payments = feeDao.getAllPayments();

            // Prepare a map of studentId -> Student for quick lookup in JSP
            List<Student> students = studentDao.getAllStudents();
            Map<Integer, Student> studentMap = new HashMap<>();
            for (Student s : students) {
                studentMap.put(s.getId(), s);
            }

            req.setAttribute("payments", payments);
            req.setAttribute("studentMap", studentMap);
            req.getRequestDispatcher("fee_list.jsp").forward(req, resp);
        } catch (Exception e) {
            req.setAttribute("error", "Error loading payments: " + e.getMessage());
            req.setAttribute("payments", null);
            req.setAttribute("studentMap", null);
            req.getRequestDispatcher("fee_list.jsp").forward(req, resp);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (!hasFeeViewPermission(session)) {
            resp.sendRedirect("login.jsp");
            return;
        }
        doGet(req, resp);
    }
}