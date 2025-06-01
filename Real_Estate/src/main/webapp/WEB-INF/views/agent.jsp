<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Real_Estate.entity.Properties" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Dashboard - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            --secondary-gradient: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            --success-gradient: linear-gradient(135deg, #2ecc71 0%, #27ae60 100%);
            --warning-gradient: linear-gradient(135deg, #f1c40f 0%, #f39c12 100%);
            --danger-gradient: linear-gradient(135deg, #e74c3c 0%, #c0392b 100%);
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
        }

        .navbar {
            background: var(--primary-gradient) !important;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 0.8rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar-brand i {
            font-size: 1.8rem;
            color: #fff;
        }

        .navbar-brand span {
            color: #fff;
        }

        .navbar-nav {
            gap: 0.5rem;
        }

        .nav-item {
            position: relative;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .nav-link i {
            font-size: 1.1rem;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #fff !important;
            transform: translateY(-2px);
        }

        .nav-link.active {
            background: rgba(255, 255, 255, 0.15);
            color: #fff !important;
        }

        .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 30px;
            height: 3px;
            background: #fff;
            border-radius: 3px;
        }

        .navbar-toggler {
            border: none;
            padding: 0.5rem;
            margin-right: 1rem;
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%28255, 255, 255, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: var(--primary-gradient);
                padding: 1rem;
                border-radius: 10px;
                margin-top: 1rem;
            }

            .nav-link {
                padding: 0.8rem 1rem !important;
            }

            .nav-link.active::after {
                display: none;
            }
        }

        .dashboard-container {
            margin-top: 80px;
            padding: 20px 0;
        }

        .section-title {
            color: #2c3e50;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            height: 100%;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #7f8c8d;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .add-property-btn {
            background: var(--primary-gradient);
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .add-property-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
            color: white;
        }

        .search-filters {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }

        .form-control, .form-select {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 0.2rem rgba(44, 62, 80, 0.15);
            border-color: #2c3e50;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }

        .card-header {
            background: white;
            border-bottom: 1px solid #eee;
            padding: 1.25rem;
            border-radius: 15px 15px 0 0 !important;
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            font-weight: 600;
            color: #2c3e50;
            border-top: none;
        }

        .table td {
            vertical-align: middle;
        }

        .property-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.9rem;
        }

        .status-available { background: #e8f5e9; color: #2e7d32; }
        .status-rent { background: #e3f2fd; color: #1565c0; }
        .status-pre_launch { background: #fff3e0; color: #ef6c00; }
        .status-sold { background: #fce4ec; color: #c2185b; }

        .btn-group .btn {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            margin: 0 2px;
            font-weight: 500;
        }

        .modal-content {
            border-radius: 15px;
            border: none;
        }

        .modal-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 2rem;
        }

        .btn-close {
            filter: brightness(0) invert(1);
        }

        .form-label {
            font-weight: 500;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .input-group-text {
            background: #f8f9fa;
            border: 1px solid #e0e0e0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/agent/dashboard">
                <i class="fas fa-user-tie"></i>
                <span>Agent Portal</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/agent/dashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agent/properties">
                            <i class="fas fa-building"></i>
                            <span>My Properties</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agent/clients">
                            <i class="fas fa-users"></i>
                            <span>Clients</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/agent/appointments">
                            <i class="fas fa-calendar-check"></i>
                            <span>Appointments</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                            <i class="fas fa-user-circle"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="dashboard-container">
        <div class="container">
            <div class="row align-items-center mb-4">
                <div class="col-md-6">
                    <h1 class="section-title mb-0">Agent Dashboard</h1>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn add-property-btn" data-bs-toggle="modal" data-bs-target="#addPropertyModal">
                        <i class="fas fa-plus me-2"></i>Add New Property
                    </button>
                </div>
            </div>

            <!-- Dashboard Stats -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-value"></div>
                        <div class="stat-label">Total Properties</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-value"></div>
                        <div class="stat-label">Active Listings</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-value"></div>
                        <div class="stat-label">Total Clients</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-card">
                        <div class="stat-value"></div>
                        <div class="stat-label">Appointments Today</div>
                    </div>
                </div>
            </div>

            <!-- Search and Filters -->
           <div class="property-filter-section filter-left">
                <div class="filter-section mb-4">
                    <div class="card filter-card-left">
                        <div class="card-body">
                            <form id="propertyFilter" action="${pageContext.request.contextPath}/user/dashboard/filter" method="GET" class="row g-2 align-items-end flex-wrap">
                                <div class="col-auto pe-3">
                                    <label class="form-label">Price Range</label>
                                    <select class="form-select" name="price">
                                        <option value="">Any Price</option>
                                        <option value="100000">Under ₹100,000</option>
                                        <option value="250000">Under ₹250,000</option>
                                        <option value="500000">Under ₹500,000</option>
                                        <option value="1000000">Under ₹1,000,000</option>
                                        <option value="2000000">Under ₹2,000,000</option>
                                        <option value="5000000">Under ₹5,000,000</option>
                                    </select>
                                </div>
                                <div class="col-auto pe-3">
                                    <label class="form-label">Property Type</label>
                                    <select class="form-select" name="propertyType">
                                        <option value="">All Types</option>
                                        <option value="APARTMENT_FLAT">Apartment / Flat</option>
                                        <option value="INDEPENDENT_HOUSE_VILLA">Independent House / Villa</option>
                                        <option value="BUILDER_FLOOR_APARTMENT">Builder Floor Apartment</option>
                                        <option value="STUDIO_APARTMENT">Studio Apartment</option>
                                        <option value="PENTHOUSE">Penthouse</option>
                                        <option value="ROW_HOUSE_TOWNHOUSE">Row House / Townhouse</option>
                                        <option value="RESIDENTIAL_PLOT_LAND">Residential Plot / Land</option>
                                        <option value="COMMERCIAL_OFFICE_SPACE">Commercial Office Space</option>
                                        <option value="SHOP_SHOWROOM">Shop / Showroom</option>
                                        <option value="WAREHOUSE_GODOWN">Warehouse / Godown</option>
                                        <option value="INDUSTRIAL_LAND_FACTORY">Industrial Land / Factory</option>
                                        <option value="AGRICULTURAL_LAND_FARMLAND">Agricultural Land / Farmland</option>
                                        <option value="MIXED_USE_PROPERTY">Mixed-Use Property</option>
                                        <option value="CO_WORKING_SPACE">Co-working Space</option>
                                        <option value="VACANT_LAND_NON_AGRICULTURAL">Vacant Land (Non-agricultural)</option>
                                    </select>
                                </div>
                                <div class="col-auto pe-3">
                                    <label class="form-label">Status</label>
                                    <select class="form-select" name="status">
                                        <option value="">All Status</option>
                                        <option value="AVAILABLE">Available</option>
                                        <option value="RENT">Rent</option>
                                        <option value="PRE_LAUNCH">Pre-launch</option>
                                        <option value="SOLD">Sold</option>
                                    </select>
                                </div>
                                <div class="col-auto pe-3">
                                    <label class="form-label">City</label>
                                    <input type="text" class="form-control" placeholder="Enter City" name="city" list="cityList">
                                    <datalist id="cityList">
                                        <!-- Madhya Pradesh Cities -->
                                        <option value="Indore, Madhya Pradesh">
                                        <option value="Bhopal, Madhya Pradesh">
                                        <option value="Jabalpur, Madhya Pradesh">
                                        <option value="Gwalior, Madhya Pradesh">
                                        <option value="Ujjain, Madhya Pradesh">
                                        <option value="Sagar, Madhya Pradesh">
                                        <option value="Dewas, Madhya Pradesh">
                                        <option value="Satna, Madhya Pradesh">
                                        <option value="Ratlam, Madhya Pradesh">
                                        <option value="Rewa, Madhya Pradesh">
                                        <option value="Murwara, Madhya Pradesh">
                                        <option value="Singrauli, Madhya Pradesh">
                                        <option value="Burhanpur, Madhya Pradesh">
                                        <option value="Khandwa, Madhya Pradesh">
                                        <option value="Morena, Madhya Pradesh">
                                        <option value="Bhind, Madhya Pradesh">
                                        <option value="Chhindwara, Madhya Pradesh">
                                        <option value="Guna, Madhya Pradesh">
                                        <option value="Shivpuri, Madhya Pradesh">
                                        <option value="Vidisha, Madhya Pradesh">
                                    </datalist>
                                </div>
                                <div class="col-auto pe-3">
                                    <label class="form-label">Address</label>
                                    <input type="text" class="form-control" placeholder="Enter address" name="address">
                                </div>
                                <div class="col-auto pe-3">
                                    <label class="form-label">Area</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" placeholder="Enter area" name="area" min="0" step="0.01">
                                        <select class="form-select" name="areaUnit" style="max-width: 100px;">
                                            <option value="sqft">sq ft</option>
                                            <option value="sqm">sq m</option>
                                            <option value="acres">acres</option>
                                            <option value="hectares">hectares</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-auto d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="fas fa-search"></i> Search
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Property List -->
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="mb-0">ALL Properties</h5>
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
                                            <th>Area</th>
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
                                                <td>₹ <%= p1.getPrice() %></td>
                                                <td><span class="property-status status-<%= p1.getStatus().toString().toLowerCase() %>"><%= p1.getStatus() %></span></td>
                                                <td><%= p1.getAddress() %></td>
                                                <td><%= p1.getCity() %></td>
                                                <td><%= p1.getArea()%>  <%=p1.getAreaUnit()%></td>
                                                <td><%= p1.getUser_id().getEmail() %></td>                                            
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-sm btn-outline-primary" title="Edit">
                                                            Edit
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-info" title="View">
                                                            View
                                                        </button>
                                                        <button class="btn btn-sm btn-outline-danger" title="Delete">
                                                            Delete
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
                    <form id="addPropertyForm" action="${pageContext.request.contextPath}/agent/properties/add" method="post">
                        <div class="row">
                            <!-- Property Type -->
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Property Type</label>
                                <select name="propertyType" class="form-select" required>
                                    <option value="">Select Type</option>
                                    <option value="APARTMENT_FLAT">Apartment / Flat</option>
                                    <option value="INDEPENDENT_HOUSE_VILLA">Independent House / Villa</option>
                                    <option value="BUILDER_FLOOR_APARTMENT">Builder Floor Apartment</option>
                                    <option value="STUDIO_APARTMENT">Studio Apartment</option>
                                    <option value="PENTHOUSE">Penthouse</option>
                                    <option value="ROW_HOUSE_TOWNHOUSE">Row House / Townhouse</option>
                                    <option value="RESIDENTIAL_PLOT_LAND">Residential Plot / Land</option>
                                    <option value="COMMERCIAL_OFFICE_SPACE">Commercial Office Space</option>
                                    <option value="SHOP_SHOWROOM">Shop / Showroom</option>
                                    <option value="WAREHOUSE_GODOWN">Warehouse / Godown</option>
                                    <option value="INDUSTRIAL_LAND_FACTORY">Industrial Land / Factory</option>
                                    <option value="AGRICULTURAL_LAND_FARMLAND">Agricultural Land / Farmland</option>
                                    <option value="MIXED_USE_PROPERTY">Mixed-Use Property</option>
                                    <option value="CO_WORKING_SPACE">Co-working Space</option>
                                    <option value="VACANT_LAND_NON_AGRICULTURAL">Vacant Land (Non-agricultural)</option>
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
                            <div class="col-md-6 mb-3">
                                    <label class="form-label">City</label>
                                    <input type="text" class="form-control" placeholder="Enter City" name="city" list="cityList">
                                    <datalist id="cityList">
                                        <!-- Madhya Pradesh Cities -->
                                        <option value="Indore, Madhya Pradesh">
                                        <option value="Bhopal, Madhya Pradesh">
                                        <option value="Jabalpur, Madhya Pradesh">
                                        <option value="Gwalior, Madhya Pradesh">
                                        <option value="Ujjain, Madhya Pradesh">
                                        <option value="Sagar, Madhya Pradesh">
                                        <option value="Dewas, Madhya Pradesh">
                                        <option value="Satna, Madhya Pradesh">
                                        <option value="Ratlam, Madhya Pradesh">
                                        <option value="Rewa, Madhya Pradesh">
                                        <option value="Murwara, Madhya Pradesh">
                                        <option value="Singrauli, Madhya Pradesh">
                                        <option value="Burhanpur, Madhya Pradesh">
                                        <option value="Khandwa, Madhya Pradesh">
                                        <option value="Morena, Madhya Pradesh">
                                        <option value="Bhind, Madhya Pradesh">
                                        <option value="Chhindwara, Madhya Pradesh">
                                        <option value="Guna, Madhya Pradesh">
                                        <option value="Shivpuri, Madhya Pradesh">
                                        <option value="Vidisha, Madhya Pradesh">
                                    </datalist>
                                </div>
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Zip Code</label>
                                <input type="text" name="zipCode" class="form-control" required>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Price</label>
                            <div class="input-group">
                                <span class="input-group-text">₹</span>
                                <input type="text" name="price" class="form-control" required>
                            </div>
                        </div>
                        <div class="mb-3">
                        <label class="form-label">Size</label>
							<div class="input-group">
                        <input type="number" class="form-control" placeholder="Area" name="area" min="0" step="0.01">
                        <select class="form-select" name="areaUnit" style="max-width: 100px;">
                            <option value="sqft">sq ft</option>
                            <option value="sqm">sq m</option>
                            <option value="acres">acres</option>
                            <option value="hectares">hectares</option>
                        </select>
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
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
</body>
</html> 