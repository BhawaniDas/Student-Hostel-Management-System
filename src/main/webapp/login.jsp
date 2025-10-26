<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hostel Management System - Login</title>
    <!-- Bootstraps 5 CSS -->
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
            background: 
                linear-gradient(135deg, rgba(67, 97, 238, 0.85) 0%, rgba(63, 55, 201, 0.85) 100%),
                url('https://www.edexlive.com/uploads/2023/12/22/centurion-university-of-technology-and-management-odisha-has-been-ranked-a-by-naac.jpg?width=1200&enable=upscale') center/cover no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }
        
        /* Fallback background in case image doesn't load */
        body::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                linear-gradient(135deg, #6a11cb 0%, #2575fc 100%),
                url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" viewBox="0 0 100 100"><rect width="100" height="100" fill="%234361ee" opacity="0.1"/><path d="M30,20 L70,20 L80,40 L20,40 Z" fill="%23ffffff" opacity="0.1"/><rect x="35" y="40" width="10" height="30" fill="%23ffffff" opacity="0.1"/><rect x="55" y="40" width="10" height="30" fill="%23ffffff" opacity="0.1"/><rect x="25" y="70" width="50" height="5" fill="%23ffffff" opacity="0.1"/><circle cx="50" cy="15" r="5" fill="%23ffffff" opacity="0.1"/></svg>');
            background-size: cover, 150px;
            z-index: -2;
            display: none;
        }
        
        /* Animated overlay */
        body::after {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(255, 119, 198, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(120, 219, 255, 0.2) 0%, transparent 50%);
            animation: float 20s ease-in-out infinite;
            z-index: -1;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(1deg); }
        }
        
        .login-container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 450px;
            width: 100%;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            z-index: 1;
        }
        
        .login-header {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .login-header::before {
            content: "";
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            animation: pulse 8s infinite linear;
        }
        
        @keyframes pulse {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .login-header h2 {
            margin: 0;
            font-weight: 600;
            position: relative;
            z-index: 1;
        }
        
        .login-body {
            padding: 2rem;
            position: relative;
            z-index: 1;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            margin-bottom: 1.5rem;
            border: 1px solid #e1e5ee;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
            transform: translateY(-2px);
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
        
        .btn-login {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            border: none;
            border-radius: 10px;
            color: white;
            padding: 0.75rem;
            font-weight: 500;
            width: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .btn-login:active {
            transform: translateY(-1px);
        }
        
        .eye-btn {
            background: none;
            border: none;
            cursor: pointer;
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            z-index: 5;
            color: #6c757d;
        }
        
        .password-container {
            position: relative;
        }
        
        .logo {
            font-size: 2.5rem;
            color: white;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
        }
        
        .role-icon {
            font-size: 1.2rem;
            margin-right: 8px;
        }
        
        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #495057;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 5px;
            padding: 10px;
            margin-top: 15px;
        }
        
        .info-section {
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 2rem;
            margin-top: 2rem;
            max-width: 800px;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        
        .info-section h3 {
            color: var(--primary);
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .info-section p {
            color: #555;
            line-height: 1.6;
        }
        
        .contact-info {
            list-style: none;
            padding: 0;
        }
        
        .contact-info li {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
        }
        
        .contact-info i {
            color: var(--primary);
            margin-right: 10px;
            width: 20px;
        }
        
        footer {
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            text-align: center;
            padding: 1rem;
            margin-top: 2rem;
            border-radius: 10px;
            max-width: 800px;
            backdrop-filter: blur(5px);
        }
        
        .university-badge {
            background: linear-gradient(to right, #1a237e, #283593);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-size: 0.9rem;
            display: inline-block;
            margin-top: 1rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
        }
        
        @media (max-width: 576px) {
            .login-container {
                max-width: 100%;
            }
            
            .login-header, .login-body {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="container d-flex flex-column align-items-center">
        <!-- Login Section -->
        <div class="login-container">
            <div class="login-header">
                <div class="logo">
                    <i class="fas fa-building"></i>
                </div>
                <h2>Hostel Management System</h2>
                <p class="mb-0">Centurion University of Technology & Management</p>
                <div class="university-badge">
                    <i class="fas fa-award me-1"></i> NAAC 'A' Grade Accredited
                </div>
            </div>
            <div class="login-body">
                <form method="post" action="LoginServlet">
                    <div class="mb-3">
                        <label id="usernameLabel" class="form-label">
                            <i class="fas fa-user role-icon"></i>Username:
                        </label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-id-card"></i>
                            </span>
                            <input type="text" class="form-control" name="username" placeholder="Enter your username" required />
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="fas fa-lock role-icon"></i>Password:
                        </label>
                        <div class="password-container">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="fas fa-key"></i>
                                </span>
                                <input type="password" id="password" class="form-control" name="password" placeholder="Enter your password" required />
                            </div>
                            <button type="button" class="eye-btn" onclick="togglePassword()" tabindex="-1">
                                <i class="fas fa-eye" id="eye-icon"></i>
                            </button>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">
                            <i class="fas fa-user-tag role-icon"></i>Role:
                        </label>
                        <select name="role" id="role" class="form-select" onchange="toggleLabel()" required>
                            <option value="admin">Admin</option>
                            <option value="superintendent">Superintendent</option>
                            <option value="warden">Warden</option>
                            <option value="student">Student</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn btn-login">Login</button>
                    
                    <% 
                        String error = request.getParameter("error");
                        if (error != null) { 
                    %>
                        <div class="error-message mt-3">
                            <i class="fas fa-exclamation-circle"></i> <%= error %>
                        </div>
                    <% } %>
                </form>
            </div>
        </div>
        
        <!-- About Section -->
        <div class="info-section">
            <h3>About Our Hostel Management System</h3>
            <p>
                Our Hostel Management System is designed to streamline the administration of student accommodations at Centurion University. 
                With role-based access for administrators, wardens, superintendents, and students, our system provides 
                a comprehensive solution for managing room allocations, fee payments, leave applications, and more.
            </p>
            <p>
                The system features intuitive dashboards for different user types, making it easy to manage hostel 
                operations efficiently. Students can apply for leave, view their room details, and check fee status, 
                while administrators have complete control over room allocation, user management, and financial records.
            </p>
            <div class="row mt-4">
                <div class="col-md-4 text-center mb-3">
                    <i class="fas fa-users fa-2x text-primary mb-2"></i>
                    <h5>User Management</h5>
                    <p class="small">Manage students, wardens, and administrators with ease</p>
                </div>
                <div class="col-md-4 text-center mb-3">
                    <i class="fas fa-bed fa-2x text-primary mb-2"></i>
                    <h5>Room Allocation</h5>
                    <p class="small">Efficiently allocate and manage hostel rooms</p>
                </div>
                <div class="col-md-4 text-center mb-3">
                    <i class="fas fa-file-invoice-dollar fa-2x text-primary mb-2"></i>
                    <h5>Fee Management</h5>
                    <p class="small">Track and manage hostel fees and payments</p>
                </div>
            </div>
        </div>
        
        <!-- Contact Section -->
        <div class="info-section">
            <h3>Contact Us</h3>
            <div class="row">
                <div class="col-md-6">
                    <p>Have questions or need support? Get in touch with our team:</p>
                    <ul class="contact-info">
                        <li><i class="fas fa-map-marker-alt"></i> Centurion University, BBSR, Jatani, 752050</li>
                        <li><i class="fas fa-phone"></i> +91 9337738523</li>
                        <li><i class="fas fa-envelope"></i> support@cutm.ac.in</li>
                        <li><i class="fas fa-clock"></i> Mon - Fri: 9:00 AM - 5:00 PM</li>
                    </ul>
                </div>
                <div class="col-md-6">
                    <p>Centurion University Campus Facilities:</p>
                    <ul class="contact-info">
                        <li><i class="fas fa-wifi"></i> High-speed Wi-Fi Campus</li>
                        <li><i class="fas fa-utensils"></i> Modern Cafeteria</li>
                        <li><i class="fas fa-book"></i> Well-stocked Library</li>
                        <li><i class="fas fa-dumbbell"></i> Sports Facilities</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <!-- Footer -->
        <footer>
            <p class="mb-0">&copy; 2025 Centurion University Hostel Management System. All rights reserved.</p>
        </footer>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
    function toggleLabel() {
        var roleSelect = document.getElementById("role");
        var label = document.getElementById("usernameLabel");
        if (roleSelect.value === "student") {
            label.innerHTML = '<i class="fas fa-user role-icon"></i>Roll Number:';
        } else {
            label.innerHTML = '<i class="fas fa-user role-icon"></i>Username:';
        }
    }
    
    function togglePassword() {
        var pw = document.getElementById("password");
        var eyeIcon = document.getElementById("eye-icon");
        
        if (pw.type === "password") {
            pw.type = "text";
            eyeIcon.classList.remove("fa-eye");
            eyeIcon.classList.add("fa-eye-slash");
        } else {
            pw.type = "password";
            eyeIcon.classList.remove("fa-eye-slash");
            eyeIcon.classList.add("fa-eye");
        }
    }
    
    // Fallback if the background image doesn't load
    window.addEventListener('load', function() {
        var img = new Image();
        img.onerror = function() {
            document.body.style.background = "linear-gradient(135deg, #6a11cb 0%, #2575fc 100%)";
            document.querySelector('body::before').style.display = 'block';
        };
        img.src = 'https://www.edexlive.com/uploads/2023/12/22/centurion-university-of-technology-and-management-odisha-has-been-ranked-a-by-naac.jpg?width=1200&enable=upscale';
    });
    </script>
</body>
</html>