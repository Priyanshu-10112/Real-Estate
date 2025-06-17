<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Real_Estate.entity.Properties" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Properties - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <%
    List<Properties> properties = (List<Properties>) request.getAttribute("AllProperties");
    %>
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
        /* Enhanced Page Header */
        .page-header {
            background: var(--gradient-primary), 
                        url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            color: white;
            padding: 3rem 0;
            margin-bottom: 3rem;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(5px);
            margin-top: 80px;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><rect width="1" height="1" fill="rgba(255,255,255,0.1)"/></svg>');
            opacity: 0.1;
        }

        .page-header h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            letter-spacing: -0.5px;
        }

        .page-header p {
            font-size: 1.3rem;
            opacity: 0.9;
            max-width: 600px;
            line-height: 1.6;
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

        /* Enhanced Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 2rem;
            margin-bottom: 4rem;
        }

        .action-card {
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

        .action-card::before {
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

        .action-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--hover-shadow);
        }

        .action-card:hover::before {
            opacity: 1;
        }

        .action-card i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .action-card:hover i {
            transform: scale(1.1);
        }

        .action-card h4 {
            font-size: 1.8rem;
            color: var(--dark-text);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .action-card p {
            color: var(--secondary-color);
            font-size: 1.1rem;
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        /* Enhanced Section Title */
        .section-title {
            text-align: center;
            margin-bottom: 4rem;
            position: relative;
            padding-bottom: 1.5rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: var(--gradient-primary);
            border-radius: 2px;
        }

        .section-title h2 {
            font-size: 3rem;
            color: var(--dark-text);
            margin-bottom: 1rem;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .section-title p {
            color: var(--secondary-color);
            font-size: 1.3rem;
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.6;
        }

        /* Enhanced Property Grid */
        .property-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 2.5rem;
            padding: 1rem;
        }

        /* Enhanced Property Card */
        .property-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            position: relative;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(0,0,0,0.05);
            height: 100%;
        }

        .property-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--hover-shadow);
        }

        .property-image {
            position: relative;
            height: 300px;
            overflow: hidden;
            flex-shrink: 0;
        }

        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: var(--transition);
        }

        .property-card:hover .property-image img {
            transform: scale(1.05);
        }

        .property-badge {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            background: rgba(255, 255, 255, 0.9);
            color: var(--dark-text);
            padding: 0.8rem 1.5rem;
            border-radius: 30px;
            font-size: 1rem;
            font-weight: 600;
            z-index: 2;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255,255,255,0.2);
        }

        .property-badge.available { color: #2ecc71; }
        .property-badge.rent { color: #f1c40f; }
        .property-badge.sold { color: #e74c3c; }
        .property-badge.pre-launch { color: #9b59b6; }

        .property-info {
            padding: 2rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            min-height: 0;
            margin-top: 0;
        }

        .property-price {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            display: block;
            background: var(--light-bg);
            padding: 1rem 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            word-break: break-all;
            overflow: hidden;
            width: 100%;
            box-sizing: border-box;
            position: relative;
            z-index: 1;
        }

        .property-price .rupee-symbol {
            font-size: 1.8rem;
            font-weight: 400;
            vertical-align: top;
            margin-right: 0.2rem;
        }

        .property-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 1rem;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            overflow: hidden;
            font-family: 'Poppins', sans-serif;
            margin-top: 0;
            word-break: break-word;
        }

        .property-location {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--secondary-color);
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            font-family: 'Inter', sans-serif;
            word-break: break-word;
        }

        .property-location i {
            color: var(--primary-color);
            font-size: 1.5rem;
        }

        .property-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1.5rem;
            margin: 1.5rem 0;
        }

        .feature {
            background: var(--light-bg);
            padding: 1.5rem;
            border-radius: 15px;
            display: flex;
            align-items: center;
            gap: 1.2rem;
            font-size: 1.2rem;
            color: var(--dark-text);
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .feature:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-5px);
        }

        .feature i {
            color: var(--primary-color);
            font-size: 1.5rem;
            transition: var(--transition);
        }

        .feature:hover i {
            color: white;
        }

        .property-actions {
            display: flex;
            flex-direction: column;
            gap: 1.2rem;
            margin-top: auto;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.1);
            flex-shrink: 0;
        }

        .property-actions .btn {
            padding: 1.2rem 2rem;
            border-radius: 15px;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 1.1rem;
            width: 100%;
            position: relative;
            overflow: hidden;
        }

        .property-actions .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(255,255,255,0.1), rgba(255,255,255,0));
            transform: translateX(-100%);
            transition: var(--transition);
        }

        .property-actions .btn:hover::before {
            transform: translateX(100%);
        }

        .property-actions .btn-primary {
            background: var(--gradient-primary);
            color: white;
            border: none;
        }

        .property-actions .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
        }

        .property-actions .btn-primary i {
            font-size: 1.3rem;
        }

        /* Enhanced Empty State */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            margin: 2rem 0;
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 2rem;
        }

        .empty-state h3 {
            color: var(--dark-text);
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
        }

        .empty-state p {
            color: var(--secondary-color);
            font-size: 1.3rem;
            max-width: 600px;
            margin: 0 auto 2rem;
            line-height: 1.6;
        }

        /* Enhanced Add Property Button */
        .add-property-btn {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 1.2rem 2.5rem;
            border-radius: 15px;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
        }

        .add-property-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(255,255,255,0.1), rgba(255,255,255,0));
            transform: translateX(-100%);
            transition: var(--transition);
        }

        .add-property-btn:hover::before {
            transform: translateX(100%);
        }

        .add-property-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.4);
            color: white;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .property-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 992px) {
            .quick-actions {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .page-header h1 {
                font-size: 3rem;
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 1.5rem;
            }

            .page-header {
                padding: 3rem 1.5rem;
                border-radius: 15px;
            }

            .page-header h1 {
                font-size: 2.5rem;
            }

            .property-stats,
            .quick-actions {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .stat-card,
            .action-card {
                padding: 2rem 1.5rem;
            }

            .stat-card h3 {
                font-size: 2.5rem;
            }

            .section-title h2 {
                font-size: 2.5rem;
            }

            .property-grid {
                grid-template-columns: 1fr;
            }

            .property-info {
                padding: 1.5rem;
            }

            .property-title {
                font-size: 1.6rem;
            }

            .property-features {
                grid-template-columns: 1fr;
            }

            .property-actions {
                grid-template-columns: 1fr;
            }

            .property-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <div class="container">
        <div class="page-header bg-light p-4 rounded shadow-sm">
            <div class="row align-items-center">
                <div class="col-12">
                    <h1 class="mb-2 text-primary">My Properties</h1>
                    <p class="text-muted mb-0">Manage and track all your property listings in one place</p>
                </div>
            </div>
        </div>

        <!-- Property Stats Section -->
        <div class="property-stats">
            <div class="stat-card">
                <i class="fas fa-home"></i>
                <h3><%= properties != null ? properties.size() : 0 %></h3>
                <p>Total Properties</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-check-circle"></i>
                <h3><%= properties != null ? properties.stream().filter(p -> p.getStatus().toString().equals("AVAILABLE")).count() : 0 %></h3>
                <p>Available</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-key"></i>
                <h3><%= properties != null ? properties.stream().filter(p -> p.getStatus().toString().equals("RENT")).count() : 0 %></h3>
                <p>For Rent</p>
            </div>
            <div class="stat-card">
                <i class="fas fa-tag"></i>
                <h3><%= properties != null ? properties.stream().filter(p -> p.getStatus().toString().equals("SOLD")).count() : 0 %></h3>
                <p>Sold</p>
            </div>
        </div>

        <!-- Quick Actions Section -->
        <div class="quick-actions">
            <div class="action-card">
                <i class="fas fa-chart-line"></i>
                <h4>Property Analytics</h4>
                <p>View detailed insights about your properties</p>
                <button class="btn btn-outline-primary">View Analytics</button>
            </div>
            <div class="action-card">
                <i class="fas fa-bell"></i>
                <h4>Property Alerts</h4>
                <p>Get notified about property inquiries</p>
                <button class="btn btn-outline-primary">View Alerts</button>
            </div>
            <div class="action-card">
                <i class="fas fa-file-alt"></i>
                <h4>Property Reports</h4>
                <p>Generate property performance reports</p>
                <button class="btn btn-outline-primary">View Reports</button>
            </div>
        </div>

        <!-- Properties Grid Section -->
        <div class="section-title">
            <h2>My Property Listings</h2>
            <p>Manage and monitor your property listings</p>
        </div>

        <%
        if (properties != null && !properties.isEmpty()) {
        %>
        <div class="property-grid">
            <% for (Properties property : properties) { %>
                <div class="property-card">
                    <div class="property-image">
                        <span class="property-badge <%= property.getStatus().toString().toLowerCase() %>">
                            <%= property.getStatus() %>
                        </span>
                        <img src="${pageContext.request.contextPath}/images/properties/<%= property.getImage() %>" 
                             alt="<%= property.getPropertyType() %>"
                             onerror="this.src='https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3'">
                    </div>
                    <div class="property-info">
                        <div class="property-price">
                            <% 
                                long priceValue = property.getPrice();
                                NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
                                formatter.setMaximumFractionDigits(0);
                                String formattedPrice = formatter.format(priceValue);
                            %>
                            <span class="rupee-symbol">₹</span><%= formattedPrice.replace("₹", "").trim() %>
                        </div>
                        <h3 class="property-title"><%= property.getPropertyType() %></h3>
                        <div class="property-location">
                            <i class="fas fa-map-marker-alt"></i>
                            <%= property.getAddress() %>, <%= property.getCity() %>
                        </div>
                        <div class="property-actions">
                            <a href="${pageContext.request.contextPath}/user/property-details/<%= property.getId() %>" class="btn btn-primary">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                            <a href="${pageContext.request.contextPath}/agent/properties/edit/<%= property.getId() %>" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <button class="btn btn-primary" onclick="deleteProperty('<%= property.getId() %>')">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
        <% } else { %>
            <div class="empty-state">
                <i class="fas fa-home"></i>
                <h3>No Properties Found</h3>
                <p>You haven't added any properties yet. Start by adding your first property listing.</p>
                <a href="${pageContext.request.contextPath}/agent/manage-properties?action=add" class="btn add-property-btn">
                    <i class="fas fa-plus"></i>
                    Add New Property
                </a>
            </div>
        <% } %>
    </div>

    <!-- Include Common Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- Add Property Modal -->
    <div class="modal fade" id="addPropertyModal" tabindex="-1" aria-labelledby="addPropertyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addPropertyModalLabel">Add New Property</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/agent/properties/add" method="POST" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="propertyType" class="form-label">Property Type</label>
                                <select class="form-select" id="propertyType" name="propertyType" required>
                                    <option value="">Select Property Type</option>
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
                            <div class="col-md-6 mb-3">
                                <label for="price" class="form-label">Price</label>
                                <input type="number" class="form-control" id="price" name="price" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="area" class="form-label">Area</label>
                                <input type="number" class="form-control" id="area" name="area" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="areaUnit" class="form-label">Area Unit</label>
                                <select class="form-select" id="areaUnit" name="areaUnit" required>
                                    <option value="">Select Unit</option>
                                    <option value="sq ft">Square Feet</option>
                                    <option value="sq m">Square Meters</option>
                                    <option value="acres">Acres</option>
                                    <option value="hectares">Hectares</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="city" class="form-label">City</label>
                                <input type="text" class="form-control" id="city" name="city" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="status" class="form-label">Status</label>
                                <select class="form-select" id="status" name="status" required>
                                    <option value="">Select Status</option>
                                    <option value="AVAILABLE">Available</option>
                                    <option value="SOLD">Sold</option>
                                    <option value="RENT">For Rent</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="description" class="form-label">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Property Image</label>
                            <input type="file" name="propertyImage" class="form-control" accept="image/*" required>
                            <small class="text-muted">Upload a clear image of your property (Max size: 5MB)</small>
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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteProperty(propertyId) {
            if (confirm('Are you sure you want to delete this property?')) {
                window.location.href = '${pageContext.request.contextPath}/agent/properties/delete/' + propertyId;
            }
        }

        // Check if we should open the add property modal
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('action') === 'add') {
                const addPropertyModal = new bootstrap.Modal(document.getElementById('addPropertyModal'));
                addPropertyModal.show();
            }
        });
    </script>
</body>
</html> 