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
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
        }

        /* Navigation Styles */
        .navbar {
            background: white !important;
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
            color: var(--primary-color) !important;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }

        .navbar-brand i {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

        .nav-link {
            color: var(--dark-text) !important;
            font-weight: 500;
            padding: 0.8rem 1.2rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
            margin: 0 0.2rem;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: width 0.3s ease;
        }

        .nav-link:hover {
            background: var(--light-bg);
            transform: translateY(-2px);
            color: var(--primary-color) !important;
        }

        .nav-link:hover::before {
            width: 80%;
        }

        .nav-link.active {
            background: var(--light-bg);
            font-weight: 600;
            color: var(--primary-color) !important;
        }

        .nav-link.active::before {
            width: 80%;
        }

        .nav-link i {
            font-size: 1.1rem;
            transition: transform 0.3s ease;
            color: var(--primary-color);
        }

        .nav-link:hover i {
            transform: scale(1.1);
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
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%2852, 152, 219, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: white;
                padding: 1rem;
                border-radius: 10px;
                margin-top: 1rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .nav-link {
                padding: 0.8rem 1rem !important;
                margin: 0.2rem 0;
            }

            .nav-link::before {
                display: none;
            }
        }

        .dashboard-container {
            margin-top: 80px;
            padding: 20px 0;
        }

        .section-title {
            color: var(--dark-text);
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
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #7f8c8d;
            font-size: 1.1rem;
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
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.15);
            border-color: var(--primary-color);
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

        .form-label {
            font-weight: 500;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        .input-group-text {
            background: var(--light-bg);
            border: 1px solid #e0e0e0;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <div class="dashboard-container">
        <div class="container">
            <div class="row align-items-center mb-4">
                <div class="col-md-6">
                    <h1 class="section-title mb-0">All Properties</h1>
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
                                            <th>State</th>
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
                                                <td><%= p1.getState() %></td>
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
</body>
</html> 