<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="com.example.Real_Estate.entity.Properties" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Property Details - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        .property-header {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            color: white;
            padding: 4rem 0;
            margin-bottom: 2rem;
        }
        
        .property-status {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 500;
            display: inline-block;
            margin-bottom: 1rem;
        }
        
        .status-available { background-color: #e8f5e9; color: #2e7d32; }
        .status-sold { background-color: #ffebee; color: #c62828; }
        .status-rent { background-color: #e3f2fd; color: #1565c0; }
        .status-pre_launch { background-color: #fff3e0; color: #ef6c00; }
        
        .property-price {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .property-details-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
        }
        
        .detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid #eee;
        }
        
        .detail-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .detail-icon {
            width: 40px;
            height: 40px;
            background: var(--light-bg);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            color: var(--primary-color);
        }
        
        .detail-content {
            flex: 1;
        }
        
        .detail-label {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 0.2rem;
        }
        
        .detail-value {
            font-size: 1.1rem;
            font-weight: 500;
            color: #333;
        }
        
        .agent-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 2rem;
            text-align: center;
        }
        
        .agent-image {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            overflow: hidden;
        }
        
        .agent-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .agent-name {
            font-size: 1.4rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }
        
        .agent-email {
            color: #666;
            margin-bottom: 1rem;
        }
        
        .contact-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
        }
        
        .contact-buttons .btn {
            flex: 1;
            max-width: 200px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-home"></i>
                <span>LuxuryEstate</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home"></i>
                            <span>Home</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/about">
                            <i class="fas fa-info-circle"></i>
                            <span>About Us</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                            <i class="fas fa-envelope"></i>
                            <span>Contact Us</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i>
                            <span>Login</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">
                            <i class="fas fa-user-plus"></i>
                            <span>Register</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

     <%
    Properties property = (Properties) request.getAttribute("prop");
    if (property != null)  {
  %>
    <!-- Property Header -->
    <div class="property-header">
        <div class="container">
            <span class="property-status status- <%= property.getStatus().toString().toLowerCase() %> %>">
                 <%= property.getStatus() %> 
            </span>
            <h1 class="mb-3"> <%= property.getPropertyType() %> </h1>
            <%-- <div class="property-price"> <%= property.getPrice() %></div> --%>
            <p class="mb-0">
                <i class="fas fa-map-marker-alt me-2"></i>
                 <%= property.getAddress() %>, <%= property.getCity() %>, <%= property.getState() %> <%= property.getZipCode() %> 
            </p>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <!-- Property Details -->
            <div class="col-lg-8">
                <div class="property-details-card">
                    <h3 class="mb-4">Property Details</h3>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Property Type</div>
                            <div class="detail-value"> <%= property.getPropertyType() %> </div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-tag"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Status</div>
                            <div class="detail-value"> <%= property.getStatus() %></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <div class="detail-content">
                            <div class="detail-label">Location</div>
                            <div class="detail-value">
                               <%= property.getAddress() %><br>
                                <%= property.getCity() %>, <%= property.getState() %> <%= property.getZipCode() %><br>
                                <%= property.getCountry() %> 
                            </div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                        <div class="detail-content">
                             <div class="detail-label">Price</div>
                            <div class="detail-value">₹<%= property.getPrice() %></div> 
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Agent Information -->
            <div class="col-lg-4">
                <div class="agent-card">
                    <div class="agent-image">
                        <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3" alt="Agent">
                    </div>
                     <h3 class="agent-name"><%= property.getUser_id().getEmail() %></h3>
                    <p class="agent-email"><%= property.getUser_id().getEmail() %></p> 
                    <div class="contact-buttons">
                        <button class="btn btn-primary">
                            <i class="fas fa-phone me-2"></i>Call
                        </button>
                        <button class="btn btn-outline-primary">
                            <i class="fas fa-envelope me-2"></i>Email
                        </button>
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

    <!-- Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
</body>
</html> 