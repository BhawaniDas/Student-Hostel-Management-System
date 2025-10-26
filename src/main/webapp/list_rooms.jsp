<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !(sessionRole.equalsIgnoreCase("superintendent") || sessionRole.equalsIgnoreCase("warden"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<%@ page import="com.shms.model.Room,java.util.List" %>
<%
    String error = (String) request.getAttribute("error");
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room List - Hostel Management System</title>
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
        
        .badge-occupancy {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .badge-available {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .badge-full {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .badge-warning {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        
        .action-buttons a {
            margin-right: 5px;
            text-decoration: none;
        }
        
        .alert-custom {
            border-radius: 10px;
            border: none;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }
        
        .room-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--primary);
            transition: transform 0.3s;
        }
        
        .room-card:hover {
            transform: translateY(-5px);
        }
        
        .room-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .room-number {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary);
        }
        
        .room-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .room-detail-item {
            display: flex;
            flex-direction: column;
        }
        
        .room-detail-label {
            font-size: 0.875rem;
            color: #6c757d;
            margin-bottom: 0.25rem;
        }
        
        .room-detail-value {
            font-weight: 500;
        }
        
        .progress {
            height: 8px;
            border-radius: 4px;
            margin-bottom: 1rem;
        }
        
        @media (max-width: 768px) {
            .content-card {
                padding: 1rem;
            }
            
            .header-container {
                padding: 1rem 1.5rem;
            }
            
            .room-details {
                grid-template-columns: 1fr;
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
                    <p class="mb-0">Room Management</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="me-3">Welcome, 
                        <% if ("warden".equalsIgnoreCase(sessionRole)) { %>
                            Warden!
                        <% } else if ("superintendent".equalsIgnoreCase(sessionRole)) { %>
                            Superintendent!
                        <% } %>
                    </span>
                </div>
            </div>
        </div>

        <!-- Back Button -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <% if ("warden".equalsIgnoreCase(sessionRole)) { %>
                    <a href="WardenDashboardServlet" class="btn btn-outline-custom">
                        <i class="fas fa-arrow-left me-1"></i> Back to Warden Dashboard
                    </a>
                <% } else if ("superintendent".equalsIgnoreCase(sessionRole)) { %>
                    <a href="SuperintendentDashboardServlet" class="btn btn-outline-custom">
                        <i class="fas fa-arrow-left me-1"></i> Back to Superintendent Dashboard
                    </a>
                <% } %>
            </div>
        </div>

        <!-- Error Message -->
        <% if (error != null) { %>
            <div class="alert alert-danger alert-custom" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
            </div>
        <% } %>

        <!-- Room List Card -->
        <div class="content-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0"><i class="fas fa-bed me-2"></i>Room List</h3>
                <span class="text-muted">
                    <% if (rooms != null) { %>
                        <%= rooms.size() %> Room(s)
                    <% } else { %>
                        0 Rooms
                    <% } %>
                </span>
            </div>

            <!-- Cards View for Rooms -->
            <div class="row">
                <%
                if (rooms != null && !rooms.isEmpty()) {
                    for (Room r : rooms) {
                        int occupancy = r.getOccupancy();
                        int capacity = r.getCapacity();
                        double occupancyPercentage = (double) occupancy / capacity * 100;
                        
                        String badgeClass = "badge-occupancy ";
                        if (occupancyPercentage >= 100) {
                            badgeClass += "badge-full";
                        } else if (occupancyPercentage >= 80) {
                            badgeClass += "badge-warning";
                        } else {
                            badgeClass += "badge-available";
                        }
                %>
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="room-card">
                        <div class="room-header">
                            <div class="room-number">
                                <i class="fas fa-door-open me-2"></i>Room <%= r.getRoomNo() %>
                            </div>
                            <span class="<%= badgeClass %>">
                                <%= occupancy %> / <%= capacity %>
                            </span>
                        </div>
                        
                        <div class="room-details">
                            <div class="room-detail-item">
                                <span class="room-detail-label">Floor</span>
                                <span class="room-detail-value">
                                    <i class="fas fa-layer-group me-1"></i> <%= r.getFloor() %>
                                </span>
                            </div>
                            <div class="room-detail-item">
                                <span class="room-detail-label">Capacity</span>
                                <span class="room-detail-value">
                                    <i class="fas fa-users me-1"></i> <%= r.getCapacity() %>
                                </span>
                            </div>
                            <div class="room-detail-item">
                                <span class="room-detail-label">Occupancy</span>
                                <span class="room-detail-value">
                                    <i class="fas fa-user-check me-1"></i> <%= r.getOccupancy() %>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Occupancy Progress Bar -->
                        <div class="progress">
                            <div class="progress-bar 
                                <% if (occupancyPercentage >= 100) { %>
                                    bg-danger
                                <% } else if (occupancyPercentage >= 80) { %>
                                    bg-warning
                                <% } else { %>
                                    bg-success
                                <% } %>" 
                                role="progressbar" 
                                style="width: <%= occupancyPercentage %>%" 
                                aria-valuenow="<%= occupancyPercentage %>" 
                                aria-valuemin="0" 
                                aria-valuemax="100">
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="action-buttons">
                                <a href="AllocateRoomServlet?room_id=<%= r.getId() %>" class="btn btn-outline-custom btn-sm">
                                    <i class="fas fa-user-plus"></i> Allocate
                                </a>
                                <a href="EditRoomServlet?id=<%= r.getId() %>" class="btn btn-outline-custom btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="DeleteRoomServlet?id=<%= r.getId() %>" class="btn btn-outline-danger btn-sm">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </div>
                            
                            <% if (r.getCapacity() <= r.getOccupancy()) { %>
                                <span class="badge bg-danger">Full</span>
                            <% } else { %>
                                <span class="badge bg-success">Available</span>
                            <% } %>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="col-12">
                    <div class="text-center py-5">
                        <i class="fas fa-bed fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">No Rooms Found</h4>
                        <p class="text-muted">There are no rooms in the system yet.</p>
                    </div>
                </div>
                <%
                }
                %>
            </div>

            <!-- Table View for Rooms (Alternative View) -->
            <div class="mt-5">
                <h5 class="mb-3"><i class="fas fa-table me-2"></i>Table View</h5>
                <div class="table-responsive">
                    <table class="table table-hover table-custom">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Room No</th>
                                <th>Floor</th>
                                <th>Capacity</th>
                                <th>Occupancy</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            if (rooms != null && !rooms.isEmpty()) {
                                for (Room r : rooms) {
                                    int occupancy = r.getOccupancy();
                                    int capacity = r.getCapacity();
                                    double occupancyPercentage = (double) occupancy / capacity * 100;
                                    
                                    String badgeClass = "badge-occupancy ";
                                    if (occupancyPercentage >= 100) {
                                        badgeClass += "badge-full";
                                    } else if (occupancyPercentage >= 80) {
                                        badgeClass += "badge-warning";
                                    } else {
                                        badgeClass += "badge-available";
                                    }
                            %>
                            <tr>
                                <td><%= r.getId() %></td>
                                <td><strong><%= r.getRoomNo() %></strong></td>
                                <td><%= r.getFloor() %></td>
                                <td><%= r.getCapacity() %></td>
                                <td>
                                    <span class="<%= badgeClass %>">
                                        <%= r.getOccupancy() %> / <%= r.getCapacity() %>
                                    </span>
                                </td>
                                <td>
                                    <% if (r.getCapacity() <= r.getOccupancy()) { %>
                                        <span class="badge bg-danger">Full</span>
                                    <% } else { %>
                                        <span class="badge bg-success">Available</span>
                                    <% } %>
                                </td>
                                <td class="action-buttons">
                                    <a href="AllocateRoomServlet?room_id=<%= r.getId() %>" class="btn btn-outline-custom btn-sm">
                                        <i class="fas fa-user-plus"></i> Allocate
                                    </a>
                                    <a href="EditRoomServlet?id=<%= r.getId() %>" class="btn btn-outline-custom btn-sm">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="DeleteRoomServlet?id=<%= r.getId() %>" class="btn btn-outline-danger btn-sm">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center py-4">
                                    <i class="fas fa-bed fa-2x text-muted mb-2"></i>
                                    <p class="text-muted">No rooms found.</p>
                                </td>
                            </tr>
                            <%
                            }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>