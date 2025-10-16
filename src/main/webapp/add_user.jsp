<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<h2>Add New User</h2>
<a href="AdminDashboardServlet" style="color:blue; font-weight:bold;">&larr; Back to Admin Dashboard</a>
<br><br>
<form action="AddUserServlet" method="post">
    Username:  <input type="text" name="username" required><br>
    Password:  <input type="password" name="password" required><br>
    Email:     <input type="email" name="email"><br>
    Name:      <input type="text" name="name"><br>
    Contact:   <input type="text" name="contact"><br>
    Address:   <input type="text" name="address"><br>
    Role: 
    <select name="role" required>
        <option value="student">student</option>
        <option value="warden">warden</option>
        <option value="admin">admin</option>
        <option value="superintendent">superintendent</option>
    </select><br>
    <input type="submit" value="Add User">
</form>
