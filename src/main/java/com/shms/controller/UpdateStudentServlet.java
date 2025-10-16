package com.shms.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shms.dao.StudentDAO;
import com.shms.model.Student;

// Import your Student and StudentDAO classes
// import your.package.Student;
// import your.package.StudentDAO;
@WebServlet("/UpdateStudentServlet")
public class UpdateStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;

    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id").trim());
            String rollNo = request.getParameter("rollNo").trim();
            String name = request.getParameter("name").trim();
            String contact = request.getParameter("contact").trim();
            String address = request.getParameter("address").trim();
            String roomAllocation = request.getParameter("roomAllocation").trim();
            double amountPaid = Double.parseDouble(request.getParameter("amountPaid").trim());
            String feeStatus = request.getParameter("feeStatus").trim();

            Student student = new Student(id, rollNo, name, contact, address, amountPaid, feeStatus);

            boolean success = studentDAO.updateStudent(student);

            if (success) {
                response.sendRedirect("StudentListServlet?update=success");
            } else {
                response.sendRedirect("StudentListServlet?update=failure");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("StudentListServlet?update=failure");
        }
    }
}
