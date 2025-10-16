<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Superintendent Dashboard</title>
</head>
<body>
    <h1>Welcome, Superintendent</h1>

    <h2>Manage Students</h2>
    <ul>
        <li>
            <a href="StudentListServlet">View/Search/Edit Students</a>
            <!-- This uses your existing student list/search/pagination and EditStudentServlet for edit actions -->
        </li>
        <li>
            <a href="add_student.jsp">Add New Student</a>
            <!-- Takes warden to add student form -->
        </li>
    </ul>

    <h2>Manage Rooms</h2>
    <ul>
        <li>
            <a href="RoomListServlet">Manage Room Allocations</a>
            <!-- Shows current student-room assignments, uses allocate_room.jsp for changes -->
        </li>
        <li>
            <a href="add_room.jsp">Add New Room</a>
            <!-- Add new room to inventory -->
        </li>
    </ul>

    <h2>Manage Fees</h2>
    <ul>
        <li>
            <a href="FeeListServlet">View/Mark Fees/Add New Fee</a>
            <!-- Shows student fees, uses EditFeeServlet/Edit or UpdateFeeStatusServlet for updating -->
        </li>
        
    </ul>

    <h2>Review Leave Applications</h2>
    <ul>
        <li>
            <a href="leave_list.jsp">Review Leave Applications</a>
            <!-- Shows all student leave requests for approve/reject -->
        </li>
    </ul>

    <br>
    <a href="logout.jsp">Logout</a>
</body>
</html>
