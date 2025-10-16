<%@ page import="com.shms.dao.StudentDAO,com.shms.model.Student,com.shms.model.RoomAllocation,com.shms.model.Room,java.util.List,java.util.Map" %>
<%
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");
    if (message != null) { %>
        <p style="color:green;"><%= message %></p>
<%  session.removeAttribute("message"); }
    if (error != null) { %>
        <p style="color:red;"><%= error %></p>
<%  session.removeAttribute("error"); }

    List<Student> students = (List<Student>) request.getAttribute("students");
    Map<Integer, List<RoomAllocation>> allocationsMap = (Map<Integer, List<RoomAllocation>>) request.getAttribute("allocationsMap");
    Map<Integer, Room> roomMap = (Map<Integer, Room>) request.getAttribute("roomMap");
    Integer mypage = (Integer) request.getAttribute("mypage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    String userRole = (String) session.getAttribute("role");
    String studentName = (String) session.getAttribute("studentName");
    if (mypage == null) mypage = 1;
    if (totalPages == null) totalPages = 1;
%>
<html>
<head>
    <title>Student List</title>
    <script>
    function validateSearchForm() {
        var searchType = document.forms["searchForm"]["searchType"].value;
        var query = document.forms["searchForm"]["query"].value;
        if (!searchType) {
            alert("Select a search type.");
            return false;
        }
        if (!query.trim()) {
            alert("Please enter a value to search.");
            return false;
        }
        var safe = /^[a-zA-Z0-9_@.\s-]+$/.test(query);
        if (!safe) {
            alert("Search can only contain letters, numbers, spaces, and -_.@");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>
    <% if ("warden".equalsIgnoreCase(userRole)) { %>
        <form action="WardenDashboardServlet" method="get" style="margin-bottom:10px;">
            <button type="submit">Back to Warden Dashboard</button>
        </form>
    <% } else if ("student".equalsIgnoreCase(userRole)) { %>
        <form action="StudentDashboardServlet" method="get" style="margin-bottom:10px;">
            <button type="submit">Back to Student Dashboard</button>
        </form>
    <% } else if ("superintendent".equalsIgnoreCase(userRole)) { %>
        <form action="SuperintendentDashboardServlet" method="get" style="margin-bottom:10px;">
            <button type="submit">Back to Superintendent Dashboard</button>
        </form>
    <% } %>

    <h2>
        <% if ("student".equalsIgnoreCase(userRole)) { %>
            Welcome <%= studentName != null ? studentName : "Student" %>!
        <% } else if ("warden".equalsIgnoreCase(userRole)) { %>
            Welcome, Warden!
        <% } else if ("superintendent".equalsIgnoreCase(userRole)) { %>
            Welcome, Superintendent!
        <% } else { %>
            Welcome!
        <% } %>
    </h2>

    <h2>Search Students</h2>
    <form name="searchForm" method="get" action="StudentListServlet"
          style="display:inline;" onsubmit="return validateSearchForm();">
        <select name="searchType" required>
            <option value="roll_no">Roll No</option>
            <option value="name">Name</option>
            <option value="contact">Contact</option>
        </select>
        <input type="text" name="query" placeholder="Enter value..." required />
        <input type="submit" value="Search"/>
    </form>
    <form method="get" action="StudentListServlet" style="display:inline;">
        <input type="hidden" name="showAll" value="true" />
        <button type="submit">Show All</button>
    </form>
    <h2>Student List</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Roll No</th>
            <th>Name</th>
            <% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                <th>Contact</th>
            <% } %>
            <th>Address</th>
            <th>Room Allocation(s)</th>
            <th>Amount Paid</th>
            <th>Fee Status</th>
            <th>Action</th>
        </tr>
        <%
        if (students != null) {
        for (Student student : students) {
        %>
        <tr>
            <td><%= student.getId() %></td>
            <td><%= student.getRollNo() %></td>
            <td><%= student.getName() %></td>
            <% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                <td><%= student.getContact() %></td>
            <% } %>
            <td><%= student.getAddress() %></td>
            <td>
<%
    List<RoomAllocation> allocs = allocationsMap != null ? allocationsMap.get(student.getId()) : null;
    if (allocs != null && !allocs.isEmpty() && roomMap != null) {
        for (RoomAllocation alloc : allocs) {
            Room r = roomMap.get(alloc.getRoomId());
%>
                Room <%= r != null ? r.getRoomNo() : "?" %>
                (From <%= alloc.getDateFrom() %> To <%= alloc.getDateTo() %>)
<%  if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                <a href="DeleteAllocationServlet?allocation_id=<%= alloc.getId() %>&student_id=<%= student.getId() %>">Delete Allocation</a>
<%  } %>
                <br/>
<%
        }
    } else if (allocs != null && allocs.isEmpty()) {
%>
                Not allocated
<%
    } else {
%>
                Not loaded
<%
    }
%>
            </td>
            <td><%= student.getTotalFeePaid() %></td>
            <td><%= student.getFeeStatus() %></td>
            <td>
<% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                <a href="EditStudentServlet?id=<%= student.getId() %>">Edit</a> |
                <a href="DeleteStudentServlet?id=<%= student.getId() %>">Delete</a>
                <% if (allocs == null || allocs.isEmpty()) { %>
                 | <a href="AllocateRoomServlet?student_id=<%= student.getId() %>">Allocate Room</a>
                <% } %>
<% } else { %>
                <form method="get" action="StudentListServlet" style="display:inline;">
                    <input type="hidden" name="id" value="<%= student.getId() %>" />
                    <button type="submit">View Details</button>
                </form>
<% } %>
            </td>
        </tr>
        <% }} %>
    </table>
    <div style="margin-top:15px;">
    <%
    if (totalPages > 1) {
        for (int pageNum = 1; pageNum <= totalPages; pageNum++) {
    %>
        <a href="StudentListServlet?page=<%=pageNum%>"
            <%= (pageNum == mypage ? " style='font-weight:bold;text-decoration:underline'" : "") %> >
            <%= pageNum %>
        </a>
    <%
        }
    }
    %>
    </div>
</body>
</html>
