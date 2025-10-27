<%@ page import="com.shms.model.Student, java.util.List" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !(sessionRole.equalsIgnoreCase("superintendent") || sessionRole.equalsIgnoreCase("warden"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Student> students = (List<Student>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Fee Payment - Hostel Management System</title>
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
        
        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
        }
        
        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
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
                    <p class="mb-0">Add Fee Payment</p>
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
        <div class="mb-3">
            <a href="FeeListServlet" class="btn btn-outline-custom">
                <i class="fas fa-arrow-left me-1"></i> Back to Fee List
            </a>
        </div>

        <!-- Add Fee Payment Form Card -->
        <div class="content-card">
            <h3 class="mb-4 text-center"><i class="fas fa-plus-circle me-2"></i>Add Fee Payment</h3>
            
            <form name="feeForm" method="post" action="AddFeeServlet" onsubmit="return validateFeeForm();">
                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-user-graduate me-1"></i> Student
                    </label>
                    <select name="student_id" class="form-select" required>
                        <option value="">Select Student</option>
                        <% for (Student s : students) { %>
                            <option value="<%= s.getId() %>"><%= s.getName() %> (<%= s.getRollNo() %>)</option>
                        <% } %>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-money-bill-wave me-1"></i> Amount
                    </label>
                    <input type="number" name="amount" class="form-control" step="0.01" min="0.01" placeholder="Enter amount" required />
                </div>
                
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-file-invoice me-1"></i> Fee Status
                    </label>
                    <select name="fee_status" class="form-select" required>
                        <option value="Paid">Paid</option>
                        <option value="Pending">Pending</option>
                    </select>
                </div>
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-custom btn-lg">
                        <i class="fas fa-save me-2"></i>Add Payment
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    function validateFeeForm() {
        var studentId = document.forms["feeForm"]["student_id"].value;
        var amount = document.forms["feeForm"]["amount"].value;
        if (!studentId || !amount) {
            alert("All the fields are required.");
            return false;
        }
        if (isNaN(amount) || parseFloat(amount) <= 0) {
            alert("Enter a valid positive amount.");
            return false;
        }
        return true;
    }
    </script>
</body>
</html>