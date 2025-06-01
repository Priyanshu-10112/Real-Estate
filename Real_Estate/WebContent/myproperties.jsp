<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Real_Estate.entity.Properties" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Properties - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        .table {
            margin-bottom: 0;
        }
        
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            color: #495057;
            font-weight: 600;
            padding: 12px;
        }
        
        .table tbody td {
            padding: 12px;
            vertical-align: middle;
        }
        
        .property-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
        }
        
        .status-available {
            background-color: #e8f5e9;
            color: #2e7d32;
        }
        
        .status-sold {
            background-color: #ffebee;
            color: #c62828;
        }
        
        .status-rent {
            background-color: #e3f2fd;
            color: #1565c0;
        }
        
        .status-pre_launch {
            background-color: #fff3e0;
            color: #ef6c00;
        }
        
        .btn-group .btn {
            padding: 6px 12px;
            margin: 0 2px;
        }
        
        .btn-group .btn i {
            margin-right: 4px;
        }
        
        .card {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: none;
        }
        
        .card-header {
            background-color: #fff;
            border-bottom: 1px solid #eee;
            padding: 15px 20px;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .table-responsive {
            border-radius: 4px;
            overflow: hidden;
        }
    </style>
</head>
<body>
    <!-- Top Navbar (Bootstrap) -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/agent/dashboard">
                LuxuryEstate
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agent/dashboard">
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/agent/properties/my">
                            My Properties
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agent/clients">
                            Clients
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agent/appointments">
                            Appointments
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard/profile">
                            Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row align-items-center mb-4">
            <div class="col-md-6">
                <h1 class="section-title mb-0">My Properties</h1>
            </div>
            <div class="col-md-6 text-end">
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPropertyModal">
                    Add New Property
                </button>
            </div>
        </div>

        <!-- Property List -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0">My Properties</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Property Type</th>
                                        <th>Price</th>
                                        <th>Status</th>
                                        <th>Address</th>
                                        <th>City</th>
                                        <th>Agent</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    List<Properties> p = (List<Properties>) request.getAttribute("AllProperties");
                                    User u1 = (User) request.getAttribute("user");
                                    %>
                                    <% for(Properties p1:p){%>
                                        <tr>
                                            <td><%= p1.getPropertyType() %></td>
                                            <td><%= p1.getPrice() %></td>
                                            <td><span class="property-status status-<%= p1.getStatus().toString().toLowerCase() %>"><%= p1.getStatus() %></span></td>
                                            <td><%= p1.getAddress() %></td>
                                            <td><%= p1.getCity() %></td>
                                            <td><%= p1.getUser_id().getEmail() %></td>
                                            <td>
                                                <div class="btn-group">
                                                    <button class="btn btn-sm btn-outline-primary" title="Edit">
                                                        <i class="fas fa-edit"></i> Edit
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-info" title="View">
                                                        <i class="fas fa-eye"></i> View
                                                    </button>
                                                    <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                        <i class="fas fa-trash"></i> Delete
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Add Property Modal -->
    <div class="modal fade" id="addPropertyModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Property</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addPropertyForm" action="${pageContext.request.contextPath}/agent/properties/add" method="POST">
                        <div class="row">
                            <!-- Property Type -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Property Type</label>
                                <select name="propertyType" class="form-select" required>
                                    <option value="">Select Type</option>
                                    <option value="HOUSE">House</option>
                                    <option value="APARTMENT">Apartment</option>
                                </select>
                            </div>

                            <!-- Property Status -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Property Status</label>
                                <select name="status" class="form-select" required>
                                    <option value="">Select Status</option>
                                    <option value="AVAILABLE">Available</option>
                                    <option value="RENT">Rent</option>
                                    <option value="PRE_LAUNCH">Pre-launch</option>
                                    <option value="SOLD">Sold</option>
                                </select>
                            </div>
                        </div>

                        <!-- Location Details -->
                        <div class="mb-3">
                            <label class="form-label">Address</label>
                            <input type="text" name="address" class="form-control" required>
                        </div>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">City</label>
                                <input type="text" name="city" class="form-control" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">State</label>
                                <input type="text" name="state" class="form-control" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Zip Code</label>
                                <input type="text" name="zipCode" class="form-control" required>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Country</label>
                            <input type="text" name="country" class="form-control" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <div class="input-group">
                                <span class="input-group-text">$</span>
                                <input type="text" name="price" class="form-control" required>
                            </div>
                        </div>

                        <div class="text-end">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add Property</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Replace custom footer with shared footer include -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 