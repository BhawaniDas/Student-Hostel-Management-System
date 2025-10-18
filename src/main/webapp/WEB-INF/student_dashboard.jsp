<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !sessionRole.equalsIgnoreCase("student")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Hostel Management System</title>
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
        
        .dashboard-card {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid var(--primary);
            height: 100%;
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }
        
        .dashboard-card i {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .dashboard-card h3 {
            font-size: 1.25rem;
            margin-bottom: 0.75rem;
            font-weight: 600;
        }
        
        .dashboard-card p {
            color: #6c757d;
            margin-bottom: 1.5rem;
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
        
        .quick-actions {
            display: grid;
            grid-template-columns: 1fr;
            gap: 0.75rem;
            margin-top: 1rem;
        }
        
        .quick-action-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            background-color: rgba(67, 97, 238, 0.05);
            border-radius: 8px;
            transition: all 0.3s;
            text-decoration: none;
            color: var(--dark);
        }
        
        .quick-action-item:hover {
            background-color: rgba(67, 97, 238, 0.1);
            transform: translateY(-2px);
            color: var(--dark);
            text-decoration: none;
        }
        
        .quick-action-item i {
            font-size: 1.25rem;
            color: var(--primary);
            margin-right: 0.75rem;
            margin-bottom: 0;
        }
        
        @media (max-width: 768px) {
            .header-container {
                padding: 1rem 1.5rem;
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
                    <p class="mb-0">Student Dashboard</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="me-3">Welcome, Student!</span>
                    <a href="logout.jsp" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <!-- Student Info Card -->
        <div class="content-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3 class="mb-2">Welcome, Student!</h3>
                    <p class="mb-0">
                        Name: <b><%= request.getAttribute("studentName") != null ? request.getAttribute("studentName") : "" %></b>
                    </p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="btn-group">
                        <a href="StudentListServlet" class="btn btn-outline-custom">
                            <i class="fas fa-list me-1"></i> View Student List
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="row">
            <!-- Apply for Leave Card -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <i class="fas fa-calendar-plus"></i>
                    <h3>Apply for Leave</h3>
                    <p>Submit a new leave application for approval by the warden.</p>
                    <div class="quick-actions">
                        <a href="student_apply_leave.jsp" class="quick-action-item">
                            <i class="fas fa-file-alt"></i>
                            <span>Apply for Leave</span>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- View Leave Status Card -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <i class="fas fa-clipboard-check"></i>
                    <h3>View Leave Status</h3>
                    <p>Check the status of your submitted leave applications.</p>
                    <div class="quick-actions">
                        <a href="StudentViewLeaveServlet" class="quick-action-item">
                            <i class="fas fa-eye"></i>
                            <span>View Leave Status</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>