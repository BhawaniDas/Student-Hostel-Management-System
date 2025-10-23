<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    String sessionUsername = (String) session.getAttribute("username");
    if (sessionUsername == null || sessionRole == null
        || !sessionRole.equalsIgnoreCase("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New User - Hostel Management System</title>
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
            background: linear-gradient(135deg, #f5f7fb 0%, #e4edf5 100%);
            min-height: 100vh;
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
        
        .form-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #e1e5ee;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }
        
        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #e1e5ee;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        
        .input-group .form-control {
            border-left: none;
            border-radius: 0 10px 10px 0;
        }
        
        .btn-custom {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border: none;
            border-radius: 10px;
            color: white;
            padding: 0.75rem 2rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .btn-back {
            background-color: #6c757d;
            border: none;
            border-radius: 10px;
            color: white;
            padding: 0.5rem 1.5rem;
            transition: all 0.3s;
        }
        
        .btn-back:hover {
            background-color: #5a6268;
            color: white;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #495057;
        }
        
        .role-icon {
            font-size: 1.2rem;
            margin-right: 8px;
        }
        
        .card-icon {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .form-title {
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #e9ecef;
        }
        
        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
            
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
                    <p class="mb-0">Admin Panel - Add New User</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="me-3">Welcome, <strong><%= sessionUsername %></strong></span>
                    <a href="logout.jsp" class="btn btn-sm btn-light">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <!-- Back Button -->
        <div class="mb-3">
            <a href="AdminDashboardServlet" class="btn btn-back">
                <i class="fas fa-arrow-left me-1"></i> Back to Admin Dashboard
            </a>
        </div>

        <!-- Add User Form -->
        <div class="form-container">
            <div class="text-center mb-4">
                <div class="card-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h2 class="form-title">Add New User</h2>
            </div>

            <form action="AddUserServlet" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-user role-icon"></i>Username:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-id-card"></i>
                            </span>
                            <input type="text" class="form-control" name="username" placeholder="Enter username" required>
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-lock role-icon"></i>Password:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-key"></i>
                            </span>
                            <input type="password" class="form-control" name="password" placeholder="Enter password" required>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-envelope role-icon"></i>Email:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-at"></i>
                            </span>
                            <input type="email" class="form-control" name="email" placeholder="Enter email address">
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-signature role-icon"></i>Full Name:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-user"></i>
                            </span>
                            <input type="text" class="form-control" name="name" placeholder="Enter full name">
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-phone role-icon"></i>Contact:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-mobile-alt"></i>
                            </span>
                            <input type="text" class="form-control" name="contact" placeholder="Enter contact number">
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-map-marker-alt role-icon"></i>Address:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-home"></i>
                            </span>
                            <input type="text" class="form-control" name="address" placeholder="Enter address">
                        </div>
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-user-tag role-icon"></i>Role:
                    </label>
                    <select name="role" class="form-select" required>
                        <option value="" disabled selected>Select a role</option>
                        <option value="student">Student</option>
                        <option value="warden">Warden</option>
                        <option value="admin">Admin</option>
                        <option value="superintendent">Superintendent</option>
                    </select>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button type="reset" class="btn btn-outline-secondary me-md-2">
                        <i class="fas fa-redo me-1"></i> Reset Form
                    </button>
                    <button type="submit" class="btn btn-custom">
                        <i class="fas fa-user-plus me-1"></i> Add User
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>