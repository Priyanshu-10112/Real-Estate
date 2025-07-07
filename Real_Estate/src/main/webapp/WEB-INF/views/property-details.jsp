<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
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
            --section-spacing: 1rem;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .property-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2rem 0;
            position: relative;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
        }
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 2rem;
            margin-top: 1rem;
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
            line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
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
        .property-badges {
            margin-top: 1rem;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
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
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
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
            padding: 1rem;
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
        .quick-actions-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .actions-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        .action-button {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
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
            transform: translateY(-3px);
        }
        .action-button i {
            font-size: 1.2rem;
            color: var(--primary-color);
            transition: var(--transition);
        }
        .action-button:hover i {
            color: white;
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
            z-index: 2;
        }
        @media (max-width: 991.98px) {
            .header-content {
                flex-direction: column;
                gap: 1.5rem;
            }
            .property-title {
                font-size: 2rem;
            }
            .property-price {
                width: 100%;
                justify-content: center;
            }
            .agent-section {
                margin-top: 2rem;
            }
            .detail-grid {
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
            box-shadow: var(--card-shadow);
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
            box-shadow: var(--card-shadow);
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
            .main-image {
                height: 300px;
            }
            .property-details-card {
                padding: 1.5rem;
            }
            .detail-item {
                padding: 1rem;
            }
            .location-details {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%-- Retrieve and check property object --%>
    <% Properties property = (Properties) request.getAttribute("prop");
    if (property != null) { %>

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
                        <div class="property-badges">
                            <span class="property-status">
                                <i class="fas fa-tag"></i> <%= property.getStatus() %>
                            </span>
                            <span class="property-type">
                                <i class="fas fa-home"></i> <%= property.getPropertyType() %>
                            </span>
                        </div>
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
        <div class="row">
            <!-- Main Content Column -->
            <div class="col-lg-8">
                <!-- Property Gallery -->
                <div class="property-details-card property-gallery">
                    <img src="${pageContext.request.contextPath}/images/properties/<%= property.getImage() %>" 
                         alt="<%= property.getPropertyType() %>" 
                         class="main-image">
                </div>

                <!-- Property Details -->
                <div class="property-details-card">
                    <h3 class="section-title">Property Details</h3>
                    <div class="detail-grid">
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
                    <h3 class="section-title">Location Details</h3>
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
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Sidebar Column -->
            <div class="col-lg-4">
                <!-- Quick Actions -->
                <div class="quick-actions-card">
                    <h3 class="section-title">Quick Actions</h3>
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

                <!-- Agent Details -->
                <% 
                    User loggedInUser = (User) session.getAttribute("user");
                    if (loggedInUser == null || !loggedInUser.getEmail().equals(property.getUser_id().getEmail())) { 
                %>
                <div class="property-details-card">
                    <h3 class="section-title">Agent Details</h3>
                    <div class="agent-section">
                        <div class="agent-card">
                            <div class="agent-header">
                                <div class="agent-image">
                                    <div class="agent-initial">
                                        <%= property.getUser_id() != null ? property.getUser_id().getFirstName().charAt(0) : 'A' %>
                                    </div>
                                </div>
                                <h4 class="agent-name">
                                    <%= property.getUser_id() != null ? property.getUser_id().getFirstName() + " " + property.getUser_id().getLastName() : "Agent Name" %>
                                </h4>
                                <p class="agent-role">Real Estate Agent</p>
                            </div>
                            <div class="agent-contact">
                                <% if (property.getUser_id() != null) { %>
                                    <div class="contact-item">
                                        <i class="fas fa-phone"></i>
                                        <span><%= property.getUser_id().getPhoneNumber() %></span>
                                    </div>
                                    <div class="contact-item">
                                        <i class="fas fa-envelope"></i>
                                        <span><%= property.getUser_id().getEmail() %></span>
                                    </div>
                                <% } %>
                            </div>
                            <div class="contact-buttons">
                                <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#appointmentModal">
                                    <i class="fas fa-calendar-check me-2"></i> Set Appointment
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Appointment Modal -->
    <div class="modal fade" id="appointmentModal" tabindex="-1" aria-labelledby="appointmentModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="appointmentModalLabel">Schedule Viewing Appointment</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="appointmentForm">
                        <input type="hidden" id="propertyId" name="propertyId" value="<%= property.getId() %>">
                        <div class="mb-3">
                            <label for="appointmentDate" class="form-label">Preferred Date</label>
                            <input type="date" class="form-control" id="appointmentDate" required>
                        </div>
                        <div class="mb-3">
                            <label for="appointmentTime" class="form-label">Preferred Time</label>
                            <input type="time" class="form-control" id="appointmentTime" required>
                        </div>
                        <div class="mb-3">
                            <label for="appointmentMessage" class="form-label">Message (Optional)</label>
                            <textarea class="form-control" id="appointmentMessage" rows="3" placeholder="Add any specific requirements or questions..."></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="submitAppointment">Schedule Appointment</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Notification -->
    <div class="alert alert-success alert-dismissible fade" id="successAlert" role="alert" style="position: fixed; top: 100px; right: 20px; z-index: 1050; min-width: 300px;">
        <i class="fas fa-check-circle me-2"></i>
        <strong>Success!</strong> Appointment scheduled successfully! The agent will review your request and get back to you soon.
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <!-- Error Notification -->
    <div class="alert alert-danger alert-dismissible fade" id="errorAlert" role="alert" style="position: fixed; top: 100px; right: 20px; z-index: 1050; min-width: 300px;">
        <i class="fas fa-exclamation-circle me-2"></i>
        <strong>Error!</strong> <span id="errorMessage">Failed to schedule appointment. Please try again.</span>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

    <% } else { %>
    <div class="container">
        <div class="alert alert-danger">
            Property not found or has been removed.
        </div>
    </div>
    <% } %>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <!-- Update script imports -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>

    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZQD8ATh6Nri+ZDoADu/a+h9RC6bY="
        crossorigin=""></script>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        // Set minimum date to today
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('appointmentDate').min = today;

        // Initialize Bootstrap modal
        var appointmentModal = new bootstrap.Modal(document.getElementById('appointmentModal'));

        // Handle appointment submission
        document.getElementById('submitAppointment').addEventListener('click', function() {
            var propertyId = document.getElementById('propertyId').value;
            if (!propertyId) {
                alert('Property ID is missing. Please try again.');
                return;
            }

            var appointmentData = {
                property: {
                    id: propertyId
                },
                appointmentDate: document.getElementById('appointmentDate').value + 'T' + 
                               document.getElementById('appointmentTime').value,
                message: document.getElementById('appointmentMessage').value,
                status: 'PENDING'
            };

            fetch('${pageContext.request.contextPath}/api/appointments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(appointmentData)
            })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(text => {
                        throw new Error(text || 'Failed to create appointment');
                    });
                }
                return response.json();
            })
            .then(data => {
                appointmentModal.hide();
                showSuccessNotification();
                document.getElementById('appointmentForm').reset();
            })
            .catch(error => {
                showErrorNotification(error.message || 'Error scheduling appointment. Please try again later.');
            });
        });

        // Form validation
        document.getElementById('appointmentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            document.getElementById('submitAppointment').click();
        });
        
        function showSuccessNotification() {
            const successAlert = document.getElementById('successAlert');
            successAlert.classList.add('show');
            setTimeout(() => {
                successAlert.classList.remove('show');
            }, 5000);
        }
        
        function showErrorNotification(message) {
            const errorAlert = document.getElementById('errorAlert');
            const errorMessage = document.getElementById('errorMessage');
            errorMessage.textContent = message;
            errorAlert.classList.add('show');
            setTimeout(() => {
                errorAlert.classList.remove('show');
            }, 5000);
        }
    });
    </script>
</body>
</html> 