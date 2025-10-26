<%@ page import="com.shms.model.User" %>
<%
    User user = (User) request.getAttribute("user");
%>
<h2>Edit User Details</h2>
<a href="AdminDashboardServlet" style="color:blue; font-weight:bold;">&larr; Back to Admin Dashboard</a>
<br><br>
<form action="UpdateUserServlet" method="post">
    <input type="hidden" name="originalUsername" value="<%=user.getUsername()%>">
    Username: <input type="text" name="username" value="<%=user.getUsername()%>"><br>
    Password: <input type="text" name="password" value="<%=user.getPassword()%>"><br>
    Email: <input type="text" name="email" value="<%=user.getEmail()%>"><br>
    Name: <input type="text" name="name" value="<%=user.getName()%>"><br>
    Contact: <input type="text" name="contact" value="<%=user.getContact()%>"><br>
    Address: <input type="text" name="address" value="<%=user.getAddress()%>"><br>
    Role: <select name="role">
        <option value="student" <%= "student".equals(user.getRole()) ? "selected" : "" %>>student</option>
        <option value="warden" <%= "warden".equals(user.getRole()) ? "selected" : "" %>>warden</option>
        <option value="admin" <%= "admin".equals(user.getRole()) ? "selected" : "" %>>admin</option>
        <option value="superintendent" <%= "superintendent".equals(user.getRole()) ? "selected" : "" %>>superintendent</option>
    </select><br>
    <input type="submit" value="Update User">
</form>