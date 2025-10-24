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
    <title>Add Room - Hostel Management System</title>
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
            max-width: 600px;
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
        
        .info-card {
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
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header-container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="h3 mb-1"><i class="fas fa-building me-2"></i>Hostel Management System</h1>
                    <p class="mb-0">Add New Room</p>
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
            <a href="RoomListServlet" class="btn btn-back me-2">
                <i class="fas fa-arrow-left me-1"></i> Back to Room List
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

        <!-- Add Room Form -->
        <div class="form-container">
            <div class="text-center mb-4">
                <div class="card-icon">
                    <i class="fas fa-door-open"></i>
                </div>
                <h2 class="form-title">Add New Room</h2>
            </div>

            <!-- Information Card -->
            <div class="info-card">
                <h5><i class="fas fa-info-circle me-2 text-primary"></i>Room Information</h5>
                <p class="mb-0 text-muted">Add a new room to the hostel inventory. Make sure to provide accurate room details for proper management.</p>
            </div>

            <form name="roomForm" method="post" action="AddRoomServlet" class="needs-validation" novalidate onsubmit="return validateRoomForm()">
                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-door-closed me-2"></i>Room Number:
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-hashtag"></i>
                        </span>
                        <input type="text" class="form-control" name="room_no" placeholder="Enter room number (e.g., 101, A12)" required>
                    </div>
                    <div class="invalid-feedback">
                        Room number is required.
                    </div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">
                        <i class="fas fa-layer-group me-2"></i>Floor:
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-building"></i>
                        </span>
                        <input type="text" class="form-control" name="floor" placeholder="Enter floor number (e.g., 1, 2, Ground)" required>
                    </div>
                    <div class="invalid-feedback">
                        Floor is required.
                    </div>
                </div>
                
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-users me-2"></i>Capacity:
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-user-friends"></i>
                        </span>
                        <input type="number" class="form-control" name="capacity" min="1" max="10" placeholder="Enter room capacity (1-10)" required>
                    </div>
                    <div class="invalid-feedback">
                        Capacity must be a number between 1 and 10.
                    </div>
                    <div class="form-text">
                        Enter the maximum number of students that can occupy this room (1-10).
                    </div>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <button type="reset" class="btn btn-outline-secondary me-md-2">
                        <i class="fas fa-redo me-1"></i> Reset Form
                    </button>
                    <button type="submit" class="btn btn-custom">
                        <i class="fas fa-plus-circle me-1"></i> Add Room
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Enhanced validation with Bootstrap styling
        function validateRoomForm() {
            var form = document.forms["roomForm"];
            var roomNo = form["room_no"].value.trim();
            var floor = form["floor"].value.trim();
            var capacity = form["capacity"].value.trim();
            var isValid = true;

            // Reset previous validation states
            form.classList.remove('was-validated');
            
            // Validate room number
            if (!roomNo) {
                form["room_no"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["room_no"].classList.remove('is-invalid');
            }

            // Validate floor
            if (!floor) {
                form["floor"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["floor"].classList.remove('is-invalid');
            }

            // Validate capacity
            if (!capacity || !/^[0-9]+$/.test(capacity) || capacity < 1 || capacity > 10) {
                form["capacity"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["capacity"].classList.remove('is-invalid');
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
            var form = document.forms["roomForm"];
            if (form) {
                var roomNoInput = form["room_no"];
                var floorInput = form["floor"];
                var capacityInput = form["capacity"];
                
                roomNoInput.addEventListener('input', function() {
                    if (!this.value.trim()) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                floorInput.addEventListener('input', function() {
                    if (!this.value.trim()) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                capacityInput.addEventListener('input', function() {
                    if (!this.value || !/^[0-9]+$/.test(this.value) || this.value < 1 || this.value > 10) {
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