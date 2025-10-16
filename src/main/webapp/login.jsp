<!DOCTYPE html>
<html>
<head>
    <title>Hostel Management System</title>
    <script>
    function toggleLabel() {
        var roleSelect = document.getElementById("role");
        var label = document.getElementById("usernameLabel");
        if (roleSelect.value === "student") {
            label.innerText = "Roll Number:";
        } else {
            label.innerText = "Username:";
        }
    }
    </script>
</head>
<body>
    <h2>Login</h2>
    <form method="post" action="LoginServlet">
        <label id="usernameLabel">Username:</label>
        <input type="text" name="username" required /><br/>
        <label>Password:</label>
        <input type="password" name="password" required /><br/>
        <label>Role:</label>
        <select name="role" id="role" onchange="toggleLabel()" required>
            <option value="admin">Admin</option>
            <option value="superintendent">Superintendent</option>
            <option value="warden">Warden</option>
            <option value="student">Student</option>
        </select><br/>
        <input type="submit" value="Login"/>
    </form>
    <% 
        String error = request.getParameter("error");
        if (error != null) { 
    %>
    <p style="color:red;"><%= error %></p>
    <% } %>
</body>
</html>
