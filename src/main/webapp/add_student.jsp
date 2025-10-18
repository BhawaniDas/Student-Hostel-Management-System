<%@ page import="com.shms.model.Student" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !(sessionRole.equalsIgnoreCase("superintendent") || sessionRole.equalsIgnoreCase("warden"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student - Hostel Management System</title>
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
            max-width: 700px;
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
        
        .alert-custom {
            border-radius: 10px;
            border: none;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }
        
        .is-invalid {
            border-color: #dc3545;
        }
        
        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }
        
        .was-validated .form-control:invalid ~ .invalid-feedback,
        .form-control.is-invalid ~ .invalid-feedback {
            display: block;
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
                    <p class="mb-0">Add New Student</p>
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

        <!-- Messages -->
        <% if (message != null) { %>
            <div class="alert alert-success alert-custom" role="alert">
                <i class="fas fa-check-circle me-2"></i> <%= message %>
            </div>
        <% 
            session.removeAttribute("message");
        } %>
        
        <% if (error != null) { %>
            <div class="alert alert-danger alert-custom" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i> <%= error %>
            </div>
        <% 
            session.removeAttribute("error");
        } %>

        <!-- Back Buttons -->
        <div class="mb-3">
            <a href="StudentListServlet" class="btn btn-back me-2">
                <i class="fas fa-arrow-left me-1"></i> Back to Student List
            </a>
            <% if ("warden".equalsIgnoreCase(sessionRole)) { %>
                <a href="WardenDashboardServlet" class="btn btn-back">
                    <i class="fas fa-tachometer-alt me-1"></i> Back to Warden Dashboard
                </a>
            <% } else if ("superintendent".equalsIgnoreCase(sessionRole)) { %>
                <a href="SuperintendentDashboardServlet" class="btn btn-back">
                    <i class="fas fa-tachometer-alt me-1"></i> Back to Superintendent Dashboard
                </a>
            <% } %>
        </div>

        <!-- Add Student Form -->
        <div class="form-container">
            <div class="text-center mb-4">
                <div class="card-icon">
                    <i class="fas fa-user-plus"></i>
                </div>
                <h2 class="form-title">Add New Student</h2>
            </div>

            <form name="studentForm" method="post" action="AddStudentServlet" class="needs-validation" novalidate onsubmit="return validateStudentForm()">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-user me-2"></i>Full Name:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-signature"></i>
                            </span>
                            <input type="text" class="form-control" name="name" placeholder="Enter student's full name" required>
                        </div>
                        <div class="invalid-feedback">
                            Name is required.
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-hashtag me-2"></i>Roll Number:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-id-card"></i>
                            </span>
                            <input type="text" class="form-control" name="roll_no" maxlength="6" 
                                   pattern="\d{6}" placeholder="Enter 6-digit roll number" required>
                        </div>
                        <div class="invalid-feedback">
                            Roll Number must be exactly 6 digits.
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-lock me-2"></i>Password:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-key"></i>
                            </span>
                            <input type="password" class="form-control" name="password" placeholder="Enter password" required>
                        </div>
                        <div class="invalid-feedback">
                            Password is required.
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-envelope me-2"></i>Email:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-at"></i>
                            </span>
                            <input type="email" class="form-control" name="email" placeholder="Enter email address">
                        </div>
                        <div class="invalid-feedback">
                            Please enter a valid email address.
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">
                            <i class="fas fa-phone me-2"></i>Contact Number:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-mobile-alt"></i>
                            </span>
                            <input type="text" class="form-control" name="contact" maxlength="15" 
                                   pattern="\d{10,15}" placeholder="Enter 10-15 digit contact number">
                        </div>
                        <div class="invalid-feedback">
                            Contact should be 10-15 digits.
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-4">
                        <label class="form-label">
                            <i class="fas fa-map-marker-alt me-2"></i>Address:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-home"></i>
                            </span>
                            <input type="text" class="form-control" name="address" placeholder="Enter student's address">
                        </div>
                    </div>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <button type="reset" class="btn btn-outline-secondary me-md-2">
                        <i class="fas fa-redo me-1"></i> Reset Form
                    </button>
                    <button type="submit" class="btn btn-custom">
                        <i class="fas fa-user-plus me-1"></i> Add Student
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Enhanced validation with Bootstrap styling
        function validateStudentForm() {
            var form = document.forms["studentForm"];
            var password = form["password"].value;
            var email = form["email"].value.trim();
            var name = form["name"].value.trim();
            var contact = form["contact"].value.trim();
            var roll_no = form["roll_no"].value.trim();
            var isValid = true;

            // Reset previous validation states
            form.classList.remove('was-validated');
            
            // Validate password
            if (!password) {
                form["password"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["password"].classList.remove('is-invalid');
            }

            // Validate name
            if (!name) {
                form["name"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["name"].classList.remove('is-invalid');
            }

            // Validate roll number
            if (!roll_no || !/^\d{6}$/.test(roll_no)) {
                form["roll_no"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["roll_no"].classList.remove('is-invalid');
            }

            // Validate email (if provided)
            if (email && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(email)) {
                form["email"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["email"].classList.remove('is-invalid');
            }

            // Validate contact (if provided)
            if (contact && !/^\d{10,15}$/.test(contact)) {
                form["contact"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["contact"].classList.remove('is-invalid');
            }

            if (!isValid) {
                form.classList.add('was-validated');
                // Scroll to first error
                var firstError = form.querySelector('.is-invalid');
                if (firstError) {
                    firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
                return false;
            }
            
            return true;
        }

        // Real-time validation as user types
        document.addEventListener('DOMContentLoaded', function() {
            var form = document.forms["studentForm"];
            if (form) {
                var passwordInput = form["password"];
                var nameInput = form["name"];
                var rollNoInput = form["roll_no"];
                var emailInput = form["email"];
                var contactInput = form["contact"];
                
                passwordInput.addEventListener('input', function() {
                    if (!this.value) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                nameInput.addEventListener('input', function() {
                    if (!this.value.trim()) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                rollNoInput.addEventListener('input', function() {
                    if (!this.value || !/^\d{6}$/.test(this.value)) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                emailInput.addEventListener('input', function() {
                    if (this.value && !/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(this.value)) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                contactInput.addEventListener('input', function() {
                    if (this.value && !/^\d{10,15}$/.test(this.value)) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
            }
        });
    </script>
</body>
</html>