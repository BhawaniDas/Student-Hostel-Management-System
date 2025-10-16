
<%@ page import="com.shms.model.Room,java.util.List" %>
<%
    String error = (String) request.getAttribute("error");
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
%>
<html>
<head>
    <title>Room List</title>
</head>
<body>
    <form action="WardenDashboardServlet" method="get" style="margin-bottom:10px;">
        <button type="submit">Back to Warden Dashboard</button>
        
    </form>
    <% if ("superintendent".equalsIgnoreCase((String) session.getAttribute("role"))) { %>
    <form action="SuperintendentDashboardServlet" method="get" style="margin-bottom:10px;">
        <button type="submit">Back to Superintendent Dashboard</button>
    </form>
<% } %>
    
    <h2>Room List</h2>
    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
    <% } %>
    <p>
        <%= "Debug: rooms attribute = " + rooms %>
    </p>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Room No</th>
            <th>Floor</th>
            <th>Capacity</th>
            <th>Occupancy</th>
            <th>Action</th>
            <th>Status</th>
        </tr>
        <%
        if (rooms != null && !rooms.isEmpty()) {
            for (Room r : rooms) {
        %>
        <tr>
            <td><%= r.getId() %></td>
            <td><%= r.getRoomNo() %></td>
            <td><%= r.getFloor() %></td>
            <td><%= r.getCapacity() %></td>
            <td><%= r.getOccupancy() %> / <%= r.getCapacity() %></td>
            <td>
                <a href="AllocateRoomServlet?room_id=<%= r.getId() %>">Allocate</a> |
                <a href="EditRoomServlet?id=<%= r.getId() %>">Edit</a> |
                <a href="DeleteRoomServlet?id=<%= r.getId() %>">Delete</a>
            </td>
            <td>
                <% if (r.getCapacity() <= r.getOccupancy()) { %>
                    <span style="color:red;">Unable to add</span>
                <% } %>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="7">No rooms found or rooms attribute is null!</td>
        </tr>
        <%
        }
        %>
    </table>
    <a href="add_room.jsp">Add New Room</a>
</body>
</html>
