package com.shms.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.shms.dao.StudentDAO;
import com.shms.dao.RoomAllocationDAO;

public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String studentIdStr = request.getParameter("id");
        if (studentIdStr != null) {
            int studentId = Integer.parseInt(studentIdStr);
            try {
                // Delete all allocations for this student to avoid constraint violation
                RoomAllocationDAO allocationDAO = new RoomAllocationDAO();
                allocationDAO.deleteAllocationsByStudentId(studentId);

                StudentDAO studentDAO = new StudentDAO();
                boolean deleted = studentDAO.deleteStudent(studentId);
                if (deleted) {
                    request.getSession().setAttribute("message", "Student deleted successfully!");
                } else {
                    request.getSession().setAttribute("error", "Failed to delete student!!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Exception while deleting student!");
            }
        } else {
            request.getSession().setAttribute("error", "Invalid student ID!");
        }
        response.sendRedirect("StudentListServlet");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}