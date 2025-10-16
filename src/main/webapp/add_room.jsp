<html>
<head>
    <title>Add Room</title>
    <script>
    function validateRoomForm() {
        var roomNo = document.forms["roomForm"]["room_no"].value.trim();
        var floor = document.forms["roomForm"]["floor"].value.trim();
        var capacity = document.forms["roomForm"]["capacity"].value.trim();
        if (!roomNo || !floor || !capacity) {
            alert("All fields are required.");
            return false;
        }
        if (!/^[0-9]+$/.test(capacity)) {
            alert("Capacity must be a number.");
            return false;
        }
        return true;
    }
    </script>
</head>
<body>
    <h2>Add New Room</h2>
    <form name="roomForm" method="post" action="AddRoomServlet" onsubmit="return validateRoomForm();">
        Room No: <input type="text" name="room_no" required /><br/>
        Floor: <input type="text" name="floor" required /><br/>
        Capacity: <input type="text" name="capacity" required /><br/>
        <input type="submit" value="Add Room"/>
    </form>
    <form action="RoomListServlet" method="get" style="margin-top:20px;">
        <button type="submit">Back to Room List</button>
    </form>
</body>
</html>
