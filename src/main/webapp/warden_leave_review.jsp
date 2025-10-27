<%@ page import="com.shms.model.LeaveApplication" %>
<%@ page import="java.util.List" %>
<%
    String sessionRole = (String) session.getAttribute("role");
    if (session.getAttribute("username") == null || sessionRole == null
        || !(sessionRole.equalsIgnoreCase("superintendent") || sessionRole.equalsIgnoreCase("warden"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<LeaveApplication> pendingLeaves = (List<LeaveApplication>) request.getAttribute("pendingLeaves");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pending Leave Applications - Hostel Management System</title>
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
        
        .badge-pending {
            background-color: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }
        
        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
        }
        
        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(67, 97, 238, 0.25);
        }
        
        .action-buttons {
            display: flex;
            gap: 0.5rem;
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
            
            .action-buttons {
                flex-direction: column;
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
                    <p class="mb-0">Pending Leave Applications</p>
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
            <a href="WardenDashboardServlet" class="btn btn-outline-custom">
                <i class="fas fa-arrow-left me-1"></i> Back to Warden Dashboard
            </a>
        </div>

        <!-- Leave Applications Card -->
        <div class="content-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0"><i class="fas fa-clipboard-list me-2"></i>Pending Leave Applications</h3>
                <span class="text-muted">
                    <% if (pendingLeaves != null) { %>
                        <%= pendingLeaves.size() %> Application(s)
                    <% } else { %>
                        0 Applications
                    <% } %>
                </span>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-custom">
                    <thead>
                        <tr>
                            <th>Roll No</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Reason</th>
                            <th>Guardian No</th>
                            <th>Status</th>
                            <th>Remarks</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (pendingLeaves != null) {
                                for (LeaveApplication leave : pendingLeaves) {
                        %>
                        <tr>
                            <form method="post" action="WardenLeaveServlet">
                                <input type="hidden" name="id" value="<%=leave.getId()%>" />
                                <td><strong><%=leave.getRollNo()%></strong></td>
                                <td><%=leave.getFromDate()%></td>
                                <td><%=leave.getToDate()%></td>
                                <td><%=leave.getReason()%></td>
                                <td><%=leave.getGuardianNumber()%></td>
                                <td>
                                    <span class="badge badge-status badge-pending">
                                        <i class="fas fa-clock me-1"></i> <%=leave.getStatus()%>
                                    </span>
                                </td>
                                <td>
                                    <input type="text" name="remarks" class="form-control" 
                                           value="<%=leave.getRemarks() == null ? "" : leave.getRemarks()%>"
                                           placeholder="Enter remarks...">
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <select name="status" class="form-select">
                                            <option value="Approved">Approve</option>
                                            <option value="Rejected">Reject</option>
                                        </select>
                                        <button type="submit" class="btn btn-custom">
                                            <i class="fas fa-paper-plane me-1"></i> Submit
                                        </button>
                                    </div>
                                </td>
                            </form>
                        </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
                <%
                    if (pendingLeaves == null || pendingLeaves.isEmpty()) {
                %>
                <div class="text-center py-5">
                    <i class="fas fa-clipboard-check fa-3x text-muted mb-3"></i>
                    <h4 class="text-muted">No Pending Applications</h4>
                    <p class="text-muted">There are no pending leave applications at this time.</p>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>