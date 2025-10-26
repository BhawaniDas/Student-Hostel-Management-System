<%@ page import="com.shms.model.Student, java.util.List" %>
<%
    List<Student> students = (List<Student>) request.getAttribute("students");
%>
<html>
<head>
    <title>Add Fee Payment</title>
    <script>
    function validateFeeForm() {
        var studentId = document.forms["feeForm"]["student_id"].value;
        var amount = document.forms["feeForm"]["amount"].value;
        if (!studentId || !amount) {
            alert("All the fields are required.");
            return false;
        }
        if (isNaN(amount) || parseFloat(amount) <= 0) {
            alert("Enter a valid positive amount.");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>
    <h2>Add Fee Payment</h2>
    <form name="feeForm" method="post" action="AddFeeServlet" onsubmit="return validateFeeForm();">
        Student: 
        <select name="student_id" required>
            <option value="">Select Student</option>
            <% for (Student s : students) { %>
                <option value="<%= s.getId() %>"><%= s.getName() %> (<%= s.getRollNo() %>)</option>
            <% } %>
        </select><br/>

        Amount: <input type="number" name="amount" step="0.01" min="0.01" required/><br/>

        Fee Status:
        <select name="fee_status" required>
            <option value="Paid">Paid</option>
            <option value="Pending">Pending</option>
        </select><br/>

        <input type="submit" value="Add Payment"/>
    </form>
   <form action="FeeListServlet" method="get" style="margin-top:10px;">
    <button type="submit">Back to Fee List</button>
</form>


</body>
</html>