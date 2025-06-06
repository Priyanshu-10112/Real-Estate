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
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
            --light-text: #ffffff;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
        }

        .page-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
        }

        .property-card {
            background: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            margin-bottom: 1.5rem;
            overflow: hidden;
        }

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .property-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .property-status {
            position: absolute;
            top: 1rem;
            right: 1rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 500;
            color: white;
        }

        .status-available {
            background-color: #2ecc71;
        }

        .status-sold {
            background-color: #e74c3c;
        }

        .status-rent {
            background-color: #3498db;
        }

        .property-details {
            padding: 1.5rem;
        }

        .property-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        .property-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .property-features {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--dark-text);
            font-size: 0.9rem;
        }

        .feature i {
            color: var(--primary-color);
        }

        .property-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-action {
            flex: 1;
            padding: 0.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-edit {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-delete {
            background-color: var(--accent-color);
            color: white;
        }

        .btn-view {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }

        .add-property-btn {
            background: var(--primary-color);
            color: white;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .add-property-btn:hover {
            background: var(--secondary-color);
            color: white;
            transform: translateY(-2px);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--dark-text);
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: #666;
            margin-bottom: 1.5rem;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <div class="container">
        <div class="page-header">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="mb-0">My Properties</h1>
                    <p class="mb-0 mt-2">Manage your property listings</p>
                </div>
                <div class="col-md-6 text-end">
                    <button class="btn add-property-btn" data-bs-toggle="modal" data-bs-target="#addPropertyModal">
                        <i class="fas fa-plus"></i>
                        Add New Property
                    </button>
                </div>
            </div>
        </div>

        <%
        List<Properties> properties = (List<Properties>) request.getAttribute("AllProperties");
        if (properties != null && !properties.isEmpty()) {
        %>
        <div class="row">
            <% for (Properties property : properties) { %>
                <div class="col-md-6 col-lg-4">
                    <div class="property-card">
                        <div class="property-image" style="background-image: url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1073&q=80');">
                            <span class="property-status status-<%= property.getStatus().name().toLowerCase() %>">
                                <%= property.getStatus() %>
                            </span>
                        </div>
                        <div class="property-details">
                            <h3 class="property-title"><%= property.getPropertyType() %></h3>
                            <div class="property-price">
                                <% 
                                    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
                                    formatter.setMaximumFractionDigits(0);
                                    String formattedPrice = formatter.format(property.getPrice());
                                %>
                                <%= formattedPrice %>
                            </div>
                            <div class="property-features">
                                <div class="feature">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <%= property.getCity() %>
                                </div>
                                <div class="feature">
                                    <i class="fas fa-ruler-combined"></i>
                                    <%= property.getArea() %> <%= property.getAreaUnit() %>
                                </div>
                                <div class="feature">
                                    <i class="fas fa-tag"></i>
                                    <%= property.getStatus() %>
                                </div>
                            </div>
                            <div class="property-actions">
                                <a href="${pageContext.request.contextPath}/agent/property/<%= property.getId() %>" class="btn-action btn-view">
                                    <i class="fas fa-eye"></i>
                                    View
                                </a>
                                <a href="${pageContext.request.contextPath}/agent/property/edit/<%= property.getId() %>" class="btn-action btn-edit">
                                    <i class="fas fa-edit"></i>
                                    Edit
                                </a>
                                <button class="btn-action btn-delete" onclick="deleteProperty('${property.id}')">
                                    <i class="fas fa-trash"></i>
                                    Delete
                                </button>
                            </div>
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
                <button class="btn add-property-btn" data-bs-toggle="modal" data-bs-target="#addPropertyModal">
                    <i class="fas fa-plus"></i>
                    Add New Property
                </button>
            </div>
        <% } %>
    </div>

    <!-- Add Property Modal -->
    <div class="modal fade" id="addPropertyModal" tabindex="-1" aria-labelledby="addPropertyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addPropertyModalLabel">Add New Property</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/agent/property/add" method="POST" enctype="multipart/form-data">
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
                            <label for="image" class="form-label">Property Image</label>
                            <input type="file" class="form-control" id="image" name="image" accept="image/*" required>
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
                window.location.href = '${pageContext.request.contextPath}/agent/property/delete/' + propertyId;
            }
        }
    </script>
</body>
</html> 