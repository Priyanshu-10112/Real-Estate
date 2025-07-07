<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User,java.util.List,com.example.Real_Estate.entity.Properties, java.text.NumberFormat, java.util.Locale" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
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
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
            --light-text: #ffffff;
            --card-shadow: 0 10px 20px rgba(0,0,0,0.1);
            --hover-shadow: 0 15px 30px rgba(0,0,0,0.15);
            --transition: all 0.3s ease;
        }
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
        }
        .dashboard-container { margin-top: 80px; padding: 20px 0; }
        .section-title { font-size: 2rem; font-weight: 700; color: var(--primary-color); margin-bottom: 2rem; }
        .hero-section { background: linear-gradient(135deg, rgba(52, 152, 219, 0.95), rgba(41, 128, 185, 0.95)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover; padding: 6rem 0; margin-bottom: 4rem; color: white; text-align: center; position: relative; overflow: hidden; }
        .hero-content { position: relative; z-index: 1; max-width: 900px; margin: 0 auto; padding: 0 2rem; }
        .hero-title { font-size: 3.5rem; font-weight: 800; margin-bottom: 1.5rem; text-shadow: 2px 2px 4px rgba(0,0,0,0.2); font-family: 'Poppins', sans-serif; line-height: 1.2; background: linear-gradient(to right, #ffffff, #e0e0e0); -webkit-background-clip: text; background-clip: text; -webkit-text-fill-color: transparent; }
        .hero-subtitle { font-size: 1.4rem; opacity: 0.95; max-width: 700px; margin: 0 auto 2rem; line-height: 1.6; font-family: 'Inter', sans-serif; }
        .hero-features { display: flex; justify-content: center; gap: 2rem; margin-top: 3rem; }
        .hero-feature { display: flex; align-items: center; gap: 0.8rem; background: rgba(255, 255, 255, 0.1); padding: 1rem 1.5rem; border-radius: 50px; backdrop-filter: blur(5px); transition: var(--transition); }
        .hero-feature i { font-size: 1.5rem; color: #fff; }
        .hero-feature span { font-size: 1.1rem; font-weight: 500; font-family: 'Inter', sans-serif; }
        .page-intro { text-align: center; max-width: 800px; margin: 0 auto 3rem; padding: 2rem; background: white; border-radius: 20px; box-shadow: var(--card-shadow); }
        .page-intro h2 { font-size: 2.5rem; color: var(--dark-text); margin-bottom: 1rem; font-family: 'Poppins', sans-serif; }
        .page-intro p { font-size: 1.1rem; color: var(--secondary-color); line-height: 1.6; margin-bottom: 2rem; font-family: 'Inter', sans-serif; }
        .property-stats { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1.5rem; margin-bottom: 3rem; }
        .stat-card { background: white; padding: 1.5rem; border-radius: 15px; text-align: center; box-shadow: var(--card-shadow); transition: var(--transition); }
        .stat-card i { font-size: 2rem; color: var(--primary-color); margin-bottom: 1rem; }
        .stat-card h3 { font-size: 2rem; color: var(--dark-text); margin-bottom: 0.5rem; font-family: 'Poppins', sans-serif; }
        .stat-card p { color: var(--secondary-color); font-size: 1rem; font-family: 'Inter', sans-serif; }
        .filter-section { background: white; border-radius: 20px; box-shadow: var(--card-shadow); padding: 2rem; margin-bottom: 3rem; position: relative; overflow: hidden; }
        .filter-header { display: flex; align-items: center; margin-bottom: 2rem; gap: 1rem; }
        .filter-title { font-size: 1.5rem; font-weight: 600; color: var(--dark-text); margin: 0; }
        .filter-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1.5rem; }
        .form-group { margin-bottom: 0; }
        .form-label { font-weight: 600; color: var(--dark-text); margin-bottom: 0.5rem; font-size: 0.95rem; display: flex; align-items: center; gap: 0.5rem; }
        .form-control, .form-select { border-radius: 12px; padding: 0.8rem 1.2rem; border: 2px solid #e0e0e0; transition: var(--transition); font-size: 0.95rem; background: var(--light-bg); }
        .btn-search { background: var(--primary-color); color: var(--light-text); border: none; padding: 1rem 2rem; border-radius: 12px; font-weight: 600; transition: var(--transition); display: flex; align-items: center; justify-content: center; gap: 0.5rem; width: 100%; margin-top: 1rem; }
        .btn-reset { background: #e74c3c; color: white; border: none; padding: 1rem 2rem; border-radius: 12px; font-weight: 600; transition: var(--transition); display: flex; align-items: center; justify-content: center; gap: 0.5rem; min-width: 150px; }
        .property-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap: 2rem; padding: 1rem; }
        .property-card { background: white; border-radius: 20px; overflow: hidden; box-shadow: var(--card-shadow); transition: var(--transition); position: relative; display: flex; flex-direction: column; border: 1px solid rgba(0,0,0,0.1); height: 100%; }
        .property-image { position: relative; height: 280px; overflow: hidden; flex-shrink: 0; }
        .property-badge { position: absolute; top: 1rem; left: 1rem; background: var(--primary-color); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.9rem; font-weight: 600; z-index: 2; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .property-info { padding: 1.5rem; display: flex; flex-direction: column; flex-grow: 1; min-height: 0; margin-top: 0; }
        .property-price { font-size: 2.2rem; font-weight: 700; color: var(--primary-color); margin-bottom: 1rem; display: block; background: var(--light-bg); padding: 0.8rem 1.2rem; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); word-break: break-all; overflow: hidden; width: 100%; box-sizing: border-box; position: relative; z-index: 1; }
        .rupee-symbol { font-size: 1.4rem; font-weight: 400; vertical-align: top; margin-right: 0.2rem; }
        .property-title { font-size: 1.6rem; font-weight: 700; color: var(--dark-text); margin-bottom: 0.8rem; line-height: 1.4; display: -webkit-box; -webkit-box-orient: vertical; overflow: hidden; font-family: 'Poppins', sans-serif; margin-top: 0; word-break: break-word; }
        .property-location { display: flex; align-items: center; gap: 0.8rem; color: var(--secondary-color); font-size: 1.1rem; margin-bottom: 1rem; padding-bottom: 1rem; border-bottom: 1px solid rgba(0,0,0,0.1); font-family: 'Inter', sans-serif; word-break: break-word; }
        .property-features { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem; margin: 1rem 0; }
        .feature { background: var(--light-bg); padding: 1.2rem; border-radius: 12px; display: flex; align-items: center; gap: 1rem; font-size: 1.1rem; color: var(--dark-text); transition: var(--transition); font-family: 'Inter', sans-serif; }
        .property-actions { display: flex; justify-content: center; margin-top: auto; padding-top: 1.5rem; border-top: 1px solid rgba(0,0,0,0.1); flex-shrink: 0; }
        .property-meta { position: absolute; top: 1rem; right: 1rem; display: flex; gap: 0.5rem; }
        .meta-item { background: rgba(255,255,255,0.9); padding: 0.4rem 0.8rem; border-radius: 20px; font-size: 0.9rem; font-weight: 600; color: var(--dark-text); display: flex; align-items: center; gap: 0.3rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .no-properties { text-align: center; padding: 4rem 2rem; background: white; border-radius: 20px; box-shadow: var(--card-shadow); }
        .d-flex { display: flex !important; }
        .gap-3 { gap: 1rem !important; }
        .flex-grow-1 { flex-grow: 1 !important; }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />

    <div class="dashboard-container">
        <div class="container">
            <h1 class="section-title">Properties</h1>
            
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

            <div class="hero-section">
                <div class="hero-content">
                    <h1 class="hero-title">Find Your Dream Property</h1>
                    <p class="hero-subtitle">Discover the perfect home from our extensive collection of properties. Whether you're looking for a cozy apartment, a spacious villa, or a commercial space, we have the perfect property waiting for you.</p>
                    <div class="hero-features">
                        <div class="hero-feature">
                            <i class="fas fa-home"></i>
                            <span>500+ Properties</span>
                        </div>
                        <div class="hero-feature">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>20+ Locations</span>
                        </div>
                        <div class="hero-feature">
                            <i class="fas fa-star"></i>
                            <span>4.8/5 Rating</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="page-intro">
                <h2>Discover Your Perfect Property</h2>
                <p>Browse through our extensive collection of properties, from luxurious apartments to spacious villas. Each property is carefully selected to meet your needs and preferences.</p>
            </div>

            <div class="container">
                <div class="property-stats">
                    <div class="stat-card">
                        <i class="fas fa-home"></i>
                        <h3>500+</h3>
                        <p>Properties Listed</p>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-users"></i>
                        <h3>1000+</h3>
                        <p>Happy Clients</p>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-map-marker-alt"></i>
                        <h3>20+</h3>
                        <p>Locations</p>
                    </div>
                    <div class="stat-card">
                        <i class="fas fa-star"></i>
                        <h3>4.8</h3>
                        <p>Average Rating</p>
                    </div>
                </div>
            </div>

            <div class="filter-section">
                <div class="filter-header">
                    <i class="fas fa-filter"></i>
                    <h2 class="filter-title">Search Properties</h2>
                </div>
                <form id="propertyFilter" action="${pageContext.request.contextPath}/user/properties/filter" method="POST">
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
                            <input type="text" class="form-control" placeholder="Enter City" name="city">
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

            <div class="property-grid">
                <% List<Properties> properties = (List<Properties>)session.getAttribute("Properties"); %>
                <% if(properties != null && !properties.isEmpty()) { %>
                    <% for(Properties p1 : properties) { %>
                        <div class="property-card">
                            <div class="property-image">
                                <span class="property-badge <%= p1.getStatus().toString().toLowerCase() %>">
                                    <%= p1.getStatus() %>
                                </span>
                                <img src="${pageContext.request.contextPath}/images/properties/<%= p1.getImage() %>" 
                                     alt="<%= p1.getPropertyType() %>"
                                     onerror="this.src='https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3'">
                            </div>
                            <div class="property-info">
                                <div class="property-price">
                                    <% 
                                        long priceValue = p1.getPrice();
                                        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
                                        formatter.setMaximumFractionDigits(0);
                                        String formattedPrice = formatter.format(priceValue);
                                    %>
                                    <span class="rupee-symbol">₹</span><%= formattedPrice.replace("₹", "").trim() %>
                                </div>
                                <h3 class="property-title"><%= propertyTypeDisplay.getOrDefault(p1.getPropertyType().toString(), p1.getPropertyType().toString()) %></h3>
                                <div class="property-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <%= p1.getAddress() %>, <%= p1.getCity() %>
                                </div>
                                <div class="property-features">
                                    <% if (p1.getArea() != null && p1.getArea() > 0) { %>
                                        <span class="feature">
                                            <i class="fas fa-ruler-combined"></i>
                                            <%= p1.getArea() %> <%= p1.getAreaUnit() %>
                                        </span>
                                    <% } %>
                                </div>
                                <div class="property-actions">
                                    <button class="btn btn-primary" data-property-id="<%= p1.getId() %>">
                                        <i class="fas fa-eye"></i> View Details
                                    </button>
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } else { %>
                    <div class="no-properties">
                        <i class="fas fa-home"></i>
                        <h3>No Properties Found</h3>
                        <p>There are no properties available matching your criteria.</p>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script>
$(document).ready(function() {
    // Function to load all properties
    function loadAllProperties() {
        // Show loading state
        $('.property-grid').html('<div class="text-center p-5"><i class="fas fa-spinner fa-spin fa-2x"></i><p class="mt-3">Loading properties...</p></div>');
        
        $.ajax({
            url: '${pageContext.request.contextPath}/user/properties',
            type: 'GET',
            success: function(response) {
                var tempDiv = $('<div>').html(response);
                var newContent = tempDiv.find('.property-grid').html();
                if (newContent) {
                    $('.property-grid').html(newContent);
                    // Reinitialize event handlers
                    initializeEventHandlers();
                } else {
                    $('.property-grid').html('<div class="no-properties"><i class="fas fa-home"></i><h3>No Properties Found</h3><p>There are no properties available at the moment.</p></div>');
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                $('.property-grid').html('<div class="no-properties"><i class="fas fa-exclamation-circle"></i><h3>Error Loading Properties</h3><p>Please try refreshing the page.</p></div>');
            }
        });
    }

    // Load all properties when page loads
    loadAllProperties();

    // Reset all button states on page load
    $('.property-actions .btn-primary').each(function() {
        $(this).prop('disabled', false).html('<i class="fas fa-eye"></i> View Details');
    });

    // Handle search form submission
    $('#propertyFilter').on('submit', function(e) {
        e.preventDefault();
        
        // Show loading state
        $('.btn-search').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Searching...');
        
        // Get form data
        var formData = $(this).serialize();
        
        // Make AJAX call
        $.ajax({
            url: '${pageContext.request.contextPath}/user/properties/filter',
            type: 'POST',
            data: formData,
            success: function(response) {
                // Update the property grid with new results
                $('.property-grid').html($(response).find('.property-grid').html());
                
                // Reinitialize any necessary event handlers
                initializeEventHandlers();
            },
            error: function(xhr, status, error) {
                alert('Error occurred while searching properties. Please try again.');
            },
            complete: function() {
                // Reset button state
                $('.btn-search').prop('disabled', false).html('<i class="fas fa-search"></i> Search Properties');
            }
        });
    });

    // Handle property details click
    function initializeEventHandlers() {
        $('.property-actions .btn-primary').off('click').on('click', function(e) {
            e.preventDefault();
            var propertyId = $(this).data('property-id');
            window.location.href = '${pageContext.request.contextPath}/user/property-details/' + propertyId;
        });
    }

    // Handle page refresh
    $(window).on('beforeunload', function() {
        // Clear any filter results from session
        $.ajax({
            url: '${pageContext.request.contextPath}/user/properties',
            type: 'GET',
            async: false
        });
    });

    // Handle reset filters button
    $('#resetFilters').on('click', function() {
        // Show loading state
        $(this).prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Resetting...');
        
        // Reset all form fields
        $('#propertyFilter')[0].reset();
        
        // Make AJAX call to get all properties
        $.ajax({
            url: '${pageContext.request.contextPath}/user/properties',
            type: 'GET',
            success: function(response) {
                // Update the property grid with all properties
                $('.property-grid').html($(response).find('.property-grid').html());
                
                // Reinitialize event handlers
                initializeEventHandlers();
            },
            error: function(xhr, status, error) {
                alert('Error occurred while resetting filters. Please try again.');
            },
            complete: function() {
                // Reset button state
                $('#resetFilters').prop('disabled', false).html('<i class="fas fa-undo"></i> Reset Filters');
            }
        });
    });
});
</script>

</body>
</html> 