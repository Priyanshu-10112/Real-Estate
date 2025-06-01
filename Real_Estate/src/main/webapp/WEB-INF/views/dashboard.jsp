<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User,java.util.List,com.example.Real_Estate.entity.Properties" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #34495e;
            --accent-color: #3498db;
            --light-gray: #f8f9fa;
            --dark-gray: #343a40;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --danger-color: #e74c3c;
        }

        body {
            background-color: var(--light-gray);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%) !important;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }

        .dashboard-container {
            margin-top: 80px;
            padding: 20px 0;
        }

        .dashboard-header {
            background: none !important;
        }

        .dashboard-stats {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }

        .dashboard-stats:hover {
            transform: translateY(-5px);
        }

        .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: var(--accent-color);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: var(--primary-color);
        }

        .stat-label {
            color: var(--secondary-color);
            font-size: 1.1rem;
        }

        .property-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 24px rgba(44,62,80,0.10);
            transition: box-shadow 0.3s, transform 0.3s;
            display: flex;
            flex-direction: column;
            margin-bottom: 2rem;
        }
        .property-card:hover {
            box-shadow: 0 8px 32px rgba(44,62,80,0.18);
            transform: translateY(-4px) scale(1.01);
        }
        .property-image {
            position: relative;
            height: 220px;
            background: #f3f3f3;
        }
        .property-fav {
            position: absolute;
            top: 1.2rem;
            right: 1.2rem;
            z-index: 2;
            font-size: 1.7rem;
            color: #e0e0e0;
            cursor: pointer;
            transition: color 0.2s;
        }
        .property-fav.favorited {
            color: #e74c3c;
        }
        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }
        .property-overlay {
            position: absolute;
            top: 0; left: 0; right: 0; height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            pointer-events: none;
        }
        .property-overlay-top {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            padding: 1.2rem 1.2rem 0 1.2rem;
        }
        .property-price {
            background: rgba(255,255,255,0.92);
            color: var(--primary-color);
            font-size: 1.5rem;
            font-weight: 700;
            border-radius: 12px;
            padding: 0.4rem 1.2rem;
            box-shadow: 0 2px 8px rgba(44,62,80,0.08);
        }
        .property-status {
            background: rgba(255,255,255,0.92);
            color: #888;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 20px;
            padding: 0.3rem 1.2rem;
            box-shadow: 0 2px 8px rgba(44,62,80,0.08);
        }
        .property-info {
            padding: 2rem 2rem 1.2rem 2rem;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.7rem;
        }
        .property-info h3 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 0 0 0.5rem 0;
        }
        .property-info p {
            color: var(--secondary-color);
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 1.1rem;
        }
        .property-features {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin: 1rem 0 0.5rem 0;
        }
        .feature {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            color: var(--secondary-color);
            font-size: 1.1rem;
            background: #f3f6fa;
            border-radius: 6px;
            padding: 0.2rem 0.7rem;
        }
        .feature i {
            color: var(--accent-color);
            font-size: 1.2rem;
        }
        .property-actions {
            display: flex;
            gap: 1.2rem;
            margin-top: 1.2rem;
        }
        .property-actions .btn {
            flex: 1;
            border-radius: 2rem;
            font-size: 1.15rem;
            font-weight: 500;
            padding: 0.9rem 0;
            transition: background 0.2s, color 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 8px rgba(44,62,80,0.06);
        }
        .property-actions .btn-primary {
            background: var(--primary-color);
            color: #fff;
            border: none;
        }
        .property-actions .btn-primary:hover {
            background: var(--accent-color);
        }
        .property-actions .btn-outline {
            background: #fff;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }
        .property-actions .btn-outline:hover {
            background: var(--primary-color);
            color: #fff;
        }
        @media (max-width: 768px) {
            .property-info {
                padding: 1.2rem 1rem 1rem 1rem;
            }
            .property-card {
                border-radius: 14px;
            }
            .property-image {
                height: 160px;
            }
            .property-info h3 {
                font-size: 1.3rem;
            }
            .property-actions {
                flex-direction: column;
                gap: 0.7rem;
            }
        }
        .loading {
            position: relative;
            min-height: 200px;
        }

        .loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 40px;
            height: 40px;
            margin: -20px 0 0 -20px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .filter-left {
            margin-left: 0 !important;
            margin-right: auto !important;
            width: auto !important;
        }

        .filter-card-left {
            margin-left: 0 !important;
            margin-right: auto !important;
            width: auto !important;
            max-width: none !important;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/user/dashboard">
                <i class="fas fa-home"></i>
                <span>My Dashboard</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/user/dashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/favorites">
                            <i class="fas fa-heart"></i>
                            <span>Favorites</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/appointments">
                            <i class="fas fa-calendar-check"></i>
                            <span>Appointments</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/user/messages">
                            <i class="fas fa-envelope"></i>
                            <span>Messages</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/profile">
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
            <h1 class="section-title">Welcome Back, <span>${user.firstName}</span></h1>
            
            <%
            // Property type display map
            java.util.Map<String, String> propertyTypeDisplay = new java.util.HashMap<>();
            propertyTypeDisplay.put("APARTMENT_FLAT", "Apartment / Flat");
            propertyTypeDisplay.put("INDEPENDENT_HOUSE_VILLA", "Independent House / Villa");
            propertyTypeDisplay.put("BUILDER_FLOOR_APARTMENT", "Builder Floor Apartment");
            propertyTypeDisplay.put("STUDIO_APARTMENT", "Studio Apartment");
            propertyTypeDisplay.put("PENTHOUSE", "Penthouse");
            propertyTypeDisplay.put("ROW_HOUSE_TOWNHOUSE", "Row House / Townhouse");
            propertyTypeDisplay.put("RESIDENTIAL_PLOT_LAND", "Residential Plot / Land");
            propertyTypeDisplay.put("COMMERCIAL_OFFICE_SPACE", "Commercial Office Space");
            propertyTypeDisplay.put("SHOP_SHOWROOM", "Shop / Showroom");
            propertyTypeDisplay.put("WAREHOUSE_GODOWN", "Warehouse / Godown");
            propertyTypeDisplay.put("INDUSTRIAL_LAND_FACTORY", "Industrial Land / Factory");
            propertyTypeDisplay.put("AGRICULTURAL_LAND_FARMLAND", "Agricultural Land / Farmland");
            propertyTypeDisplay.put("MIXED_USE_PROPERTY", "Mixed-Use Property");
            propertyTypeDisplay.put("CO_WORKING_SPACE", "Co-working Space");
            propertyTypeDisplay.put("VACANT_LAND_NON_AGRICULTURAL", "Vacant Land (Non-agricultural)");
            %>

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

            <div class="property-cards-section">
                <div class="property-grid" th:fragment="property-grid">
                    <% List<Properties> properties = (List<Properties>)request.getAttribute("Properties"); %>
                    <% if(properties != null && !properties.isEmpty()) { %>
                        <% for(Properties p1 : properties) { %>
                            <div class="property-card">
                                <div class="property-image">
                                    <span class="property-fav" onclick="this.classList.toggle('favorited')">
                                        <i class="fa-regular fa-heart"></i>
                                    </span>
                                    <img src="https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3" alt="<%= p1.getPropertyType() %>">
                                    <div class="property-overlay">
                                        <div class="property-overlay-top">
                                            <span class="property-price">₹<%= p1.getPrice() %></span>
                                            <span class="property-status status-<%= p1.getStatus().toString().toLowerCase() %>">
                                                <%= p1.getStatus() %>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="property-info">
                                    <h3><%= propertyTypeDisplay.getOrDefault(p1.getPropertyType().toString(), p1.getPropertyType().toString()) %></h3>
                                    <p>
                                        <i class="fas fa-map-marker-alt"></i>
                                        <%= p1.getAddress() %>, <%= p1.getCity() %>
                                    </p>
                                    <div class="property-features">
                                        <% if (p1.getArea() != null && p1.getArea() > 0) { %>
                                            <span class="feature">
                                                <i class="fas fa-ruler-combined"></i>
                                                <%= p1.getArea() %> <%= p1.getAreaUnit() %>
                                            </span>
                                        <% } %>
                                    </div>
                                    <div class="property-actions">
                                        <button class="btn btn-primary"  onclick="ajaxRedirectOnHover(<%= p1.getId() %>)">View Details</button>
                                        <button class="btn btn-outline">Contact Agent</button>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    <% } else { %>
                        <div class="no-properties">
                            <i class="fas fa-home fa-3x"></i>
                            <h3>No Properties Found</h3>
                            <p>There are no properties available matching your criteria.</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script>
$(document).ready(function() {
        // Handle page refresh
    $(window).on('beforeunload', function() {
        // Clear any filter results from session
        $.ajax({
            url: '${pageContext.request.contextPath}/user/dashboard',
            type: 'GET',
            async: false
        });
    });

    // Handle property details click
    window.ajaxRedirectOnHover = function(propertyId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/user/property',
            method: 'GET',
            success: function(response) {
                if (response.trim() === 'go') {
                    window.location.href = '${pageContext.request.contextPath}/user/property-details/' + propertyId;
                }
            },
            error: function(xhr, status, error) {
                alert("Something went wrong with the AJAX call.");
            }
        });
    };
});
</script>

</body>
</html> 