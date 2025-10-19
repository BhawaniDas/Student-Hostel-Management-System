package com.shms.controller;

import com.shms.dao.UserDAO;
import com.shms.dao.StudentDAO;
import com.shms.model.User;
import com.shms.model.Student;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/AddStudentServlet")
public class AddStudentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Use roll_no as username for the user tables
            String rollNo = request.getParameter("roll_no"); // 6-digit value
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String name = request.getParameter("name");
            String contact = request.getParameter("contact");
            String address = request.getParameter("address");

            // Validate required fields
            if (rollNo == null || !rollNo.matches("\\d{6}")) {
                request.getSession().setAttribute("error", "Roll number must be exactly 6 digits.");
                response.sendRedirect("add_student.jsp");
                return;
            }
            if (password == null || password.trim().isEmpty() || name == null || name.trim().isEmpty()) {
                request.getSession().setAttribute("error", "Password and Name are required.");
                response.sendRedirect("add_student.jsp");
                return;
            }

            // Create User entry for student (login)
            User user = new User();
            user.setUsername(rollNo);
            user.setPassword(password);
            user.setEmail(email);
            user.setName(name);
            user.setContact(contact);
            user.setAddress(address);
            user.setRole("student");
            UserDAO userDao = new UserDAO();
            userDao.insertUser(user);

            // Insert into Student table (no userId linkage)
            Student student = new Student();
            student.setRollNo(rollNo);
            student.setName(name);
            student.setContact(contact);
            student.setAddress(address);
            StudentDAO studentDao = new StudentDAO();
            studentDao.insertStudent(student);

            request.getSession().setAttribute("message", "Student added successfully!");
            response.sendRedirect("StudentListServlet");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Failed to add student: " + e.getMessage());
            response.sendRedirect("add_student.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("add_student.jsp");
    }
}
