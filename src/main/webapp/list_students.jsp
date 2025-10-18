<%@ page import="com.shms.dao.StudentDAO,com.shms.model.Student,com.shms.model.RoomAllocation,com.shms.model.Room,java.util.List,java.util.Map,java.text.DecimalFormat" %>
<%
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");
    if (message != null) { %>
        <p style="color:green;"><%= message %></p>
<%  session.removeAttribute("message"); }
    if (error != null) { %>
        <p style="color:red;"><%= error %></p>
<%  session.removeAttribute("error"); }

    List<Student> students = (List<Student>) request.getAttribute("students");
    Map<Integer, List<RoomAllocation>> allocationsMap = (Map<Integer, List<RoomAllocation>>) request.getAttribute("allocationsMap");
    Map<Integer, Room> roomMap = (Map<Integer, Room>) request.getAttribute("roomMap");
    Integer mypage = (Integer) request.getAttribute("mypage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    String userRole = (String) session.getAttribute("role");
    String studentName = (String) session.getAttribute("studentName");
    if (mypage == null) mypage = 1;
    if (totalPages == null) totalPages = 1;
    
    // Create decimal formatter for Indian number format
    DecimalFormat formatter = new DecimalFormat("#,##,##0.00");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student List - Hostel Management System</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --info: #4895ef;
            --warning: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fb;
            padding: 20px;
        }
        
        .header-container {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border-radius: 10px;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .content-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .search-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .btn-custom {
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 5px;
            padding: 0.5rem 1rem;
            transition: all 0.3s;
        }
        
        .btn-custom:hover {
            background-color: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            color: white;
        }
        
        .btn-outline-custom {
            background-color: transparent;
            color: var(--primary);
            border: 1px solid var(--primary);
            border-radius: 5px;
            padding: 0.5rem 1rem;
            transition: all 0.3s;
        }
        
        .btn-outline-custom:hover {
            background-color: var(--primary);
            color: white;
        }
        
        .table-custom {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }
        
        .table-custom thead {
            background-color: var(--primary);
            color: white;
        }
        
        .table-custom th {
            border: none;
            padding: 1rem;
            font-weight: 500;
        }
        
        .table-custom td {
            padding: 1rem;
            vertical-align: middle;
        }
        
        .badge-status {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .badge-paid {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .badge-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        
        .badge-overdue {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .pagination .page-link {
            color: var(--primary);
            border: 1px solid #dee2e6;
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--primary);
            border-color: var(--primary);
        }
        
        .action-buttons a {
            margin-right: 5px;
            text-decoration: none;
        }
        
        .room-allocation {
            background-color: #f8f9fa;
            border-radius: 5px;
            padding: 0.5rem;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        
        .alert-custom {
            border-radius: 10px;
            border: none;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }
        
        .form-control, .form-select {
            border-radius: 5px;
            padding: 0.5rem 0.75rem;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }
        
        .amount-paid {
            font-weight: 600;
            color: #28a745;
        }
        
        @media (max-width: 768px) {
            .content-card, .search-card {
                padding: 1rem;
            }
            
            .table-responsive {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header-container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="h3 mb-1"><i class="fas fa-building me-2"></i>Hostel Management System</h1>
                    <p class="mb-0">Student Management</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="me-3">
                        <% if ("student".equalsIgnoreCase(userRole)) { %>
                            Welcome <%= studentName != null ? studentName : "Student" %>!
                        <% } else if ("warden".equalsIgnoreCase(userRole)) { %>
                            Welcome, Warden!
                        <% } else if ("superintendent".equalsIgnoreCase(userRole)) { %>
                            Welcome, Superintendent!
                        <% } else { %>
                            Welcome!
                        <% } %>
                    </span>
                    <!-- Back Button -->
                    <% if ("warden".equalsIgnoreCase(userRole)) { %>
                        <a href="WardenDashboardServlet" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                        </a>
                    <% } else if ("student".equalsIgnoreCase(userRole)) { %>
                        <a href="StudentDashboardServlet" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                        </a>
                    <% } else if ("superintendent".equalsIgnoreCase(userRole)) { %>
                        <a href="SuperintendentDashboardServlet" class="btn btn-light btn-sm">
                            <i class="fas fa-arrow-left me-1"></i> Back to Dashboard
                        </a>
                    <% } %>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <% if (message != null) { %>
            <div class="alert alert-success alert-custom" role="alert">
                <i class="fas fa-check-circle me-2"></i> <%= message %>
            </div>
        <% } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger alert-custom" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
            </div>
        <% } %>

        <!-- Search Card -->
        <div class="search-card">
            <h4 class="mb-3"><i class="fas fa-search me-2"></i>Search Students</h4>
            <form name="searchForm" method="get" action="StudentListServlet" onsubmit="return validateSearchForm();">
                <div class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label">Search Type</label>
                        <select name="searchType" class="form-select" required>
                            <option value="roll_no">Roll No</option>
                            <option value="name">Name</option>
                            <option value="contact">Contact</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">Search Query</label>
                        <input type="text" name="query" class="form-control" placeholder="Enter value..." required />
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-custom w-100">
                            <i class="fas fa-search me-1"></i> Search
                        </button>
                    </div>
                </div>
            </form>
            <div class="mt-3">
                <form method="get" action="StudentListServlet">
                    <input type="hidden" name="showAll" value="true" />
                    <button type="submit" class="btn btn-outline-custom">
                        <i class="fas fa-list me-1"></i> Show All Students
                    </button>
                </form>
            </div>
        </div>

        <!-- Student List Card -->
        <div class="content-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0"><i class="fas fa-user-graduate me-2"></i>Student List</h3>
                <span class="text-muted">Page <%= mypage %> of <%= totalPages %></span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Roll No</th>
                            <th>Name</th>
                            <% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                                <th>Contact</th>
                            <% } %>
                            <th>Address</th>
                            <th>Room Allocation(s)</th>
                            <th>Amount Paid</th>
                            <th>Fee Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        if (students != null) {
                        for (Student student : students) {
                            // Format the amount paid with proper number formatting (NO SYMBOL)
                            String formattedAmount;
                            try {
                                double amount = student.getTotalFeePaid();
                                formattedAmount = formatter.format(amount);
                            } catch (Exception e) {
                                // If formatting fails, show the raw value
                                formattedAmount = String.valueOf(student.getTotalFeePaid());
                            }
                        %>
                        <tr>
                            <td><%= student.getId() %></td>
                            <td><strong><%= student.getRollNo() %></strong></td>
                            <td><%= student.getName() %></td>
                            <% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                                <td><%= student.getContact() %></td>
                            <% } %>
                            <td><%= student.getAddress() %></td>
                            <td>
                                <%
                                List<RoomAllocation> allocs = allocationsMap != null ? allocationsMap.get(student.getId()) : null;
                                if (allocs != null && !allocs.isEmpty() && roomMap != null) {
                                    for (RoomAllocation alloc : allocs) {
                                        Room r = roomMap.get(alloc.getRoomId());
                                %>
                                <div class="room-allocation">
                                    <div><strong>Room <%= r != null ? r.getRoomNo() : "?" %></strong></div>
                                    <div class="small text-muted">
                                        From <%= alloc.getDateFrom() %> To <%= alloc.getDateTo() %>
                                    </div>
                                    <% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                                        <div class="mt-1">
                                            <a href="DeleteAllocationServlet?allocation_id=<%= alloc.getId() %>&student_id=<%= student.getId() %>" 
                                               class="btn btn-outline-danger btn-sm"
                                               onclick="return confirm('Are you sure you want to delete this allocation?');">
                                                <i class="fas fa-trash-alt"></i> Delete
                                            </a>
                                        </div>
                                    <% } %>
                                </div>
                                <%
                                    }
                                } else if (allocs != null && allocs.isEmpty()) {
                                %>
                                    <span class="text-muted">Not allocated</span>
                                <%
                                } else {
                                %>
                                    <span class="text-muted">Not loaded</span>
                                <%
                                }
                                %>
                            </td>
                            <td class="amount-paid"><%= formattedAmount %></td>
                            <td>
                                <%
                                String feeStatus = student.getFeeStatus();
                                String badgeClass = "badge-status ";
                                if ("Paid".equalsIgnoreCase(feeStatus)) {
                                    badgeClass += "badge-paid";
                                } else if ("Pending".equalsIgnoreCase(feeStatus)) {
                                    badgeClass += "badge-pending";
                                } else {
                                    badgeClass += "badge-overdue";
                                }
                                %>
                                <span class="<%= badgeClass %>">
                                    <i class="fas fa-<%= "Paid".equalsIgnoreCase(feeStatus) ? "check" : "clock" %> me-1"></i>
                                    <%= feeStatus %>
                                </span>
                            </td>
                            <td class="action-buttons">
                                <% if ("warden".equalsIgnoreCase(userRole) || "superintendent".equalsIgnoreCase(userRole)) { %>
                                    <a href="EditStudentServlet?id=<%= student.getId() %>" class="btn btn-outline-custom btn-sm">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="DeleteStudentServlet?id=<%= student.getId() %>" 
                                       class="btn btn-outline-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this student?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                    <% if (allocs == null || allocs.isEmpty()) { %>
                                        <a href="AllocateRoomServlet?student_id=<%= student.getId() %>" class="btn btn-custom btn-sm mt-1">
                                            <i class="fas fa-bed"></i> Allocate Room
                                        </a>
                                    <% } %>
                                <% } else { %>
                                    <form method="get" action="StudentListServlet" class="d-inline">
                                        <input type="hidden" name="id" value="<%= student.getId() %>" />
                                        <button type="submit" class="btn btn-outline-custom btn-sm">
                                            <i class="fas fa-eye"></i> View Details
                                        </button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                        <% }} else { %>
                        <tr>
                            <td colspan="9" class="text-center py-4">
                                <i class="fas fa-info-circle fa-2x text-muted mb-2"></i>
                                <p class="text-muted">No students found.</p>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <% if (totalPages > 1) { %>
            <div class="d-flex justify-content-center mt-4">
                <nav>
                    <ul class="pagination">
                        <%
                        for (int pageNum = 1; pageNum <= totalPages; pageNum++) {
                        %>
                        <li class="page-item <%= (pageNum == mypage) ? "active" : "" %>">
                            <a class="page-link" href="StudentListServlet?page=<%=pageNum%>">
                                <%= pageNum %>
                            </a>
                        </li>
                        <%
                        }
                        %>
                    </ul>
                </nav>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    function validateSearchForm() {
        var searchType = document.forms["searchForm"]["searchType"].value;
        var query = document.forms["searchForm"]["query"].value;
        if (!searchType) {
            alert("Select a search type.");
            return false;
        }
        if (!query.trim()) {
            alert("Please enter a value to search.");
            return false;
        }
        var safe = /^[a-zA-Z0-9_@.\s-]+$/.test(query);
        if (!safe) {
            alert("Search can only contain letters, numbers, spaces, and -_.@");
            return false;
        }
        return true;
    }
    </script>
</body>
</html>