<%@ page import="com.shms.model.Student" %>
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
    Student student = (Student) request.getAttribute("student");
%>

<html>
<head>
    <title>Edit Student</title>
    <script>
    function validateEditStudentForm() {
        var form = document.forms["editStudentForm"];
        var name = form["name"].value.trim();
        var contact = form["contact"].value.trim();
        var roll_no = form["roll_no"].value.trim();

        if (!roll_no || !/^\d{6}$/.test(roll_no)) {
            alert("Roll Number is required and must be exactly 6 digits.");
            return false;
        }
        if (!name) {
            alert("Name is required.");
            return false;
        }
        if (contact && !/^\d{10}$/.test(contact)) {
            alert("Contact must be 10 digits if entered.");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>
<% if (student == null) { %>
    <p style="color:red;">Student details not found. Cannot edit.</p>
    <form action="StudentListServlet" method="get">
        <button type="submit">Back to Student List</button>
    </form>
<% } else { %>
    <h2>Edit Student Details</h2>
    <form name="editStudentForm" action="EditStudentServlet" method="post" onsubmit="return validateEditStudentForm();">
        <input type="hidden" name="id" value="<%= student.getId() %>"/>
        Roll Number: <input type="text" name="roll_no" maxlength="6" required pattern="\d{6}" value="<%= student.getRollNo() %>"/><br/>
        Name: <input type="text" name="name" maxlength="50" required value="<%= student.getName() %>"/><br/>
        Contact: <input type="text" name="contact" maxlength="15" pattern="\d{10,15}" value="<%= student.getContact() != null ? student.getContact() : "" %>" /><br/>
        Address: <input type="text" name="address" maxlength="100" value="<%= student.getAddress() != null ? student.getAddress() : "" %>" /><br/>
        <input type="submit" value="Update Student"/>
    </form>
    <form action="StudentListServlet" method="get" style="margin-top:20px;">
        <button type="submit">Back to Student List</button>
    </form>
<% } %>
</body>
</html>
