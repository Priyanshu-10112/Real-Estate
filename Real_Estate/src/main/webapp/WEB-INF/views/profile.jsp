<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="com.example.Real_Estate.entity.UserRole" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

        .profile-banner {
            background: linear-gradient(90deg, #3498db 0%, #2c3e50 100%);
            height: 180px;
            border-radius: 0 0 30px 30px;
            position: relative;
            margin-bottom: -60px;
        }
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: #fff;
            border: 5px solid #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: #3498db;
            position: absolute;
            left: 50%;
            top: 120px;
            transform: translate(-50%, 0);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
            overflow: hidden;
        }
        .profile-upload {
            position: absolute;
            right: 10px;
            bottom: 10px;
            background: #fff;
            border-radius: 50%;
            padding: 6px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            cursor: pointer;
        }
        .profile-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-top: 80px;
            padding-top: 80px;
            max-width: 540px;
        }
        @media (max-width: 600px) {
            .profile-container { padding-top: 100px; }
            .profile-banner { height: 120px; }
            .profile-avatar { width: 80px; height: 80px; font-size: 2rem; top: 70px; }
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
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <c:redirect url="${pageContext.request.contextPath}/login" />
        </c:when>
        <c:otherwise>
            <c:set var="user" value="${sessionScope.user}" />
            <c:set var="userType" value="${user.ur.name().toLowerCase()}" />
            <c:choose>
                <c:when test="${userType eq 'user'}">
                    <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />
                </c:when>
                <c:when test="${userType eq 'agent'}">
                    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />
                </c:when>
            </c:choose>
            <main class="container">
                <div class="profile-container card mx-auto">
                    <div class="d-flex flex-column align-items-center mb-3">
                        <div style="width: 80px; height: 80px; background: #3498db; color: #fff; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 2.8rem; font-weight: bold; margin-bottom: 0.5rem; box-shadow: 0 2px 8px rgba(44,62,80,0.15);">
                            ${fn:toUpperCase(fn:substring(user.firstName,0,1))}
                        </div>
                    </div>
                    <h2 class="fw-bold mb-1 text-center">${user.firstName} ${user.lastName}</h2>
                    <div class="text-muted text-center mb-3">${user.email}</div>
                    <div class="profile-info mb-4">
                        <div class="info-group d-flex align-items-center mb-3">
                            <i class="fas fa-envelope fa-fw me-2" title="Email" aria-label="Email"></i>
                            <div class="info-label flex-grow-1">Email</div>
                            <div class="info-value">${user.email}</div>
                        </div>
                        <div class="info-group d-flex align-items-center mb-3">
                            <i class="fas fa-phone fa-fw me-2" title="Phone" aria-label="Phone"></i>
                            <div class="info-label flex-grow-1">Phone</div>
                            <div class="info-value">${user.phoneNumber}</div>
                        </div>
                        <div class="info-group d-flex align-items-center mb-3">
                            <i class="fas fa-user-tag fa-fw me-2" title="Account Type" aria-label="Account Type"></i>
                            <div class="info-label flex-grow-1">Account Type</div>
                            <div class="info-value">${user.ur}</div>
                        </div>
                        <c:if test="${userType eq 'agent'}">
                            <div class="info-group d-flex align-items-center mb-3">
                                <i class="fas fa-home fa-fw me-2" title="Properties" aria-label="Properties"></i>
                                <div class="info-label flex-grow-1">Total Properties</div>
                                <div class="info-value">${propertyCount}</div>
                            </div>
                        </c:if>
                    </div>
                    <div class="d-grid gap-2 mb-3">
                        <a href="${pageContext.request.contextPath}/profile/edit" class="btn btn-primary" aria-label="Edit Profile">
                            <i class="fas fa-edit"></i>
                            <span>Edit Profile</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/profile/change-password" class="btn btn-outline-secondary" aria-label="Change Password">
                            <i class="fas fa-key"></i>
                            <span>Change Password</span>
                        </a>
                        <c:choose>
                            <c:when test="${userType eq 'agent'}">
                                <a href="${pageContext.request.contextPath}/agent/agent-properties" class="btn btn-outline-info" aria-label="My Properties">
                                    <i class="fas fa-list"></i>
                                    <span>My Properties</span>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/favorites" class="btn btn-outline-info" aria-label="My Favorites">
                                    <i class="fas fa-heart"></i>
                                    <span>My Favorites</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/agent/dashboard" class="btn btn-success" aria-label="Back to Dashboard">
                            <i class="fas fa-arrow-left"></i>
                            <span>Back to Dashboard</span>
                        </a>
                    </div>
                </div>
            </main>
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        </c:otherwise>
    </c:choose>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="${pageContext.request.contextPath}/js/main.js?v=2"></script>
    <% if (session.getAttribute("success") != null) { %>
        <script>showAlert('<%= session.getAttribute("success") %>', 'success');</script>
        <% session.removeAttribute("success"); %>
    <% } %>
    <% if (session.getAttribute("error") != null) { %>
        <script>showAlert('<%= session.getAttribute("error") %>', 'error');</script>
        <% session.removeAttribute("error"); %>
    <% } %>
</body>
</html> 