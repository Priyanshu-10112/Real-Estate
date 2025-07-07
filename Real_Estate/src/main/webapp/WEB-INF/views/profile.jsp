<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="com.example.Real_Estate.entity.UserRole" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - EstateAura</title>
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
            color: var(--dark-text);
            padding-top: 80px;
        }

        .profile-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }

        .profile-container:hover {
            transform: translateY(-5px);
        }

        .profile-avatar {
            background: var(--primary-color) !important;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
            transition: transform 0.3s ease;
        }

        .profile-avatar:hover {
            transform: scale(1.05);
        }

        .info-group {
            background: var(--light-bg);
            padding: 1rem;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .info-group:hover {
            background: white;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .info-label {
            color: var(--secondary-color);
            font-weight: 600;
        }

        .info-value {
            color: var(--primary-color);
            font-weight: 500;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            position: relative;
            overflow: hidden;
            border: 2px solid transparent;
        }

        .btn-primary {
            background: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background: #2980b9;
            color: white;
        }

        .btn-outline-secondary {
            border-color: var(--secondary-color);
            color: var(--secondary-color);
            background: transparent;
        }

        .btn-outline-secondary:hover {
            background: var(--secondary-color);
            color: white;
        }

        .btn-outline-info {
            border-color: var(--primary-color);
            color: var(--primary-color);
            background: transparent;
        }

        .btn-outline-info:hover {
            background: var(--primary-color);
            color: white;
        }

        .btn-success {
            background: #2ecc71;
            color: white;
        }

        .btn-success:hover:not(:disabled) {
            background: #27ae60;
            color: white;
        }

        .btn:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .text-muted {
            color: #7f8c8d !important;
        }

        .fa-fw {
            color: var(--primary-color);
        }

        .d-grid {
            gap: 1rem !important;
        }

        .btn i {
            font-size: 1rem;
        }
    </style>
</head>
<body>
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String userType = user.getUr().name().toLowerCase();
        if (userType.equals("user")) {
    %>
        <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />
    <%
        } else if (userType.equals("agent")) {
    %>
        <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />
    <%
        }
    %>

    <main class="container py-5">
        <div class="profile-container card p-4 mx-auto" style="max-width: 500px;">
            <div class="profile-header text-center mb-4">
                <div class="profile-avatar mb-3 mx-auto" style="width: 90px; height: 90px; color: white; font-size: 2.5rem; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                </div>
                <h2 class="fw-bold mb-1">${user.firstName} ${user.lastName}</h2>
                <div class="text-muted">${user.email}</div>
            </div>
            <div class="profile-info mb-4">
                <div class="info-group d-flex align-items-center mb-3">
                    <i class="fas fa-envelope fa-fw me-2"></i>
                    <div class="info-label flex-grow-1">Email</div>
                    <div class="info-value">${user.email}</div>
                </div>
                
                <div class="info-group d-flex align-items-center mb-3">
                    <i class="fas fa-phone fa-fw me-2"></i>
                    <div class="info-label flex-grow-1">Phone</div>
                    <div class="info-value">${user.phoneNumber}</div>
                </div>
                <div class="info-group d-flex align-items-center mb-3">
                    <i class="fas fa-user-tag fa-fw me-2"></i>
                    <div class="info-label flex-grow-1">Account Type</div>
                    <div class="info-value">${user.ur}</div>
                </div>
            </div>
            <div class="d-grid gap-2 mb-3">
                <a href="${pageContext.request.contextPath}/${user.ur}/profile/edit" class="btn btn-primary">
                    <i class="fas fa-edit"></i>
                    <span>Edit Profile</span>
                </a>
                <a href="${pageContext.request.contextPath}/${user.ur}/profile/change-password" class="btn btn-outline-secondary">
                    <i class="fas fa-key"></i>
                    <span>Change Password</span>
                </a>
                <% if (userType.equals("agent")) { %>
                    <a href="${pageContext.request.contextPath}/agent/my-properties" class="btn btn-outline-info">
                        <i class="fas fa-list"></i>
                        <span>My Properties</span>
                    </a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/user/favorites" class="btn btn-outline-info">
                        <i class="fas fa-heart"></i>
                        <span>My Favorites</span>
                    </a>
                <% } %>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
</body>
</html> 