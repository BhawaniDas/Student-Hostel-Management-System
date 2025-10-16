<%@ page import="com.shms.model.Room,com.shms.model.Student,java.util.List" %>
<%
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    List<Student> students = (List<Student>) request.getAttribute("students");
%>
<html>
<head>
    <title>Allocate Room</title>
    <script>
    function validateAllocationForm() {
        var studentId = document.forms["allocationForm"]["student_id"].value;
        var roomId = document.forms["allocationForm"]["room_id"].value;
        var dateFrom = document.forms["allocationForm"]["date_from"].value;
        var dateTo = document.forms["allocationForm"]["date_to"].value;
        if (!studentId || !roomId || !dateFrom || !dateTo) {
            alert("All fields are required.");
            return false;
        }
        if (new Date(dateFrom) > new Date(dateTo)) {
            alert("'From' date must be before 'To' date.");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>
    <h2>Allocate Room to Student</h2>
    <form name="allocationForm" method="post" action="AllocateRoomServlet" onsubmit="return validateAllocationForm();">
        Student: <select name="student_id" required>
            <option value="">Select</option>
            <% for (Student s : students) { %>
              <option value="<%= s.getId() %>"><%= s.getName() %> (<%= s.getRollNo() %>)</option>
            <% } %>
        </select><br/>
        Room: <select name="room_id" required>
            <option value="">Select</option>
            <% for (Room r : rooms) { %>
              <option value="<%= r.getId() %>"><%= r.getRoomNo() %> (Floor <%= r.getFloor() %>)</option>
            <% } %>
        </select><br/>
        From: <input type="date" name="date_from" required /><br/>
        To: <input type="date" name="date_to" required /><br/>
        <input type="submit" value="Allocate"/>
    </form>
    <form action="StudentListServlet" method="get" style="margin-top:20px;">
        <button type="submit">Back to Student List</button>
    </form>
    
</body>
</html>
