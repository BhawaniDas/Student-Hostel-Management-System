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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            FeePaymentDAO feeDao = new FeePaymentDAO();
            StudentDAO studentDao = new StudentDAO();
            List<FeePayment> payments = feeDao.getAllPayments();

            // Prepare a map of studentId -> Student for quick lookup in JSP
            List<Student> students = studentDao.getAllStudents(); // Implement getAllStudents() if not yet
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
        doGet(req, resp);
    }
}
