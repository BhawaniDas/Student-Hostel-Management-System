package com.shms.controller;

import com.shms.dao.StudentDAO;
import com.shms.dao.RoomAllocationDAO;
import com.shms.dao.RoomDAO;
import com.shms.dao.FeePaymentDAO;
import com.shms.model.Student;
import com.shms.model.Room;
import com.shms.model.RoomAllocation;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

public class StudentListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // --- Session Access Control ---
        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        String username = (session != null) ? (String) session.getAttribute("username") : null;

        if (session == null || username == null || role == null ||
            !(role.equalsIgnoreCase("student") || role.equalsIgnoreCase("warden") || role.equalsIgnoreCase("superintendent"))) {
            resp.sendRedirect("login.jsp");
            return;
        }
        // --- Session Control End ---

        try {
            int pageSize = 10;
            int mypage = 1;
            if (req.getParameter("page") != null) {
                mypage = Integer.parseInt(req.getParameter("page"));
            }
            int offset = (mypage - 1) * pageSize;

            String searchType = req.getParameter("searchType");
            String query = req.getParameter("query");
            String rollNo = null, name = null, contact = null;
            boolean validSearch = false;
            if (query != null && searchType != null && !query.trim().isEmpty()) {
                String safeQuery = query.replaceAll("[^a-zA-Z0-9_@.\\s-]", "");
                if (safeQuery.equals(query)) {
                    if ("roll_no".equals(searchType)) rollNo = safeQuery;
                    if ("name".equals(searchType)) name = safeQuery;
                    if ("contact".equals(searchType)) contact = safeQuery;
                    validSearch = true;
                }
            }

            StudentDAO studentDao = new StudentDAO();
            RoomAllocationDAO allocationDao = new RoomAllocationDAO();
            RoomDAO roomDao = new RoomDAO();
            FeePaymentDAO feeDao = new FeePaymentDAO();

            List<Student> students = validSearch ?
                studentDao.getStudentsByPage(offset, pageSize, rollNo, name, contact) :
                studentDao.getStudentsByPage(offset, pageSize, null, null, null);

            int totalRecords = studentDao.getStudentCount(rollNo, name, contact);
            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            // Dynamically update amount paid and status for each student
            double requiredFee = 10000; // Set to your required total fee
            for (Student s : students) {
                double totalPaid = feeDao.getTotalPaidByStudent(s.getId());
                s.setTotalFeePaid(totalPaid);
                s.setFeeStatus(totalPaid >= requiredFee ? "Paid" : "Pending");
            }

            Map<Integer, List<RoomAllocation>> allocationsMap = new HashMap<>();
            for (Student s : students) {
                List<RoomAllocation> allocs = allocationDao.getAllocationsByStudent(s.getId());
                allocationsMap.put(s.getId(), allocs == null ? new ArrayList<RoomAllocation>() : allocs);
            }

            List<Room> roomList = roomDao.getAllRooms();
            Map<Integer, Room> roomMap = new HashMap<>();
            for (Room r : roomList) {
                roomMap.put(r.getId(), r);
            }

            req.setAttribute("students", students);
            req.setAttribute("allocationsMap", allocationsMap);
            req.setAttribute("roomMap", roomMap);
            req.setAttribute("mypage", mypage);
            req.setAttribute("totalPages", totalPages);
            req.getRequestDispatcher("list_students.jsp").forward(req, resp);

        } catch (Exception ex) {
            req.setAttribute("error", "Error loading student list: " + ex.getMessage());
            req.setAttribute("students", new ArrayList<Student>());
            req.setAttribute("allocationsMap", new HashMap<Integer, List<RoomAllocation>>());
            req.setAttribute("roomMap", new HashMap<Integer, Room>());
            req.getRequestDispatcher("list_students.jsp").forward(req, resp);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
