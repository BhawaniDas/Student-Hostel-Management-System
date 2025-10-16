package com.shms.controller;

import com.shms.dao.RoomAllocationDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteAllocationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int allocationId = Integer.parseInt(req.getParameter("allocation_id"));
            RoomAllocationDAO dao = new RoomAllocationDAO();
            dao.deleteAllocation(allocationId);
            req.getSession().setAttribute("message", "Allocation deleted!");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Failed to delete allocation!");
        }
        resp.sendRedirect("StudentListServlet");
    }
}
