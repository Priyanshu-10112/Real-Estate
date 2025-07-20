<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String userType = user.getUr().name().toLowerCase();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password - EstateAura</title>
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
        .form-label {
            color: var(--secondary-color);
            font-weight: 600;
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
        .alert {
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <% if (userType.equals("user")) { %>
        <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />
    <% } else if (userType.equals("agent")) { %>
        <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />
    <% } %>
    <main class="container py-5">
        <div class="profile-container card p-4 mx-auto" style="max-width: 500px;">
            <div class="text-center mb-4">
                <div class="profile-avatar mb-3 mx-auto" style="width: 90px; height: 90px; color: white; font-size: 2.5rem; border-radius: 50%; display: flex; align-items: center; justify-content: center; background: var(--primary-color); box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);">
                    <i class="fas fa-key"></i>
                </div>
                <h2 class="fw-bold mb-1">Change Password</h2>
                <div class="text-muted">${user.email}</div>
            </div>
            <form action="${pageContext.request.contextPath}/profile/change-password" method="post">
                <div class="mb-3">
                    <label for="currentPassword" class="form-label">Current Password</label>
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                </div>
                <div class="mb-3">
                    <label for="newPassword" class="form-label">New Password</label>
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                </div>
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                </div>
                <div class="d-grid gap-2 mb-3">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-key"></i>
                        <span>Change Password</span>
                    </button>
                    <a href="${pageContext.request.contextPath}/profile" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left"></i>
                        <span>Back to Profile</span>
                    </a>
                </div>
            </form>
            <% if (request.getAttribute("error") != null) { %>
                <script>showAlert('<%= request.getAttribute("error") %>', 'error');</script>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <script>showAlert('<%= request.getAttribute("success") %>', 'success');</script>
            <% } %>
        </div>
    </main>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html> 