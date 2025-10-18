<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Warden Dashboard - Hostel Management System</title>
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
                    <p class="mb-0">Warden Dashboard</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="me-3">Welcome, Warden!</span>
                    <a href="logout.jsp" class="btn btn-outline-light btn-sm">
                        <i class="fas fa-sign-out-alt me-1"></i> Logout
                    </a>
                </div>
            </div>
        </div>

        <!-- Dashboard Cards -->
        <div class="row">
            <!-- Manage Students Card -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <i class="fas fa-users"></i>
                    <h3>Manage Students</h3>
                    <p>View, search, edit student information and add new students to the hostel.</p>
                    <div class="quick-actions">
                        <a href="StudentListServlet" class="quick-action-item">
                            <i class="fas fa-list"></i>
                            <span>View/Search/Edit Students</span>
                        </a>
                        <a href="add_student.jsp" class="quick-action-item">
                            <i class="fas fa-user-plus"></i>
                            <span>Add New Student</span>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Manage Rooms Card -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <i class="fas fa-bed"></i>
                    <h3>Manage Rooms</h3>
                    <p>Allocate rooms to students, manage room assignments and add new rooms.</p>
                    <div class="quick-actions">
                        <a href="RoomListServlet" class="quick-action-item">
                            <i class="fas fa-tasks"></i>
                            <span>Manage Room Allocations</span>
                        </a>
                        <a href="add_room.jsp" class="quick-action-item">
                            <i class="fas fa-plus-circle"></i>
                            <span>Add New Room</span>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Manage Fees Card -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <h3>Manage Fees</h3>
                    <p>View student fees, mark payments as received and add new fee records.</p>
                    <div class="quick-actions">
                        <a href="FeeListServlet" class="quick-action-item">
                            <i class="fas fa-money-bill-wave"></i>
                            <span>View/Mark Fees/Add New Fee</span>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Review Leave Applications Card -->
            <div class="col-md-6">
                <div class="dashboard-card">
                    <i class="fas fa-clipboard-list"></i>
                    <h3>Review Leave Applications</h3>
                    <p>Approve or reject student leave applications and manage leave records.</p>
                    <div class="quick-actions">
                        <a href="WardenLeaveServlet" class="quick-action-item">
                            <i class="fas fa-check-circle"></i>
                            <span>Review Leave Applications</span>
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