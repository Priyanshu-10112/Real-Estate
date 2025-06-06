<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="com.example.Real_Estate.entity.Properties" %>
<%@ page import="com.example.Real_Estate.entity.UserRole" %>
<%@ page import="java.text.NumberFormat, java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
        crossorigin=""/>
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
            --gradient-accent: linear-gradient(135deg, #e74c3c, #c0392b);
            --section-spacing: 2rem;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
        }

        .property-header {
            background: var(--gradient-primary), 
                        url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            color: white;
            padding: 3rem 0;
            margin-bottom: var(--section-spacing);
            position: relative;
            overflow: hidden;
            box-shadow: var(--card-shadow);
        }

        .header-wrapper {
            position: relative;
            width: 100%;
            margin: 0 auto;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 2rem;
            margin-top: 1rem;
        }

        .header-left {
            flex: 1;
            min-width: 0;
        }

        .property-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            line-height: 1.2;
            word-wrap: break-word;
            overflow-wrap: break-word;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .header-right {
            flex-shrink: 0;
            display: flex;
            align-items: flex-start;
        }

        .property-price {
            font-size: 2rem;
            font-weight: 700;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            display: inline-flex;
            align-items: baseline;
            background: rgba(255,255,255,0.1);
            padding: 0.6rem 1.5rem;
            border-radius: 12px;
            backdrop-filter: blur(5px);
            transition: var(--transition);
            white-space: nowrap;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
            text-decoration: none;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            font-size: 0.95rem;
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            color: white;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        .back-button i {
            font-size: 1.2rem;
            transition: transform 0.3s ease;
        }

        .back-button:hover i {
            transform: translateX(-3px);
        }

        @media (max-width: 991.98px) {
            .header-content {
                flex-direction: column;
                gap: 1.5rem;
            }

            .header-right {
                width: 100%;
            }

            .property-price {
                width: 100%;
                justify-content: center;
            }

            .property-title {
                font-size: 2rem;
            }
        }

        @media (max-width: 768px) {
            .property-header {
                padding: 2rem 0;
            }

            .property-title {
                font-size: 1.8rem;
            }

            .property-price {
                font-size: 1.6rem;
                padding: 0.5rem 1.2rem;
            }
        }

        .property-badges {
            display: flex;
            gap: 1rem;
            z-index: 2;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .property-status, .property-type {
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            backdrop-filter: blur(5px);
            background: rgba(255,255,255,0.2);
            transition: var(--transition);
        }

        .property-status:hover, .property-type:hover {
            background: rgba(255,255,255,0.3);
            transform: translateY(-2px);
        }

        .container {
            max-width: 1140px;
            margin: 0 auto;
            padding: 0 1rem;
        }

        .row {
            margin: 0 -1rem;
        }

        .col-lg-8, .col-lg-4 {
            padding: 0 1rem;
        }

        .property-details-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 2.5rem;
            margin-bottom: var(--section-spacing);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .property-details-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--gradient-primary);
        }
        
        .detail-items-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }
        
        .detail-item {
            display: flex;
            align-items: flex-start;
            padding: 1.5rem;
            border-radius: 12px;
            background: var(--light-bg);
            transition: var(--transition);
            width: 100%;
            box-sizing: border-box;
        }
        
        .detail-item:hover {
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
        }
        
        .detail-icon {
            width: 60px;
            height: 60px;
            background: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1.5rem;
            color: var(--primary-color);
            font-size: 1.5rem;
            transition: var(--transition);
            box-shadow: var(--card-shadow);
            flex-shrink: 0;
        }
        
        .detail-item:hover .detail-icon {
            background: var(--gradient-primary);
            color: white;
            transform: scale(1.1) rotate(5deg);
        }
        
        .detail-content {
            flex: 1;
            min-width: 0;
            display: flex;
            flex-direction: column;
        }
        
        .detail-label {
            font-size: 1rem;
            color: var(--secondary-color);
            margin-bottom: 0.3rem;
            font-weight: 500;
        }
        
        .detail-value {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
            word-break: break-word;
            overflow-wrap: break-word;
            width: 100%;
        }
        
        .agent-section {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .agent-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            transition: var(--transition);
        }

        .agent-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .agent-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            overflow: hidden;
            border: 3px solid var(--light-bg);
            box-shadow: var(--card-shadow);
        }

        .agent-initial {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 2.5rem;
            font-weight: 700;
            background: var(--gradient-primary);
        }

        .agent-name {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 0.3rem;
        }

        .agent-role {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
            margin: 0;
        }

        .agent-contact {
            background: var(--light-bg);
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            margin-bottom: 0.8rem;
        }

        .contact-item:last-child {
            margin-bottom: 0;
        }

        .contact-item i {
            width: 35px;
            height: 35px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1rem;
        }

        .contact-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 0.8rem;
        }

        .contact-buttons .btn {
            flex: 1 1 auto;
            padding: 0.6rem;
            font-size: 0.9rem;
            text-align: center;
        }

        @media (max-width: 576px) {
            .contact-buttons .btn {
                flex: 1 1 100%;
            }
        }

        .property-highlights-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
        }

        .highlights-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .highlight-stat {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background: var(--light-bg);
            border-radius: 12px;
            transition: var(--transition);
        }

        .highlight-stat:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.2rem;
        }

        .stat-content {
            flex: 1;
        }

        .stat-value {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.2rem;
        }

        .stat-label {
            font-size: 0.9rem;
            color: var(--secondary-color);
        }

        .quick-actions-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
        }

        .actions-list {
            display: flex;
            flex-direction: column;
            gap: 0.8rem;
        }

        .action-button {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            padding: 0.8rem 1rem;
            background: var(--light-bg);
            border: none;
            border-radius: 12px;
            color: var(--dark-text);
            font-weight: 500;
            transition: var(--transition);
            cursor: pointer;
            width: 100%;
            text-align: left;
        }

        .action-button:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .action-button i {
            font-size: 1.1rem;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .action-button:hover i {
            color: white;
        }

        @media (max-width: 991.98px) {
            .agent-section {
                margin-top: 2rem;
            }
        }

        .property-meta {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .meta-item {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
            backdrop-filter: blur(5px);
            transition: var(--transition);
        }
        
        .meta-item:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }
        
        .meta-item i {
            font-size: 1.2rem;
        }
        
        .feature-item {
            background: var(--light-bg);
            padding: 1.2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--dark-text);
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        
        .feature-item:last-child {
            margin-bottom: 0;
        }
        
        .feature-item:hover {
            background: var(--gradient-primary);
            color: white;
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
        }
        
        .feature-item i {
            font-size: 1.3rem;
            color: var(--primary-color);
            transition: var(--transition);
        }
        
        .feature-item:hover i {
            color: white;
            transform: scale(1.2) rotate(10deg);
        }

        .quick-info-item {
            background: var(--light-bg);
            padding: 1.2rem;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: var(--transition);
            height: 100%;
        }

        .quick-info-item:hover {
            background: var(--gradient-primary);
            color: white;
            transform: translateY(-3px);
            box-shadow: var(--hover-shadow);
        }

        .quick-info-item i {
            font-size: 1.5rem;
            color: var(--primary-color);
            transition: var(--transition);
        }

        .quick-info-item:hover i {
            color: white;
            transform: scale(1.2) rotate(10deg);
        }

        .info-content {
            display: flex;
            flex-direction: column;
        }

        .info-value {
            font-size: 1.3rem;
            font-weight: 600;
        }

        .info-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .property-header-content {
            position: relative;
        }

        .highlights-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
        }

        .highlight-item {
            background: var(--light-bg);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .highlight-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: var(--gradient-primary);
            opacity: 0;
            transition: var(--transition);
            z-index: 1;
        }

        .highlight-item:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .highlight-item:hover::before {
            opacity: 0.1;
        }

        .highlight-icon {
            width: 70px;
            height: 70px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--primary-color);
            font-size: 1.8rem;
            transition: var(--transition);
            position: relative;
            z-index: 2;
            box-shadow: var(--card-shadow);
        }

        .highlight-item:hover .highlight-icon {
            background: var(--gradient-primary);
            color: white;
            transform: scale(1.1) rotate(5deg);
        }

        .highlight-content {
            position: relative;
            z-index: 2;
        }

        .highlight-content h4 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        .highlight-content p {
            color: var(--secondary-color);
            margin: 0;
            font-size: 1rem;
            font-weight: 500;
        }

        .highlight-item:hover .highlight-content h4,
        .highlight-item:hover .highlight-content p {
            color: var(--primary-color);
        }

        @media (max-width: 991.98px) {
            .highlights-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 575.98px) {
            .highlights-grid {
                grid-template-columns: 1fr;
            }
        }

        .location-details {
            background: var(--light-bg);
            border-radius: 15px;
            padding: 2rem;
        }

        .location-main {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: flex-start;
            gap: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            transition: var(--transition);
        }

        .location-main:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .location-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .location-item {
            background: white;
            border-radius: 12px;
            padding: 1.2rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .location-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }

        .location-icon {
            width: 45px;
            height: 45px;
            min-width: 45px;
            background: var(--light-bg);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.2rem;
            transition: var(--transition);
        }

        .location-item:hover .location-icon {
            background: var(--primary-color);
            color: white;
            transform: scale(1.1);
        }

        .location-main .location-icon {
            width: 50px;
            height: 50px;
            min-width: 50px;
            font-size: 1.4rem;
        }

        .location-content {
            flex: 1;
        }

        .location-label {
            color: var(--secondary-color);
            font-size: 0.9rem;
            margin-bottom: 0.3rem;
            font-weight: 500;
        }

        .location-value {
            color: var(--dark-text);
            font-size: 1.1rem;
            font-weight: 600;
            line-height: 1.4;
        }

        .location-main .location-value {
            font-size: 1.2rem;
        }

        @media (max-width: 991.98px) {
            .location-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 575.98px) {
            .location-details {
                padding: 1.5rem;
            }

            .location-main {
                padding: 1.2rem;
                gap: 1rem;
            }

            .location-item {
                padding: 1rem;
                gap: 0.8rem;
            }

            .location-icon {
                width: 40px;
                height: 40px;
                min-width: 40px;
                font-size: 1.1rem;
            }

            .location-main .location-icon {
                width: 45px;
                height: 45px;
                min-width: 45px;
                font-size: 1.3rem;
            }

            .location-value {
                font-size: 1rem;
            }

            .location-main .location-value {
                font-size: 1.1rem;
            }
        }

        @media (max-width: 768px) {
            .detail-item {
                padding: 1rem;
            }

            .detail-icon {
                width: 50px;
                height: 50px;
                font-size: 1.3rem;
                margin-right: 1rem;
            }

            .detail-value {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
    <%
    User currentUser = (User) session.getAttribute("user");
    if (currentUser != null) {
        if (currentUser.getUr() == UserRole.USER) {
    %>
        <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />
    <% } else if (currentUser.getUr() == UserRole.AGENT) { %>
        <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />
    <% } else { %>
        <jsp:include page="/WEB-INF/views/common/nav.jsp" />
    <% }
    } else { %>
        <jsp:include page="/WEB-INF/views/common/nav.jsp" />
    <% } %>

    <%
    Properties property = (Properties) request.getAttribute("prop");
    if (property != null)  {
    %>
    <!-- Property Header -->
    <div class="property-header">
        <div class="container">
            <div class="header-wrapper">
                <a href="javascript:history.back()" class="back-button">
                    <i class="fas fa-arrow-left"></i> Back to Properties
                </a>
                <div class="header-content">
                    <div class="header-left">
                        <h1 class="property-title"><%= property.getPropertyType() %></h1>
                    </div>
                    <div class="header-right">
                        <div class="property-price">
                            <span class="amount">
                                <% 
                                    long priceValue = property.getPrice();
                                    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
                                    formatter.setMaximumFractionDigits(0);
                                    String formattedPrice = formatter.format(priceValue);
                                %>
                                <%= formattedPrice %>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row g-4">
            <!-- Property Highlights -->
            <div class="col-lg-8">
                <div class="property-details-card">
                    <h3 class="mb-4">Property Overview</h3>
                    <div class="highlights-grid">
                        <div class="highlight-item">
                            <div class="highlight-icon">
                                <i class="fas fa-ruler-combined"></i>
                            </div>
                            <div class="highlight-content">
                                <h4><%= property.getArea() %> <%= property.getAreaUnit() %></h4>
                                <p>Total Area</p>
                            </div>
                        </div>
                        <div class="highlight-item">
                            <div class="highlight-icon">
                                <i class="fas fa-car"></i>
                            </div>
                            <div class="highlight-content">
                                <h4>Parking</h4>
                                <p>Available</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Detailed Information -->
                <div class="property-details-card">
                    <h3 class="mb-4">Property Details</h3>
                    <div class="detail-items-list">
                        
                            <div class="detail-item">
                                <div class="detail-icon">
                                    <i class="fas fa-home"></i>
                                </div>
                                <div class="detail-content">
                                    <div class="detail-label">Property Type</div>
                                    <div class="detail-value"><%= property.getPropertyType() %></div>
                                </div>
                            </div>
                        
                            <div class="detail-item">
                                <div class="detail-icon">
                                    <i class="fas fa-tag"></i>
                                </div>
                                <div class="detail-content">
                                    <div class="detail-label">Status</div>
                                    <div class="detail-value"><%= property.getStatus() %></div>
                                </div>
                            </div>
                        
                            <div class="detail-item">
                                <div class="detail-icon">
                                    <i class="fas fa-ruler-combined"></i>
                                </div>
                                <div class="detail-content">
                                    <div class="detail-label">Area</div>
                                    <div class="detail-value"><%= property.getArea() %> <%= property.getAreaUnit() %></div>
                                </div>
                            </div>
                        
                    </div>
                </div>

                <!-- Location Information -->
                <div class="property-details-card">
                    <h3 class="mb-4">Location Details</h3>
                    <div class="location-details">
                        <div class="location-main">
                            <div class="location-icon">
                                <i class="fas fa-map-marker-alt"></i>
                            </div>
                            <div class="location-content">
                                <div class="location-label">Full Address</div>
                                <div class="location-value"><%= property.getAddress() %></div>
                            </div>
                        </div>
                        <div class="location-grid">
                            <div class="location-item">
                                <div class="location-icon">
                                    <i class="fas fa-city"></i>
                                </div>
                                <div class="location-content">
                                    <div class="location-label">City</div>
                                    <div class="location-value"><%= property.getCity() %></div>
                                </div>
                            </div>
                            <div class="location-item">
                                <div class="location-icon">
                                    <i class="fas fa-map"></i>
                                </div>
                                <div class="location-content">
                                    <div class="location-label">State</div>
                                    <div class="location-value"><%= property.getState() %></div>
                                </div>
                            </div>
                            <div class="location-item">
                                <div class="location-icon">
                                    <i class="fas fa-mail-bulk"></i>
                                </div>
                                <div class="location-content">
                                    <div class="location-label">ZIP Code</div>
                                    <div class="location-value"><%= property.getZipCode() %></div>
                                </div>
                            </div>
                            <div class="location-item">
                                <div class="location-icon">
                                    <i class="fas fa-globe-asia"></i>
                                </div>
                                <div class="location-content">
                                    <div class="location-label">Country</div>
                                    <div class="location-value">India</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Features Section -->
                <div class="property-details-card">
                    <h3 class="mb-4">Features & Amenities</h3>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="feature-item">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <span>24/7 Security</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="feature-item">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <span>Parking Space</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="feature-item">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <span>Power Backup</span>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="feature-item">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                <span>Lift Facility</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Agent Information -->
            <div class="col-lg-4">
                <div class="agent-section">
                    <div class="agent-card">
                        <div class="agent-header">
                            <div class="agent-image">
                                <div class="agent-initial">
                                    <%= property.getUser_id().getFirstName().charAt(0) %>
                                </div>
                            </div>
                            <div class="agent-info">
                                <h3 class="agent-name"><%= property.getUser_id().getFirstName() %> <%= property.getUser_id().getLastName() %></h3>
                                <p class="agent-role">Property Agent</p>
                            </div>
                        </div>
                        <div class="agent-contact">
                            <div class="contact-item">
                                <i class="fas fa-envelope"></i>
                                <a href="mailto:<%= property.getUser_id().getEmail() %>"><%= property.getUser_id().getEmail() %></a>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-phone"></i>
                                <a href="tel:<%= property.getUser_id().getPhoneNumber() %>"><%= property.getUser_id().getPhoneNumber() %></a>
                            </div>
                        </div>
                        <div class="contact-buttons">
                            <a href="sms:<%= property.getUser_id().getPhoneNumber() %>" class="btn btn-primary">
                                <i class="fas fa-comment"></i> SMS
                            </a>
                            <a href="mailto:<%= property.getUser_id().getEmail() %>" class="btn btn-outline-primary">
                                <i class="fas fa-envelope"></i> Email
                            </a>
                            <a href="#" class="btn btn-success">
                                <i class="fas fa-calendar-alt"></i> Set Appointment
                            </a>
                        </div>
                    </div>

                    <!-- Property Highlights -->
                    <div class="property-highlights-card">
                        <h3 class="mb-4">Property Highlights</h3>
                        <div class="highlights-list">
                            <div class="highlight-stat">
                                <div class="stat-icon">
                                    <i class="fas fa-calendar-alt"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">Listed</div>
                                    <div class="stat-label">2 days ago</div>
                                </div>
                            </div>
                            <div class="highlight-stat">
                                <div class="stat-icon">
                                    <i class="fas fa-eye"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">Views</div>
                                    <div class="stat-label">245</div>
                                </div>
                            </div>
                            <div class="highlight-stat">
                                <div class="stat-icon">
                                    <i class="fas fa-heart"></i>
                                </div>
                                <div class="stat-content">
                                    <div class="stat-value">Saved</div>
                                    <div class="stat-label">18 times</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="quick-actions-card">
                        <h3 class="mb-4">Quick Actions</h3>
                        <div class="actions-list">
                            <button class="action-button">
                                <i class="fas fa-heart"></i>
                                Mark as Favorite
                            </button>
                            <button class="action-button">
                                <i class="fas fa-print"></i>
                                Print Details
                            </button>
                            <button class="action-button">
                                <i class="fas fa-download"></i>
                                Download Brochure
                            </button>
                        </div>
                    </div>

                    <!-- Placeholder for Map -->
                    <div class="property-details-card">
                        <h3 class="mb-4">Property Location</h3>
                        <div id="property-map" style="height: 300px; background-color: #e9ecef; display: flex; align-items: center; justify-content: center; color: #6c757d;">
                            Map will be embedded here.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="container mt-5">
        <div class="alert alert-danger">
            Property not found or has been removed.
        </div>
    </div>
    <% } %>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZQD8ATh6Nri+ZDoADu/a+h9RC6bY="
        crossorigin=""></script>

    <script>
        // Initialize the map
        var map = L.map('property-map').setView([51.505, -0.09], 13); // Placeholder coordinates and zoom level

        // Add a tile layer (OpenStreetMap)
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
        }).addTo(map);

        // TODO: Replace placeholder coordinates (51.505, -0.09) with actual property coordinates.
        // You can add a marker using:
        // L.marker([propertyLatitude, propertyLongitude]).addTo(map)
        //     .bindPopup('<b>Property Location</b>').openPopup();

    </script>
</body>
</html> 