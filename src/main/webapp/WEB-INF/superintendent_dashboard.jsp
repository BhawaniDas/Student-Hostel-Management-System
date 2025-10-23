<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Superintendent Dashboard - Hostel Management System</title>
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
        
        .dashboard-card {
            background-color: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s;
            height: 100%;
            border-top: 4px solid var(--primary);
        }
        
        .dashboard-card:hover {
            transform: translateY(-5px);
        }
        
        .dashboard-card i {
            font-size: 2.5rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .dashboard-card h3 {
            font-size: 1.3rem;
            margin-bottom: 0.5rem;
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
        
        .action-buttons a {
            margin-right: 5px;
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
                    <a class="nav-link" href="#studentManagement">
                        <i class="fas fa-user-graduate"></i> <span>Manage Students</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#roomManagement">
                        <i class="fas fa-bed"></i> <span>Manage Rooms</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#feeManagement">
                        <i class="fas fa-file-invoice-dollar"></i> <span>Manage Fees</span>
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
                <h4 class="mb-0">Superintendent Dashboard</h4>
                <div class="d-flex align-items-center">
                    <span class="me-3">Welcome, <strong>Superintendent</strong></span>
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
                    <h2>Welcome to Superintendent Dashboard</h2>
                    <p class="mb-0">Manage students, rooms, and fees from this centralized dashboard</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-user-tie fa-4x opacity-75"></i>
                </div>
            </div>
        </div>

        <!-- Quick Stats -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <i class="fas fa-user-graduate"></i>
                    <h3>Student Management</h3>
                    <p>View, search, edit students and add new students</p>
                    <a href="#studentManagement" class="btn btn-custom">
                        <i class="fas fa-arrow-right me-1"></i> Manage Students
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <i class="fas fa-bed"></i>
                    <h3>Room Management</h3>
                    <p>Manage room allocations and add new rooms</p>
                    <a href="#roomManagement" class="btn btn-custom">
                        <i class="fas fa-arrow-right me-1"></i> Manage Rooms
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card text-center">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <h3>Fee Management</h3>
                    <p>View, mark fees and add new fee records</p>
                    <a href="#feeManagement" class="btn btn-custom">
                        <i class="fas fa-arrow-right me-1"></i> Manage Fees
                    </a>
                </div>
            </div>
        </div>

        <!-- Student Management Section -->
        <div class="dashboard-card mb-4" id="studentManagement">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3><i class="fas fa-user-graduate me-2"></i>Manage Students</h3>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-list fa-2x text-primary mb-3"></i>
                            <h5>View/Search/Edit Students</h5>
                            <p class="text-muted">View student list with search and pagination functionality</p>
                            <a href="StudentListServlet" class="btn btn-custom">
                                <i class="fas fa-external-link-alt me-1"></i> Access Student List
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-user-plus fa-2x text-primary mb-3"></i>
                            <h5>Add New Student</h5>
                            <p class="text-muted">Add a new student to the hostel management system</p>
                            <a href="add_student.jsp" class="btn btn-custom">
                                <i class="fas fa-external-link-alt me-1"></i> Add Student
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Room Management Section -->
        <div class="dashboard-card mb-4" id="roomManagement">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3><i class="fas fa-bed me-2"></i>Manage Rooms</h3>
            </div>
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-door-open fa-2x text-primary mb-3"></i>
                            <h5>Manage Room Allocations</h5>
                            <p class="text-muted">View and manage current student-room assignments</p>
                            <a href="RoomListServlet" class="btn btn-custom">
                                <i class="fas fa-external-link-alt me-1"></i> Access Room List
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-plus-circle fa-2x text-primary mb-3"></i>
                            <h5>Add New Room</h5>
                            <p class="text-muted">Add a new room to the hostel inventory</p>
                            <a href="add_room.jsp" class="btn btn-custom">
                                <i class="fas fa-external-link-alt me-1"></i> Add Room
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Fee Management Section -->
        <div class="dashboard-card mb-4" id="feeManagement">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h3><i class="fas fa-file-invoice-dollar me-2"></i>Manage Fees</h3>
            </div>
            <div class="row">
                <div class="col-md-12 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="fas fa-money-check-alt fa-2x text-primary mb-3"></i>
                            <h5>View/Mark Fees/Add New Fee</h5>
                            <p class="text-muted">View student fees, mark payments and add new fee records</p>
                            <a href="FeeListServlet" class="btn btn-custom">
                                <i class="fas fa-external-link-alt me-1"></i> Access Fee Management
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Smooth scroll to sections
        document.querySelectorAll('.sidebar-menu .nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                const targetId = this.getAttribute('href');
                if (targetId && targetId.startsWith('#')) {
                    e.preventDefault();
                    document.querySelector(targetId).scrollIntoView({ 
                        behavior: 'smooth' 
                    });
                }
            });
        });
    </script>
</body>
</html>