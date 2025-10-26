<%@ page session="true" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !sessionRole.equalsIgnoreCase("student")) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String rollNo = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Apply Leave - Hostel Management System</title>
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
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
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
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
        }
        
        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        
        .readonly-field {
            background-color: #f8f9fa;
            opacity: 1;
        }
        
        @media (max-width: 768px) {
            .content-card {
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
                    <p class="mb-0">Apply for Leave</p>
                </div>
                <div class="col-md-4 text-end">
                    <span class="me-3">Welcome, Student!</span>
                </div>
            </div>
        </div>

        <!-- Back Button -->
        <div class="mb-3">
            <a href="StudentDashboardServlet" class="btn btn-outline-custom">
                <i class="fas fa-arrow-left me-1"></i> Back to Student Dashboard
            </a>
        </div>

        <!-- Apply Leave Form Card -->
        <div class="content-card">
            <h3 class="mb-4 text-center"><i class="fas fa-calendar-plus me-2"></i>Apply for Leave</h3>
            
            <form method="post" action="StudentLeaveApplyServlet">
                <div class="mb-3">
                    <label class="form-label">Roll No</label>
                    <input type="text" name="roll_no" class="form-control readonly-field" 
                           value="<%=rollNo%>" readonly />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">From Date</label>
                    <input type="date" name="from_date" class="form-control" required />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">To Date</label>
                    <input type="date" name="to_date" class="form-control" required />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Reason</label>
                    <input type="text" name="reason" class="form-control" 
                           placeholder="Enter reason for leave" required maxlength="255" />
                </div>
                
                <div class="mb-4">
                    <label class="form-label">Guardian Number</label>
                    <input type="text" name="guardian_number" class="form-control" 
                           placeholder="Enter guardian's contact number" required maxlength="10" />
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-custom btn-lg">
                        <i class="fas fa-paper-plane me-2"></i>Submit Application
                    </button>
                </div>
                
                <% if(request.getParameter("error") != null) { %>
                    <div class="alert alert-danger mt-3" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i> All fields are required.
                    </div>
                <% } %>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>