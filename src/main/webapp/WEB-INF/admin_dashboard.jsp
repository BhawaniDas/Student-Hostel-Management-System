<%@ page import="java.util.List" %>
<%@ page import="com.shms.model.User" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    String sessionUsername = (String) session.getAttribute("username");
    if (sessionUsername == null || sessionRole == null
        || !sessionRole.equalsIgnoreCase("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<User> userList = (List<User>) request.getAttribute("userList");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Hostel Management System</title>
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
            --sidebar-width: 250px;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fb;
            min-height: 100vh;
        }
        
        .sidebar {
            background: linear-gradient(to bottom, var(--primary), var(--secondary));
            color: white;
            height: 100vh;
            position: fixed;
            width: var(--sidebar-width);
            padding: 0;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }
        
        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-header h3 {
            margin: 0;
            font-weight: 600;
            font-size: 1.2rem;
        }
        
        .sidebar-menu {
            padding: 1rem 0;
        }
        
        .sidebar-menu .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 0.8rem 1.5rem;
            border-left: 3px solid transparent;
            transition: all 0.3s;
        }
        
        .sidebar-menu .nav-link:hover {
            color: white;
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 3px solid white;
        }
        
        .sidebar-menu .nav-link.active {
            color: white;
            background-color: rgba(255, 255, 255, 0.15);
            border-left: 3px solid white;
        }
        
        .sidebar-menu .nav-link i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .main-content {
            margin-left: var(--sidebar-width);
            padding: 2rem;
        }
        
        .navbar-custom {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            margin-bottom: 2rem;
            border-radius: 10px;
        }
        
        .welcome-card {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .stats-card {
            background-color: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s;
            border-left: 4px solid var(--primary);
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .stats-card i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .stats-card h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .stats-card p {
            color: #6c757d;
            margin: 0;
        }
        
        .user-table {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        .user-table .table thead {
            background-color: var(--primary);
            color: white;
        }
        
        .user-table .table th {
            border: none;
            padding: 1rem;
            font-weight: 500;
        }
        
        .user-table .table td {
            padding: 1rem;
            vertical-align: middle;
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
        
        .action-buttons a {
            margin-right: 5px;
        }
        
        .badge-role {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .badge-admin {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }
        
        .badge-superintendent {
            background-color: rgba(76, 201, 240, 0.1);
            color: #4cc9f0;
        }
        
        .badge-warden {
            background-color: rgba(247, 37, 133, 0.1);
            color: #f72585;
        }
        
        .badge-student {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: var(--primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            margin-right: 10px;
        }
        
        .user-info {
            display: flex;
            align-items: center;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }
            
            .sidebar-header h3, .sidebar-menu .nav-link span {
                display: none;
            }
            
            .sidebar-menu .nav-link {
                text-align: center;
                padding: 1rem 0;
            }
            
            .sidebar-menu .nav-link i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .main-content {
                margin-left: 70px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <h3><i class="fas fa-building me-2"></i> Hostel Management</h3>
        </div>
        <div class="sidebar-menu">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="#">
                        <i class="fas fa-tachometer-alt"></i> <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#userManagement">
                        <i class="fas fa-users"></i> <span>User Management</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="add_user.jsp">
                        <i class="fas fa-user-plus"></i> <span>Add User</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <h4 class="mb-0">Admin Dashboard</h4>
                <div class="d-flex align-items-center">
                    <span class="me-3">Welcome, <strong><%= sessionUsername %></strong></span>
                    <a href="logout.jsp" class="btn btn-outline-danger btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </div>
            </div>
        </nav>

        <!-- Welcome Card -->
        <div class="welcome-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2>Welcome to Admin Dashboard</h2>
                    <p class="mb-0">Manage all users and system settings from this centralized dashboard</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-user-cog fa-4x opacity-75"></i>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-users"></i>
                    <h3><%= userList != null ? userList.size() : 0 %></h3>
                    <p>Total Users</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-user-graduate"></i>
                    <h3>
                        <% 
                            int studentCount = 0;
                            if (userList != null) {
                                for (User user : userList) {
                                    if ("student".equals(user.getRole())) {
                                        studentCount++;
                                    }
                                }
                            }
                        %>
                        <%= studentCount %>
                    </h3>
                    <p>Students</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-user-shield"></i>
                    <h3>
                        <% 
                            int wardenCount = 0;
                            if (userList != null) {
                                for (User user : userList) {
                                    if ("warden".equals(user.getRole())) {
                                        wardenCount++;
                                    }
                                }
                            }
                        %>
                        <%= wardenCount %>
                    </h3>
                    <p>Wardens</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stats-card">
                    <i class="fas fa-user-tie"></i>
                    <h3>
                        <% 
                            int superintendentCount = 0;
                            if (userList != null) {
                                for (User user : userList) {
                                    if ("superintendent".equals(user.getRole())) {
                                        superintendentCount++;
                                    }
                                }
                            }
                        %>
                        <%= superintendentCount %>
                    </h3>
                    <p>Superintendents</p>
                </div>
            </div>
        </div>

        <!-- User Management Panel -->
        <div class="user-table" id="userManagement">
            <div class="p-3 border-bottom d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-users me-2"></i>User Management</h5>
                <a href="add_user.jsp" class="btn btn-custom">
                    <i class="fas fa-user-plus me-1"></i> Add New User
                </a>
            </div>
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Email</th>
                            <th>Contact</th>
                            <th>Address</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (userList != null) {
                                for (User user : userList) {
                                    String roleClass = "badge-role badge-" + user.getRole();
                                    String initials = user.getName() != null && !user.getName().isEmpty() 
                                        ? user.getName().substring(0, 1).toUpperCase() 
                                        : user.getUsername().substring(0, 1).toUpperCase();
                        %>
                        <tr>
                            <td>
                                <div class="user-info">
                                    <div class="user-avatar">
                                        <%= initials %>
                                    </div>
                                    <div>
                                        <div class="fw-bold"><%= user.getUsername() %></div>
                                        <div class="text-muted small"><%= user.getName() != null ? user.getName() : "" %></div>
                                    </div>
                                </div>
                            </td>
                            <td><%= user.getEmail() != null ? user.getEmail() : "" %></td>
                            <td><%= user.getContact() != null ? user.getContact() : "" %></td>
                            <td><%= user.getAddress() != null ? user.getAddress() : "" %></td>
                            <td>
                                <span class="<%= roleClass %>">
                                    <i class="fas fa-user me-1"></i>
                                    <%= user.getRole().substring(0, 1).toUpperCase() + user.getRole().substring(1) %>
                                </span>
                            </td>
                            <td class="action-buttons">
                                <% if("admin".equals(user.getUsername()) && "adminpass".equals(user.getPassword())) { %>
                                    <span class="text-muted">Default Admin</span>
                                <% } else { %>
                                    <a href="EditUserServlet?username=<%= user.getUsername() %>" class="btn btn-outline-custom btn-sm">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <a href="DeleteUserServlet?username=<%= user.getUsername() %>"
                                       class="btn btn-outline-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to delete this user?');">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Smooth scroll to user management section
        document.querySelectorAll('.sidebar-menu .nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                if (this.getAttribute('href') === '#userManagement') {
                    e.preventDefault();
                    document.getElementById('userManagement').scrollIntoView({ 
                        behavior: 'smooth' 
                    });
                }
            });
        });
    </script>
</body>
</html>