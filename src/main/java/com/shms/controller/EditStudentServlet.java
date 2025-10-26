package com.shms.controller;

import com.shms.dao.StudentDAO;
import com.shms.model.Student;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;

@WebServlet("/EditStudentServlet")
public class EditStudentServlet extends HttpServlet {

    // Session check helper method
    private boolean hasEditPermission(HttpSession session) {
        if (session == null) return false;
        String role = (String) session.getAttribute("role");
        String username = (String) session.getAttribute("username");
        return username != null && role != null &&
                (role.equalsIgnoreCase("warden") || role.equalsIgnoreCase("superintendent"));
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasEditPermission(session)) {
            response.sendRedirect("login.jsp");
            return;
        }
        String idStr = request.getParameter("id");
        if (idStr == null) {
            session.setAttribute("error", "No student selected for editing.");
            response.sendRedirect("StudentListServlet");
            return;
        }
        try {
            int id = Integer.parseInt(idStr);
            StudentDAO dao = new StudentDAO();
            Student student = dao.getStudentById(id);
            if (student == null) {
                session.setAttribute("error", "Student not found.");
                response.sendRedirect("StudentListServlet");
                return;
            }
            request.setAttribute("student", student);
            RequestDispatcher dispatcher = request.getRequestDispatcher("edit_student.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error loading student for edit.");
            response.sendRedirect("StudentListServlet");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (!hasEditPermission(session)) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String rollNo = request.getParameter("roll_no");
            String name = request.getParameter("name");
            String contact = request.getParameter("contact");
            String address = request.getParameter("address");

            // Validate roll number: must be 6 digits
            if (rollNo == null || !rollNo.matches("\\d{6}")) {
                session.setAttribute("error", "Invalid roll number! Must be exactly 6 digits.");
                response.sendRedirect("EditStudentServlet?id=" + id);
                return;
            }

            Student student = new Student();
            student.setId(id);
            student.setRollNo(rollNo);
            student.setName(name);
            student.setContact(contact);
            student.setAddress(address);

            StudentDAO dao = new StudentDAO();
            boolean updated = dao.updateStudent(student);

            if (updated) {
                session.setAttribute("message", "Student updated successfully!");
                response.sendRedirect("StudentListServlet");
            } else {
                session.setAttribute("error", "Failed to update student.");
                response.sendRedirect("EditStudentServlet?id=" + id);
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Failed to update student.");
            response.sendRedirect("EditStudentServlet?id=" + request.getParameter("id"));
        }
    }
}