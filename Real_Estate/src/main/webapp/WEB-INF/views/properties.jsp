<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User,java.util.List,com.example.Real_Estate.entity.Properties, java.text.NumberFormat, java.util.Locale" %>
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

        /* Enhanced Hero Section */
        .hero-section {
            background: linear-gradient(135deg, rgba(52, 152, 219, 0.95), rgba(41, 128, 185, 0.95)), 
                        url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            padding: 6rem 0;
            margin-bottom: 4rem;
            color: white;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg width="20" height="20" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><rect width="1" height="1" fill="rgba(255,255,255,0.1)"/></svg>');
            opacity: 0.1;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 900px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            font-family: 'Poppins', sans-serif;
            line-height: 1.2;
            background: linear-gradient(to right, #ffffff, #e0e0e0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: fadeInUp 1s ease-out;
        }

        .hero-subtitle {
            font-size: 1.4rem;
            opacity: 0.95;
            max-width: 700px;
            margin: 0 auto 2rem;
            line-height: 1.6;
            font-family: 'Inter', sans-serif;
            animation: fadeInUp 1s ease-out 0.2s;
            animation-fill-mode: both;
        }

        .hero-features {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 3rem;
            animation: fadeInUp 1s ease-out 0.4s;
            animation-fill-mode: both;
        }

        .hero-feature {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 1rem 1.5rem;
            border-radius: 50px;
            backdrop-filter: blur(5px);
            transition: var(--transition);
        }

        .hero-feature:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-3px);
        }

        .hero-feature i {
            font-size: 1.5rem;
            color: #fff;
        }

        .hero-feature span {
            font-size: 1.1rem;
            font-weight: 500;
            font-family: 'Inter', sans-serif;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .hero-section {
                padding: 4rem 0;
            }

            .hero-title {
                font-size: 2.5rem;
            }

            .hero-subtitle {
                font-size: 1.2rem;
            }

            .hero-features {
                flex-direction: column;
                gap: 1rem;
            }

            .hero-feature {
                width: 100%;
                justify-content: center;
            }
        }

        /* New Filter Section Design */
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

        /* New Property Cards Layout */
        .property-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 2rem;
            padding: 1rem;
        }

        /* Enhanced Property Card Styles */
        .property-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            position: relative;
            display: flex;
            flex-direction: column;
            border: 1px solid rgba(0,0,0,0.1);
            height: 100%; /* Ensure cards in a grid have equal height */
        }

        .property-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--hover-shadow);
        }

        .property-image {
            position: relative;
            height: 280px;
            overflow: hidden;
            flex-shrink: 0; /* Prevent image from shrinking */
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
            top: 1rem;
            left: 1rem;
            background: var(--primary-color);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            z-index: 2;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .property-badge.available { background: #2ecc71; }
        .property-badge.rent { background: #f1c40f; }
        .property-badge.sold { background: #e74c3c; }
        .property-badge.pre-launch { background: #9b59b6; }

        .property-info {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            min-height: 0;
            margin-top: 0;
        }

        .property-price {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
            display: block;
            background: var(--light-bg);
            padding: 0.8rem 1.2rem;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            word-break: break-all;
            overflow: hidden;
            width: 100%;
            box-sizing: border-box;
            position: relative;
            z-index: 1;
        }

        .property-price .amount {
            display: block;
        }

        .property-price::before {
            content: none;
        }

        .property-price::after {
            content: '';
            font-size: 1rem;
            font-weight: 300;
            color: var(--secondary-color);
            opacity: 0.7;
            margin-left: 0.5rem;
        }

        .property-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 0.8rem; /* Reduced margin */
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
            gap: 0.8rem;
            color: var(--secondary-color);
            font-size: 1.1rem;
            margin-bottom: 1rem; /* Reduced margin */
            padding-bottom: 1rem; /* Reduced padding */
            border-bottom: 1px solid rgba(0,0,0,0.1);
            font-family: 'Inter', sans-serif;
            word-break: break-word;
        }

        .property-location i {
            color: var(--primary-color);
            font-size: 1.3rem;
        }

        .property-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin: 1rem 0; /* Reduced vertical margin */
        }

        .feature {
            background: var(--light-bg);
            padding: 1.2rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 1rem;
            font-size: 1.1rem;
            color: var(--dark-text);
            transition: var(--transition);
            font-family: 'Inter', sans-serif;
        }

        .feature:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .feature i {
            color: var(--primary-color);
            font-size: 1.3rem;
            transition: var(--transition);
        }

        .feature:hover i {
            color: white;
        }

        .property-actions {
            display: flex;
            justify-content: center;
            margin-top: auto; /* This pushes the actions to the bottom */
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.1);
            flex-shrink: 0;
        }

        .property-actions .btn {
            padding: 1.2rem 2rem;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 1rem;
            width: 100%;
            max-width: 300px;
        }

        .property-actions .btn-primary {
            background: var(--primary-color);
            color: white;
            border: none;
        }

        .property-actions .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }

        .property-actions .btn-primary i {
            font-size: 1.2rem;
        }

        .property-meta {
            position: absolute;
            top: 1rem;
            right: 1rem;
            display: flex;
            gap: 0.5rem;
        }

        .meta-item {
            background: rgba(255,255,255,0.9);
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--dark-text);
            display: flex;
            align-items: center;
            gap: 0.3rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .meta-item i {
            color: var(--primary-color);
        }

        .no-properties {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
        }

        .no-properties i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .no-properties h3 {
            color: var(--dark-text);
            font-size: 1.8rem;
            margin-bottom: 1rem;
        }

        .no-properties p {
            color: var(--secondary-color);
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }
            
            .filter-grid {
                grid-template-columns: 1fr;
            }
            
            .property-grid {
                grid-template-columns: 1fr;
            }
            
            .property-info {
                padding: 1.5rem;
            }
            
            .property-image {
                height: 220px;
            }
            
            .property-title {
                font-size: 1.3rem;
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

        /* Add new content sections */
        .page-intro {
            text-align: center;
            max-width: 800px;
            margin: 0 auto 3rem;
            padding: 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
        }

        .page-intro h2 {
            font-size: 2.5rem;
            color: var(--dark-text);
            margin-bottom: 1rem;
            font-family: 'Poppins', sans-serif;
        }

        .page-intro p {
            font-size: 1.1rem;
            color: var(--secondary-color);
            line-height: 1.6;
            margin-bottom: 2rem;
            font-family: 'Inter', sans-serif;
        }

        .property-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .stat-card i {
            font-size: 2rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .stat-card h3 {
            font-size: 2rem;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
            font-family: 'Poppins', sans-serif;
        }

        .stat-card p {
            color: var(--secondary-color);
            font-size: 1rem;
            font-family: 'Inter', sans-serif;
        }

        @media (max-width: 768px) {
            .property-stats {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .page-intro h2 {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            .property-stats {
                grid-template-columns: 1fr;
            }
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

            <div class="property-grid">
                <% List<Properties> properties = (List<Properties>)session.getAttribute("Properties"); %>
                <% if(properties != null && !properties.isEmpty()) { %>
                    <% for(Properties p1 : properties) { %>
                        <div class="property-card">
                            <div class="property-image">
                                <span class="property-badge <%= p1.getStatus().toString().toLowerCase() %>">
                                    <%= p1.getStatus() %>
                                </span>
                                <img src="https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?ixlib=rb-4.0.3" alt="<%= p1.getPropertyType() %>">
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

    // Initialize event handlers on page load
    initializeEventHandlers();

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