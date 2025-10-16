<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Object userObj = session.getAttribute("currentUser");
    if (userObj == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = ((com.shms.model.User)userObj).getUsername();
%>
<html>
<head><title>Dashboard</title></head>
<body>
    <h2>Welcome, <%= username %>!</h2>
    <p>This is your dashboard page after login.</p>
    <a href="logout.jsp">Logout</a>
</body>
</html>
