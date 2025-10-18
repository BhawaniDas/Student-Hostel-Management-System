<%@ page import="com.shms.model.Room,com.shms.model.Student,java.util.List" %>
<%
    List<Room> rooms = (List<Room>) request.getAttribute("rooms");
    List<Student> students = (List<Student>) request.getAttribute("students");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Allocate Room - Hostel Management System</title>
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
        
        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #e1e5ee;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
        }
        
        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #e1e5ee;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }
        
        .input-group .form-control, .input-group .form-select {
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
        
        .student-option, .room-option {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
        }
        
        .student-details, .room-details {
            display: flex;
            flex-direction: column;
        }
        
        .student-name {
            font-weight: 500;
        }
        
        .student-roll {
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .room-number {
            font-weight: 500;
        }
        
        .room-floor {
            font-size: 0.875rem;
            color: #6c757d;
        }
        
        .room-capacity {
            font-size: 0.875rem;
            color: #28a745;
            font-weight: 500;
        }
        
        .date-inputs {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        @media (max-width: 768px) {
            .form-container {
                padding: 1.5rem;
            }
            
            .header-container {
                padding: 1rem 1.5rem;
            }
            
            .date-inputs {
                grid-template-columns: 1fr;
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
                    <p class="mb-0">Room Allocation</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="StudentListServlet" class="btn btn-light btn-sm">
                        <i class="fas fa-arrow-left me-1"></i> Back to Student List
                    </a>
                </div>
            </div>
        </div>

        <!-- Room Allocation Form -->
        <div class="form-container">
            <div class="text-center mb-4">
                <div class="card-icon">
                    <i class="fas fa-bed"></i>
                </div>
                <h2 class="form-title">Allocate Room to Student</h2>
            </div>

            <!-- Information Card -->
            <div class="info-card">
                <h5><i class="fas fa-info-circle me-2 text-primary"></i>Room Allocation Information</h5>
                <p class="mb-0 text-muted">Assign a student to a room for a specific time period. Make sure the room has available capacity and the dates are valid.</p>
            </div>

            <form name="allocationForm" method="post" action="AllocateRoomServlet" class="needs-validation" novalidate onsubmit="return validateAllocationForm()">
                <!-- Student Selection -->
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-user-graduate me-2"></i>Select Student:
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-user"></i>
                        </span>
                        <select name="student_id" class="form-select" required>
                            <option value="">Choose a student...</option>
                            <% for (Student s : students) { %>
                                <option value="<%= s.getId() %>">
                                    <div class="student-option">
                                        <div class="student-details">
                                            <span class="student-name"><%= s.getName() %></span>
                                            <span class="student-roll">Roll No: <%= s.getRollNo() %></span>
                                        </div>
                                    </div>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="invalid-feedback">
                        Please select a student.
                    </div>
                </div>
                
                <!-- Room Selection -->
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-door-open me-2"></i>Select Room:
                    </label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-bed"></i>
                        </span>
                        <select name="room_id" class="form-select" required>
                            <option value="">Choose a room...</option>
                            <% for (Room r : rooms) { %>
                                <option value="<%= r.getId() %>">
                                    <div class="room-option">
                                        <div class="room-details">
                                            <span class="room-number">Room <%= r.getRoomNo() %></span>
                                            <span class="room-floor">Floor <%= r.getFloor() %></span>
                                        </div>
                                        <span class="room-capacity">
                                            <%= r.getOccupancy() %> / <%= r.getCapacity() %>
                                        </span>
                                    </div>
                                </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="invalid-feedback">
                        Please select a room.
                    </div>
                </div>
                
                <!-- Date Selection -->
                <div class="mb-4">
                    <label class="form-label">
                        <i class="fas fa-calendar-alt me-2"></i>Allocation Period:
                    </label>
                    <div class="date-inputs">
                        <div>
                            <label class="form-label small">From Date</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-calendar-plus"></i>
                                </span>
                                <input type="date" class="form-control" name="date_from" required>
                            </div>
                            <div class="invalid-feedback">
                                Please select a start date.
                            </div>
                        </div>
                        <div>
                            <label class="form-label small">To Date</label>
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-calendar-minus"></i>
                                </span>
                                <input type="date" class="form-control" name="date_to" required>
                            </div>
                            <div class="invalid-feedback">
                                Please select an end date.
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <a href="StudentListServlet" class="btn btn-back me-md-2">
                        <i class="fas fa-times me-1"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-custom">
                        <i class="fas fa-check-circle me-1"></i> Allocate Room
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Enhanced validation with Bootstrap styling
        function validateAllocationForm() {
            var form = document.forms["allocationForm"];
            var studentId = form["student_id"].value;
            var roomId = form["room_id"].value;
            var dateFrom = form["date_from"].value;
            var dateTo = form["date_to"].value;
            var isValid = true;

            // Reset previous validation states
            form.classList.remove('was-validated');
            
            // Validate student selection
            if (!studentId) {
                form["student_id"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["student_id"].classList.remove('is-invalid');
            }

            // Validate room selection
            if (!roomId) {
                form["room_id"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["room_id"].classList.remove('is-invalid');
            }

            // Validate dates
            if (!dateFrom) {
                form["date_from"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["date_from"].classList.remove('is-invalid');
            }

            if (!dateTo) {
                form["date_to"].classList.add('is-invalid');
                isValid = false;
            } else {
                form["date_to"].classList.remove('is-invalid');
            }

            // Validate date logic
            if (dateFrom && dateTo && new Date(dateFrom) > new Date(dateTo)) {
                form["date_from"].classList.add('is-invalid');
                form["date_to"].classList.add('is-invalid');
                isValid = false;
                
                // Create custom error message for date logic
                if (!document.getElementById('dateLogicError')) {
                    var errorDiv = document.createElement('div');
                    errorDiv.id = 'dateLogicError';
                    errorDiv.className = 'invalid-feedback d-block';
                    errorDiv.textContent = "'From' date must be before 'To' date.";
                    form["date_to"].parentNode.appendChild(errorDiv);
                }
            } else {
                // Remove custom error message if it exists
                var existingError = document.getElementById('dateLogicError');
                if (existingError) {
                    existingError.remove();
                }
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

        // Real-time validation as user interacts
        document.addEventListener('DOMContentLoaded', function() {
            var form = document.forms["allocationForm"];
            if (form) {
                var studentSelect = form["student_id"];
                var roomSelect = form["room_id"];
                var dateFromInput = form["date_from"];
                var dateToInput = form["date_to"];
                
                studentSelect.addEventListener('change', function() {
                    if (!this.value) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                roomSelect.addEventListener('change', function() {
                    if (!this.value) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                    }
                });
                
                dateFromInput.addEventListener('change', function() {
                    if (!this.value) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                        // Validate date logic
                        if (dateToInput.value && new Date(this.value) > new Date(dateToInput.value)) {
                            this.classList.add('is-invalid');
                            dateToInput.classList.add('is-invalid');
                        } else {
                            dateToInput.classList.remove('is-invalid');
                        }
                    }
                });
                
                dateToInput.addEventListener('change', function() {
                    if (!this.value) {
                        this.classList.add('is-invalid');
                    } else {
                        this.classList.remove('is-invalid');
                        // Validate date logic
                        if (dateFromInput.value && new Date(dateFromInput.value) > new Date(this.value)) {
                            this.classList.add('is-invalid');
                            dateFromInput.classList.add('is-invalid');
                        } else {
                            dateFromInput.classList.remove('is-invalid');
                        }
                    }
                });
            }
            
            // Set minimum date to today for date inputs
            var today = new Date().toISOString().split('T')[0];
            document.querySelector('input[name="date_from"]').setAttribute('min', today);
            document.querySelector('input[name="date_to"]').setAttribute('min', today);
        });
    </script>
</body>
</html>