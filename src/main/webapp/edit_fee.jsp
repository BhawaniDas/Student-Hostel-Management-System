<%@ page import="com.shms.model.FeePayment, com.shms.model.Student, java.util.List" %>
<%
    FeePayment payment = (FeePayment) request.getAttribute("payment");
    List<Student> students = (List<Student>) request.getAttribute("students");
    if (payment == null) {
%>
    <p>Payment not found!</p>
<% return; } %>
<html>
<head><title>Edit Fee Payment</title></head>
<body>
    <h2>Edit Fee Payment</h2>
    <form method="post" action="EditFeeServlets">
        <input type="hidden" name="id" value="<%= payment.getId() %>"/>
        Student:
        <select name="student_id" required>
            <option value="">Select Student</option>
            <% for (Student s : students) { %>
                <option value="<%= s.getId() %>" <%= s.getId() == payment.getStudentId() ? "selected" : "" %>>
                    <%= s.getName() %> (<%= s.getRollNo() %>)
                </option>
            <% } %>
        </select><br/>
        Amount: <input type="number" name="amount" step="0.01" min="0.01" value="<%= payment.getAmount() %>" required/><br/>
        Payment Date: <input type="date" name="payment_date" value="<%= payment.getPaymentDate() %>" required/><br/>
        Fee Status:
        <select name="fee_status">
            <option value="Paid" <%= "Paid".equals(payment.getFeeStatus()) ? "selected" : "" %> >Paid</option>
            <option value="Pending" <%= "Pending".equals(payment.getFeeStatus()) ? "selected" : "" %> >Pending</option>
        </select><br/>
        <input type="submit" value="Update Payment"/>
    </form>
    <a href="FeeListServlet">Back to Fee List</a>
</body>
</html>
