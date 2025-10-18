<%@ page import="com.shms.model.Student" %>
<%
    String message = (String) session.getAttribute("message");
    String error = (String) session.getAttribute("error");
    if (message != null) {
%>
    <p style="color:green;"><%= message %></p>
<%
        session.removeAttribute("message");
    }
    if (error != null) {
%>
    <p style="color:red;"><%= error %></p>
<%
        session.removeAttribute("error");
    }
    Student student = (Student) request.getAttribute("student");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Hostel Management System</title>
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
        
        .student-info-card {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--primary);
        }
        
        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
            
            .header-container {
                padding: 1rem 1.5rem;
            }
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header-container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="h3 mb-1"><i class="fas fa-building me-2"></i>Hostel Management System</h1>
                    <p class="mb-0">Edit Student Details</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="StudentListServlet" class="btn btn-light btn-sm">
                        <i class="fas fa-arrow-left me-1"></i> Back to Student List
                    </a>
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

        <!-- Student Not Found Message -->
        <% if (student == null) { %>
            <div class="form-container text-center">
                <div class="card-icon text-danger">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                <h3 class="text-danger">Student Not Found</h3>
                <p class="text-muted mb-4">The student details you're trying to edit could not be found.</p>
                <a href="StudentListServlet" class="btn btn-custom">
                    <i class="fas fa-arrow-left me-1"></i> Back to Student List
                </a>
            </div>
        <% } else { %>
            <!-- Edit Student Form -->
            <div class="form-container">
                <div class="text-center mb-4">
                    <div class="card-icon">
                        <i class="fas fa-user-edit"></i>
                    </div>
                    <h2 class="form-title">Edit Student Details</h2>
                </div>

                <!-- Student Info Summary -->
                <div class="student-info-card">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Current Roll Number:</strong> <%= student.getRollNo() %></p>
                            <p class="mb-1"><strong>Current Name:</strong> <%= student.getName() %></p>
                        </div>
                        <div class="col-md-6">
                            <% if (student.getContact() != null && !student.getContact().isEmpty()) { %>
                                <p class="mb-1"><strong>Current Contact:</strong> <%= student.getContact() %></p>
                            <% } %>
                            <% if (student.getAddress() != null && !student.getAddress().isEmpty()) { %>
                                <p class="mb-0"><strong>Current Address:</strong> <%= student.getAddress() %></p>
                            <% } %>
                        </div>
                    </div>
                </div>

                <form name="editStudentForm" action="EditStudentServlet" method="post" class="needs-validation" novalidate onsubmit="return validateEditStudentForm()">
                    <input type="hidden" name="id" value="<%= student.getId() %>"/>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="fas fa-id-card me-2"></i>Roll Number:
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-hashtag"></i>
                                </span>
                                <input type="text" class="form-control" name="roll_no" maxlength="6" 
                                       pattern="\d{6}" value="<%= student.getRollNo() %>" 
                                       placeholder="Enter 6-digit roll number" required>
                            </div>
                            <div class="invalid-feedback">
                                Roll Number is required and must be exactly 6 digits.
                            </div>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i class="fas fa-user me-2"></i>Full Name:
                            </label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-signature"></i>
                                </span>
                                <input type="text" class="form-control" name="name" maxlength="50" 
                                       value="<%= student.getName() %>" 
                                       placeholder="Enter student's full name" required>
                            </div>
                            <div class="invalid-feedback">
                                Name is required.
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
                                       pattern="\d{10,15}" 
                                       value="<%= student.getContact() != null ? student.getContact() : "" %>" 
                                       placeholder="Enter 10-15 digit contact number">
                            </div>
                            <div class="invalid-feedback">
                                Contact must be 10-15 digits if entered.
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
                                <input type="text" class="form-control" name="address" maxlength="100" 
                                       value="<%= student.getAddress() != null ? student.getAddress() : "" %>" 
                                       placeholder="Enter student's address">
                            </div>
                        </div>
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                        <a href="StudentListServlet" class="btn btn-back me-md-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-custom">
                            <i class="fas fa-save me-1"></i> Update Student
                        </button>
                    </div>
                </form>
            </div>
        <% } %>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Enhanced validation with Bootstrap styling
        function validateEditStudentForm() {
            var form = document.forms["editStudentForm"];
            var name = form["name"].value.trim();
            var contact = form["contact"].value.trim();
            var roll_no = form["roll_no"].value.trim();
            var isValid = true;

            // Reset previous validation states
            form.classList.remove('was-validated');
            
            // Validate roll number
            if (!roll_no || !/^\d{6}$/.test(roll_no)) {
                form["roll_no"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["roll_no"].classList.remove('is-invalid');
            }

            // Validate name
            if (!name) {
                form["name"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["name"].classList.remove('is-invalid');
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
            var form = document.forms["editStudentForm"];
            if (form) {
                var rollNoInput = form["roll_no"];
                var nameInput = form["name"];
                var contactInput = form["contact"];
                
                rollNoInput.addEventListener('input', function() {
                    if (this.value && !/^\d{6}$/.test(this.value)) {
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