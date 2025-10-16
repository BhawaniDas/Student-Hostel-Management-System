<%@ page import="com.shms.model.FeePayment, com.shms.model.Student, java.util.List, java.util.Map" %>
<%
    List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
    Map<Integer, Student> studentMap = (Map<Integer, Student>) request.getAttribute("studentMap");
%>
<html>
<head>
    <title>Fee Payment List</title>
</head>
<body>
    <h2>Fee Payment List</h2>
    <table border="1" cellpadding="6" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Roll No</th>
            <th>Name</th>
            <th>Amount</th>
            <th>Date</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <% if (payments != null) {
            for (FeePayment fee : payments) {
                Student stu = studentMap != null ? studentMap.get(fee.getStudentId()) : null;
        %>
        <tr>
            <td><%= fee.getId() %></td>
            <td><%= stu != null ? stu.getRollNo() : "" %></td>
            <td><%= stu != null ? stu.getName() : "" %></td>
            <td><%= fee.getAmount() %></td>
            <td><%= fee.getPaymentDate() %></td>
            <td><%= fee.getFeeStatus() %></td>
            <td>
                <a href="EditFeeServlet?id=<%= fee.getId() %>">Edit</a>
                |
                <a href="DeleteFeeServlet?id=<%= fee.getId() %>" onclick="return confirm('Delete this payment?');">Delete</a>
            </td>
        </tr>
        <%    }
            } else { %>
        <tr><td colspan="7">No payments found.</td></tr>
        <% } %>
    </table>
    <br/>
    <a href="FeePageServlet">Add New Fee Payment</a>
    <br/><br/>
    <form action="WardenDashboardServlet" method="get" style="margin-bottom:10px;">
    <button type="submit">Back to Warden Dashboard</button>
</form>
<% if ("superintendent".equalsIgnoreCase((String) session.getAttribute("role"))) { %>
    <form action="SuperintendentDashboardServlet" method="get" style="margin-bottom:10px;">
        <button type="submit">Back to Superintendent Dashboard</button>
    </form>
<% } %>


</body>
</html>
