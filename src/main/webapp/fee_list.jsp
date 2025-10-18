<%@ page import="com.shms.model.FeePayment, com.shms.model.Student, java.util.List, java.util.Map" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !(sessionRole.equalsIgnoreCase("superintendent") || sessionRole.equalsIgnoreCase("warden"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<FeePayment> payments = (List<FeePayment>) request.getAttribute("payments");
    Map<Integer, Student> studentMap = (Map<Integer, Student>) request.getAttribute("studentMap");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fee Payment List - Hostel Management System</title>
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
        
        .table-custom {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }
        
        .table-custom thead {
            background-color: var(--primary);
            color: white;
        }
        
        .table-custom th {
            border: none;
            padding: 1rem;
            font-weight: 500;
        }
        
        .table-custom td {
            padding: 1rem;
            vertical-align: middle;
        }
        
        .badge-status {
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-weight: 500;
        }
        
        .badge-paid {
            background-color: rgba(40, 167, 69, 0.1);
            color: #28a745;
        }
        
        .badge-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        
        .badge-overdue {
            background-color: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }
        
        .action-buttons a {
            margin-right: 5px;
            text-decoration: none;
        }
        
        .amount-paid {
            font-weight: 600;
            color: #28a745;
        }
        
        .stats-card {
            background-color: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s;
            border-left: 4px solid var(--primary);
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .stats-card i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 1rem;
        }
        
        .stats-card h3 {
            font-size: 1.8rem;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        
        .stats-card p {
            color: #6c757d;
            margin: 0;
        }
        
        @media (max-width: 768px) {
            .content-card {
                padding: 1rem;
            }
            
            .header-container {
                padding: 1rem 1.5rem;
            }
            
            .table-responsive {
                font-size: 0.9rem;
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
                    <p class="mb-0">Fee Payment Management</p>
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

        <!-- Back Button and Add Fee -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <div>
                <% if ("warden".equalsIgnoreCase(sessionRole)) { %>
                    <a href="WardenDashboardServlet" class="btn btn-outline-custom">
                        <i class="fas fa-arrow-left me-1"></i> Back to Warden Dashboard
                    </a>
                <% } else if ("superintendent".equalsIgnoreCase(sessionRole)) { %>
                    <a href="SuperintendentDashboardServlet" class="btn btn-outline-custom">
                        <i class="fas fa-arrow-left me-1"></i> Back to Superintendent Dashboard
                    </a>
                <% } %>
            </div>
            <a href="FeePageServlet" class="btn btn-custom">
                <i class="fas fa-plus-circle me-1"></i> Add New Fee Payment
            </a>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="stats-card text-center">
                    <i class="fas fa-money-bill-wave"></i>
                    <h3>
                        <% 
                            int totalPayments = payments != null ? payments.size() : 0;
                        %>
                        <%= totalPayments %>
                    </h3>
                    <p>Total Payments</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card text-center">
                    <i class="fas fa-check-circle"></i>
                    <h3>
                        <% 
                            int paidCount = 0;
                            if (payments != null) {
                                for (FeePayment fee : payments) {
                                    if ("Paid".equalsIgnoreCase(fee.getFeeStatus())) {
                                        paidCount++;
                                    }
                                }
                            }
                        %>
                        <%= paidCount %>
                    </h3>
                    <p>Paid Fees</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stats-card text-center">
                    <i class="fas fa-clock"></i>
                    <h3>
                        <% 
                            int pendingCount = 0;
                            if (payments != null) {
                                for (FeePayment fee : payments) {
                                    if ("Pending".equalsIgnoreCase(fee.getFeeStatus())) {
                                        pendingCount++;
                                    }
                                }
                            }
                        %>
                        <%= pendingCount %>
                    </h3>
                    <p>Pending Fees</p>
                </div>
            </div>
        </div>

        <!-- Fee Payment List Card -->
        <div class="content-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0"><i class="fas fa-file-invoice-dollar me-2"></i>Fee Payment List</h3>
                <span class="text-muted">
                    <% if (payments != null) { %>
                        <%= payments.size() %> Payment(s)
                    <% } else { %>
                        0 Payments
                    <% } %>
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-custom">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Roll No</th>
                            <th>Name</th>
                            <th>Amount</th>
                            <th>Payment Date</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (payments != null && !payments.isEmpty()) {
                            for (FeePayment fee : payments) {
                                Student stu = studentMap != null ? studentMap.get(fee.getStudentId()) : null;
                                String badgeClass = "badge-status ";
                                if ("Paid".equalsIgnoreCase(fee.getFeeStatus())) {
                                    badgeClass += "badge-paid";
                                } else if ("Pending".equalsIgnoreCase(fee.getFeeStatus())) {
                                    badgeClass += "badge-pending";
                                } else {
                                    badgeClass += "badge-overdue";
                                }
                        %>
                        <tr>
                            <td><%= fee.getId() %></td>
                            <td><strong><%= stu != null ? stu.getRollNo() : "N/A" %></strong></td>
                            <td><%= stu != null ? stu.getName() : "N/A" %></td>
                            <td class="amount-paid"><%= String.format("%.0f", fee.getAmount()) %></td>
                            <td><%= fee.getPaymentDate() %></td>
                            <td>
                                <span class="<%= badgeClass %>">
                                    <i class="fas fa-<%= "Paid".equalsIgnoreCase(fee.getFeeStatus()) ? "check" : "clock" %> me-1"></i>
                                    <%= fee.getFeeStatus() %>
                                </span>
                            </td>
                            <td class="action-buttons">
                                <a href="EditFeeServlet?id=<%= fee.getId() %>" class="btn btn-outline-custom btn-sm">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="DeleteFeeServlet?id=<%= fee.getId() %>" 
                                   class="btn btn-outline-danger btn-sm"
                                   onclick="return confirm('Are you sure you want to delete this payment?');">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                        <%    }
                            } else { %>
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <i class="fas fa-file-invoice-dollar fa-2x text-muted mb-2"></i>
                                <p class="text-muted">No fee payments found.</p>
                                <a href="FeePageServlet" class="btn btn-custom">
                                    <i class="fas fa-plus-circle me-1"></i> Add Your First Payment
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>