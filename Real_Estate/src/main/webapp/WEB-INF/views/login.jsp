<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EstateAura</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    <style>
        .navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem 0;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
        }
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .navbar-brand i {
            color: #3498db;
        }
        .nav-link {
            color: #2c3e50 !important;
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: color 0.3s ease;
        }
        .nav-link:hover {
            color: #3498db !important;
        }
        .nav-link i {
            margin-right: 0.5rem;
            color: #3498db;
        }
        .login-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 6rem 2rem 2rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            margin-top: 0;
        }
        .login-card {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            transition: transform 0.3s ease;
            margin-top: 0;
        }
        .login-card:hover {
            transform: translateY(-5px);
        }
        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        .login-header h1 {
            color: #2c3e50;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.8rem;
        }
        .login-header p {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            color: #2c3e50;
            font-weight: 500;
            margin-bottom: 0.6rem;
            display: block;
        }
        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            font-size: 1rem;
            transition: all 0.3s ease;
            height: auto;
        }
        .form-check {
            margin: 1.5rem 0;
            padding-left: 1.8rem;
        }
        .form-check-input {
            margin-left: -1.8rem;
            margin-top: 0.3rem;
        }
        .form-check-label {
            color: #6c757d;
            font-size: 0.95rem;
        }
        .btn-login {
            background: #3498db;
            color: white;
            border: none;
            padding: 0.85rem;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            margin-top: 0.5rem;
            transition: all 0.3s ease;
            font-size: 1.05rem;
        }
        .btn-login:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .register-link {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e9ecef;
        }
        .register-link p {
            margin-bottom: 0;
            color: #6c757d;
        }
        .form-check-input:checked {
            background-color: #3498db;
            border-color: #3498db;
        }
        .alert {
            border-radius: 8px;
            border: none;
            padding: 1rem;
            margin-bottom: 1.5rem;
        }
        .alert-danger {
            background-color: #fee2e2;
            color: #dc2626;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-home"></i>
                <span>EstateAura</span>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/login">
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

    <div class="login-container" data-aos="fade-up" data-aos-duration="1200">
        <div class="login-card">
            <div class="login-header">
                <div style="font-size: 2.5rem; color: #3498db; margin-bottom: 0.5rem;"><i class="fas fa-user-circle"></i></div>
                <h1>Welcome Back</h1>
                <p class="text-muted">Sign in to your EstateAura account</p>
            </div>
            <% String error = (String)request.getAttribute("error"); %>
            <% if(error != null && !error.isEmpty()) { %>
                <script>showAlert('<%= error %>', 'error');</script>
            <% } %>
            <form action="${pageContext.request.contextPath}/log" method="post" onsubmit="return validateForm()">
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Email address" required>
                    <label for="email">Email address</label>
                </div>
                <div class="form-floating mb-3 position-relative">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                    <label for="password">Password</label>
                    <span class="position-absolute top-50 end-0 translate-middle-y me-3" style="cursor:pointer;" onclick="togglePassword()"><i class="fas fa-eye" id="togglePasswordIcon"></i></span>
                </div>
                <div style="text-align: right; margin-bottom: 1rem;">
                    <a href="${pageContext.request.contextPath}/forgot-password" style="color: #3498db; font-size: 0.97rem; text-decoration: none; font-weight: 500;">Forgot Password?</a>
                </div>
                <div class="form-check mb-3">
                    <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                    <label class="form-check-label" for="rememberMe">Remember me</label>
                </div>
                <button type="submit" class="btn btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>Login
                </button>
            </form>
            <div class="register-link">
                <p>Don't have an account? <a href="${pageContext.request.contextPath}/register" style="color:#3498db; font-weight:600;">Register here</a></p>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
      AOS.init({ once: true });
      function togglePassword() {
        const pwd = document.getElementById('password');
        const icon = document.getElementById('togglePasswordIcon');
        if (pwd.type === 'password') {
          pwd.type = 'text';
          icon.classList.remove('fa-eye');
          icon.classList.add('fa-eye-slash');
        } else {
          pwd.type = 'password';
          icon.classList.remove('fa-eye-slash');
          icon.classList.add('fa-eye');
        }
      }
    </script>
</body>
</html> 