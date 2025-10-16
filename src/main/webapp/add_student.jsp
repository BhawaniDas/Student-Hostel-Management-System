<html>
<head>
    <title>Add Student</title>
    <script>
    function validateStudentForm() {
        var form = document.forms["studentForm"];
        var password = form["password"].value;
        var email = form["email"].value.trim();
        var name = form["name"].value.trim();
        var contact = form["contact"].value.trim();
        var address = form["address"].value.trim();
        var roll_no = form["roll_no"].value.trim();

        if (!password || !name || !roll_no) {
            alert("Password, Name, and Roll Number are required.");
            return false;
        }
        if (email && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
            alert("Enter a valid email address.");
            return false;
        }
        if (contact && !/^\d{10,15}$/.test(contact)) {
            alert("Contact should be 10-15 digits.");
            return false;
        }
        if (!/^\d{6}$/.test(roll_no)) {
            alert("Roll Number must be exactly 6 digits.");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>
    <h2>Add New Student</h2>
    <form name="studentForm" method="post" action="AddStudentServlet" onsubmit="return validateStudentForm();">
        Password: <input type="password" name="password" required /><br/>
        Email: <input type="email" name="email" /><br/>
        Name: <input type="text" name="name" required /><br/>
        Contact: <input type="text" name="contact" pattern="\d{10,15}" /><br/>
        Address: <input type="text" name="address" /><br/>
        Roll Number: <input type="text" name="roll_no" maxlength="6" pattern="\d{6}" required /><br/>
        <input type="submit" value="Add Student" />
    </form>
    <form action="StudentListServlet" method="get" style="margin-top:10px;display:inline;">
        <button type="submit">Back to Student List</button>
    </form>
    <form action="WardenDashboardServlet" method="get" style="display:inline;">
        <button type="submit">Back to Warden Dashboard</button>
    </form>
    <% if ("superintendent".equalsIgnoreCase((String) session.getAttribute("role"))) { %>
    <form action="SuperintendentDashboardServlet" method="get" style="margin-bottom:10px;">
        <button type="submit">Back to Superintendent Dashboard</button>
    </form>
<% } %>
    
    <%
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        if (message != null) {
    %>
        <p style="color:green;"><%= message %></p>
    <%
            session.removeAttribute("message");
        }
        if (error != null) {
    %>
        <p style="color:red;"><%= error %></p>
    <%
            session.removeAttribute("error");
        }
    %>
</body>
</html>
