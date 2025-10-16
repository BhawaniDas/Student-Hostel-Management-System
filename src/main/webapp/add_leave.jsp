<%@ page import="com.shms.model.Student, java.util.List" %>
<%
    List<Student> students = (List<Student>) request.getAttribute("students");
%>
<html>
<head>
    <title>Apply for Leave for</title>
</head>
<body>
    <h2>Apply for Leave</h2>
    <form method="post" action="AddLeaveServlet">
      Student:
      <select name="student_id" required>
        <% for (Student stu : students) { %>
          <option value="<%= stu.getId() %>">
              <%= stu.getName() %> (<%= stu.getRollNo() %>)
          </option>
        <% } %>
      </select><br/>
      From Date: <input type="date" name="from_date" required/><br/>
      To Date: <input type="date" name="to_date" required/><br/>
      Guardian Number: <input type="text" name="guardian_number" required/><br/>
      Reason: <textarea name="reason" required></textarea><br/>
      <input type="submit" value="Submit Leave"/>
    </form>
</body>
</html>
