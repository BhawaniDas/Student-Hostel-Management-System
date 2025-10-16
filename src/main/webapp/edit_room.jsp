<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.shms.model.Room" %>
<%
    Room room = (Room) request.getAttribute("room");
    String error = (String) session.getAttribute("error");
    String message = (String) session.getAttribute("message");
%>
<html>
<head>
    <title>Edit Room</title>
</head>
<body>
    <h2>Edit Room Details</h2>
    <% if (message != null) { %>
        <p style="color:green;"><%= message %></p>
        <% session.removeAttribute("message"); } %>
    <% if (error != null) { %>
        <p style="color:red;"><%= error %></p>
        <% session.removeAttribute("error"); } %>

    <form action="EditRoomServlet" method="post">
        <input type="hidden" name="id" value="<%= room != null ? room.getId() : "" %>"/>
        <label>Room Number:</label>
        <input type="text" name="room_no" value="<%= room != null ? room.getRoomNo() : "" %>" required/><br/><br/>
        <label>Floor:</label>
        <input type="text" name="floor" value="<%= room != null ? room.getFloor() : "" %>" required/><br/><br/>
        <label>Capacity:</label>
        <input type="number" min="1" name="capacity" value="<%= room != null ? room.getCapacity() : "" %>" required/><br/><br/>
        <button type="submit">Update Room</button>
    </form>
    <br>
    <a href="RoomListServlet">Back to Room List</a>
</body>
</html>
