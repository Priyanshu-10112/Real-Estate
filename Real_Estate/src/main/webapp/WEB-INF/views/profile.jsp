<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
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
                <li>
                    <%String ur=(String)request.getAttribute("ur");
                    
                    %>
                        <a class="nav-link" href="${pageContext.request.contextPath}/${ur}/dashboard"><i class="fas fa-tachometer-alt me-1"></i>Dashboard</a>
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
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container py-5">
        <div class="profile-container card shadow-lg p-4 mx-auto" style="max-width: 500px;">
            <div class="profile-header text-center mb-4">
                <div class="profile-avatar mb-3 mx-auto" style="width: 90px; height: 90px; background: var(--secondary-color); color: white; font-size: 2.5rem; border-radius: 50%; display: flex; align-items: center; justify-content: center;">
                    ${user.firstName.charAt(0)}${user.lastName.charAt(0)}
                </div>
                <h2 class="fw-bold mb-1">${user.firstName} ${user.lastName}</h2>
                <div class="text-muted">${user.email}</div>
            </div>
            <div class="profile-info mb-4">
                <div class="info-group d-flex align-items-center mb-3">
                    <i class="fas fa-envelope fa-fw me-2 text-secondary"></i>
                    <div class="info-label flex-grow-1">Email</div>
                    <div class="info-value">${user.email}</div>
                </div>
                
                <div class="info-group d-flex align-items-center mb-3">
                    <i class="fas fa-phone fa-fw me-2 text-secondary"></i>
                    <div class="info-label flex-grow-1">Phone</div>
                    <div class="info-value">${user.phoneNumber}</div>
                </div>
                <div class="info-group d-flex align-items-center mb-3">
                    <i class="fas fa-user-tag fa-fw me-2 text-secondary"></i>
                    <div class="info-label flex-grow-1">Account Type</div>
                    <div class="info-value">${user.ur}</div>
                </div>
            </div>
            <div class="d-grid gap-2 mb-3">
                <a href="${pageContext.request.contextPath}/user/profile/edit" class="btn btn-primary"><i class="fas fa-edit me-1"></i>Edit Profile</a>
                <a href="${pageContext.request.contextPath}/user/profile/change-password" class="btn btn-outline-secondary"><i class="fas fa-key me-1"></i>Change Password</a>
                <a href="${pageContext.request.contextPath}/user/profile/my-properties" class="btn btn-outline-info"><i class="fas fa-list me-1"></i>My Properties</a>
            </div>
            <div class="text-center">
                <button class="btn btn-success" disabled><i class="fas fa-save me-1"></i>Save Changes</button>
            </div>
        </div>
    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
</body>
</html> 