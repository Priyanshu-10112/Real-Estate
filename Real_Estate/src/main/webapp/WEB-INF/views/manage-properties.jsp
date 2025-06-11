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
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
            --light-text: #ffffff;
            --card-shadow: 0 10px 20px rgba(0,0,0,0.1);
            --hover-shadow: 0 15px 30px rgba(0,0,0,0.15);
            --transition: all 0.3s ease;
            --gradient-primary: linear-gradient(135deg, #3498db, #2980b9);
            --gradient-secondary: linear-gradient(135deg, #2c3e50, #34495e);
            --transition: all 0.3s ease;
            --border-radius: 16px;
            --section-spacing: 2.5rem;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 0;
        }

        /* Enhanced Property Stats */
        .property-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
            margin-bottom: 4rem;
        }

        .stat-card {
            background: white;
            padding: 2.5rem 2rem;
            border-radius: 20px;
            text-align: center;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            opacity: 0;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--hover-shadow);
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .stat-card i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .stat-card:hover i {
            transform: scale(1.1);
        }

        .stat-card h3 {
            font-size: 3rem;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
            font-weight: 700;
            line-height: 1;
        }

        .stat-card p {
            color: var(--secondary-color);
            font-size: 1.2rem;
            margin: 0;
            font-weight: 500;
        }

        .add-property-btn {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
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

        .filter-section {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 2rem;
            margin-bottom: 3rem;
            position: relative;
            overflow: hidden;
        }

        .filter-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: var(--primary-color);
        }

        .filter-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
        }

        .filter-header i {
            font-size: 2rem;
            color: var(--primary-color);
        }

        .filter-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark-text);
            margin: 0;
        }

        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .form-group {
            margin-bottom: 0;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-label i {
            color: var(--primary-color);
        }

        .form-control, .form-select {
            border-radius: 12px;
            padding: 0.8rem 1.2rem;
            border: 2px solid #e0e0e0;
            transition: var(--transition);
            font-size: 0.95rem;
            background: var(--light-bg);
        }

        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.15);
            border-color: var(--primary-color);
            background: white;
        }

        .btn-search {
            background: var(--primary-color);
            color: var(--light-text);
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            width: 100%;
            margin-top: 1rem;
        }

        .btn-search:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-reset {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            min-width: 150px;
        }

        .btn-reset:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-reset i {
            font-size: 1.1rem;
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
            color: var(--dark-text);
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
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
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

        .page-header {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            padding: 2.5rem !important;
            margin-bottom: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            border: 1px solid rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(52, 152, 219, 0.05) 0%, rgba(44, 62, 80, 0.05) 100%);
            z-index: 0;
        }

        .page-header .row {
            position: relative;
            z-index: 1;
        }

        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            -webkit-background-clip: text;
            background-clip: text;
            -webkit-text-fill-color: transparent;
            letter-spacing: -0.5px;
        }

        .page-header p {
            font-size: 1.1rem;
            color: #6c757d;
            font-weight: 500;
            margin-bottom: 0;
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem !important;
            }
            
            .page-header h1 {
                font-size: 2rem;
            }
            
            .page-header p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />
    <div class="container" style="margin-top: 100px;">
        <%
        // Get properties from request/session
        List<Properties> p = (List<Properties>)request.getAttribute("Properties");
        if(p == null) {
            p = (List<Properties>)session.getAttribute("Properties");
        }
        List<Properties> mp = (List<Properties>)request.getAttribute("MyProperties");
        User u1 = (User)session.getAttribute("user");
        %>
        <div class="page-header bg-light p-4 rounded shadow-sm">
            <div class="row align-items-center">
                <div class="col-12">
                    <h1 class="mb-2 text-primary">Properties</h1>
                    <p class="text-muted mb-0">Track all property listings in one place</p>
                </div>
            </div>
        </div>

        <!-- Dashboard Stats -->
        <div class="property-stats">
            <div class="stat-card">
                <i class="fas fa-home"></i>
                <h3><%= p != null ? p.size() : 0 %></h3>
                <p>Total Properties</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-home"></i>
                <h3><%= mp != null ? mp.size() : 0 %></h3>
                <p>My Properties</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-filter"></i>
                <h3><%= p != null ? p.size() : 0 %></h3>
                <p>Filtered Properties</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-calendar-check"></i>
                <h3> 0</h3>
                <p>Appointments Today</p>
            </div>
        </div>

        <!-- Search and Filters -->
        <div class="filter-section mb-4">
            <div class="filter-header">
                <i class="fas fa-filter"></i>
                <h2 class="filter-title">Search Properties</h2>
            </div>
            <form id="propertyFilter" action="${pageContext.request.contextPath}/agent/properties/filter" method="POST">
                <div class="filter-grid">
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-tag"></i> Price Range</label>
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
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-home"></i> Property Type</label>
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
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-info-circle"></i> Status</label>
                        <select class="form-select" name="status">
                            <option value="">All Status</option>
                            <option value="AVAILABLE">Available</option>
                            <option value="RENT">Rent</option>
                            <option value="PRE_LAUNCH">Pre-launch</option>
                            <option value="SOLD">Sold</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-city"></i> City</label>
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
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-map-marker-alt"></i> Address</label>
                        <input type="text" class="form-control" placeholder="Enter address" name="address">
                    </div>
                    <div class="form-group">
                        <label class="form-label"><i class="fas fa-ruler-combined"></i> Area</label>
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
                </div>
                <div class="d-flex gap-3">
                    <button type="submit" class="btn btn-search flex-grow-1">
                        <i class="fas fa-search"></i> Search Properties
                    </button>
                    <button type="button" class="btn btn-reset" id="resetFilters">
                        <i class="fas fa-undo"></i> Reset Filters
                    </button>
                </div>
            </form>
        </div>

        <!-- Property List -->
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Property Listings</h5>
                        <div class="header-actions">
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPropertyModal">
                                <i class="fas fa-plus me-2"></i>Add New Property
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Property Type</th>
                                        <th>Price</th>
                                        <th>Status</th>
                                        <th>Location</th>
                                        <th>Area</th>
                                        <th>Agent</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if(p != null && !p.isEmpty()) { %>
                                        <% for(Properties p1:p){%>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <i class="fas fa-home me-2 text-primary"></i>
                                                        <%= p1.getPropertyType() %>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="fw-bold">₹ <%= p1.getPrice() %></div>
                                                </td>
                                                <td>
                                                    <span class="property-status status-<%= p1.getStatus().toString().toLowerCase() %>">
                                                        <%= p1.getStatus() %>
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="location-info">
                                                        <div class="text-truncate" style="max-width: 200px;">
                                                            <i class="fas fa-map-marker-alt me-1 text-danger"></i>
                                                            <%= p1.getAddress() %>
                                                        </div>
                                                        <small class="text-muted">
                                                            <%= p1.getCity() %>, <%= p1.getState() %>
                                                        </small>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="area-info">
                                                        <span class="fw-bold"><%= p1.getArea()%></span>
                                                        <small class="text-muted"><%=p1.getAreaUnit()%></small>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="agent-info">
                                                        <i class="fas fa-user-tie me-1 text-primary"></i>
                                                        <%= p1.getUser_id().getEmail() %>
                                                    </div>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/user/property-details/<%= p1.getId() %>" 
                                                       class="btn btn-outline-primary btn-sm">
                                                        <i class="fas fa-eye me-1"></i>View Details
                                                    </a>
                                                </td>
                                            </tr>
                                        <% } %>
                                    <% } else { %>
                                        <tr>
                                            <td colspan="7" class="text-center py-4">
                                                <div class="no-properties">
                                                    <i class="fas fa-home"></i>
                                                    <h3>No Properties Found</h3>
                                                    <p>There are no properties available matching your criteria.</p>
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
                                <input type="text" class="form-control" placeholder="Enter City" name="city" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">State</label>
                                <select class="form-select" name="state" required>
                                    <option value="">Select State</option>
                                    <option value="Madhya Pradesh">Madhya Pradesh</option>
                                    <option value="Maharashtra">Maharashtra</option>
                                    <option value="Gujarat">Gujarat</option>
                                    <option value="Rajasthan">Rajasthan</option>
                                    <option value="Uttar Pradesh">Uttar Pradesh</option>
                                    <option value="Delhi">Delhi</option>
                                    <option value="Haryana">Haryana</option>
                                    <option value="Punjab">Punjab</option>
                                    <option value="Himachal Pradesh">Himachal Pradesh</option>
                                    <option value="Uttarakhand">Uttarakhand</option>
                                    <option value="Bihar">Bihar</option>
                                    <option value="Jharkhand">Jharkhand</option>
                                    <option value="West Bengal">West Bengal</option>
                                    <option value="Odisha">Odisha</option>
                                    <option value="Chhattisgarh">Chhattisgarh</option>
                                    <option value="Telangana">Telangana</option>
                                    <option value="Andhra Pradesh">Andhra Pradesh</option>
                                    <option value="Karnataka">Karnataka</option>
                                    <option value="Tamil Nadu">Tamil Nadu</option>
                                    <option value="Kerala">Kerala</option>
                                    <option value="Goa">Goa</option>
                                </select>
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        // Function to load all properties
        function loadAllProperties() {
            // Show loading state
            $('.table tbody').html('<tr><td colspan="7" class="text-center"><i class="fas fa-spinner fa-spin"></i> Loading properties...</td></tr>');
            
            $.ajax({
                url: '${pageContext.request.contextPath}/agent/manage-properties',
                type: 'GET',
                success: function(response) {
                    var tempDiv = $('<div>').html(response);
                    var newTableContent = tempDiv.find('tbody').html();
                    if (newTableContent) {
                        $('.table tbody').html(newTableContent);
                        // Update stats
                        var propertyCount = tempDiv.find('.stat-card h3').first().text();
                        $('.stat-card h3').first().text(propertyCount);
                        $('.stat-card h3').eq(2).text(propertyCount);
                    } else {
                        $('.table tbody').html('<tr><td colspan="7" class="text-center">No properties found</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    $('.table tbody').html('<tr><td colspan="7" class="text-center text-danger">Error loading properties. Please try again.</td></tr>');
                }
            });
        }

        // Load all properties when page loads
        loadAllProperties();

        // Handle search form submission
        $('#propertyFilter').on('submit', function(e) {
            e.preventDefault();
            
            // Show loading state
            $('.btn-search').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Searching...');
            $('.table tbody').html('<tr><td colspan="7" class="text-center"><i class="fas fa-spinner fa-spin"></i> Searching properties...</td></tr>');
            
            // Get form data
            var formData = $(this).serialize();
            
            // Make AJAX call
            $.ajax({
                url: '${pageContext.request.contextPath}/agent/properties/filter',
                type: 'POST',
                data: formData,
                success: function(response) {
                    var tempDiv = $('<div>').html(response);
                    var newTableContent = tempDiv.find('tbody').html();
                    if (newTableContent) {
                        $('.table tbody').html(newTableContent);
                        // Update filtered properties count
                        var filteredCount = tempDiv.find('.stat-card h3').first().text();
                        $('.stat-card h3').eq(2).text(filteredCount);
                    } else {
                        $('.table tbody').html('<tr><td colspan="7" class="text-center">No properties found matching your criteria</td></tr>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error:', error);
                    $('.table tbody').html('<tr><td colspan="7" class="text-center text-danger">Error searching properties. Please try again.</td></tr>');
                },
                complete: function() {
                    $('.btn-search').prop('disabled', false).html('<i class="fas fa-search"></i> Search Properties');
                }
            });
        });

        // Handle reset filters button
        $('#resetFilters').on('click', function() {
            // Show loading state
            $(this).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Resetting...');
            
            // Reset all form fields
            $('#propertyFilter')[0].reset();
            
            // Load all properties
            loadAllProperties();
            
            // Reset button state
            $(this).prop('disabled', false).html('<i class="fas fa-undo"></i> Reset Filters');
        });
    });
    </script>
</body>
</html> 