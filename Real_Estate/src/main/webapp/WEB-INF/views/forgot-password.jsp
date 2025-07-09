<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - EstateAura</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        .forgot-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 6rem 2rem 2rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }
        .forgot-card {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        .forgot-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        .forgot-header h1 {
            color: #2c3e50;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.8rem;
        }
        .forgot-header p {
            color: #6c757d;
            font-size: 1.1rem;
            margin-bottom: 0;
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
        .btn-forgot {
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
        .btn-forgot:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
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
        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <div class="forgot-card">
            <div class="forgot-header">
                <h1>Forgot Password</h1>
                <p class="text-muted">Enter your email to receive an OTP</p>
            </div>
            <% String error = (String)request.getAttribute("error"); %>
            <% String success = (String)request.getAttribute("success"); %>
            <% if(error != null && !error.isEmpty()) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i><%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            <% if(success != null && !success.isEmpty()) { %>
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= success %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>
            <form action="${pageContext.request.contextPath}/forgot-password" method="post">
                <div class="form-group">
                    <label for="email" class="form-label">Email address</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <button type="submit" class="btn btn-forgot">
                    <i class="fas fa-paper-plane me-2"></i>Send OTP
                </button>
            </form>
            <div style="text-align:center; margin-top:2rem;">
                <a href="${pageContext.request.contextPath}/login" style="color:#3498db; text-decoration:none;">Back to Login</a>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        const submitBtn = form.querySelector('button[type="submit"]');
        let alertDiv = null;
        form.addEventListener('submit', async function(e) {
            e.preventDefault();
            // Remove previous alert if exists
            if (alertDiv) alertDiv.remove();
            // Show loading indicator
            submitBtn.disabled = true;
            const originalBtnText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Sending...';
            const email = document.getElementById('email').value;
            try {
                const response = await fetch('${pageContext.request.contextPath}/api/send-reset-otp', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ email })
                });
                const result = await response.json();
                alertDiv = document.createElement('div');
                alertDiv.className = 'alert ' + (response.ok ? 'alert-success' : 'alert-danger') + ' alert-dismissible fade show';
                alertDiv.role = 'alert';
                if (response.ok) {
                    alertDiv.innerHTML = `<i class='fas fa-check-circle me-2'></i>OTP sent! Please check your email for the code.<br>If you don't see it, check your spam folder.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>`;
                } else {
                    alertDiv.innerHTML = `<i class='fas fa-exclamation-circle me-2'></i>${result.message || 'Failed to send OTP. Please try again.'}<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>`;
                }
                form.parentNode.insertBefore(alertDiv, form);
                if(response.ok) {
                    setTimeout(function() {
                        window.location.href = '${pageContext.request.contextPath}/verify-reset-otp?email=' + encodeURIComponent(email);
                    }, 1800);
                }
            } catch (err) {
                alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-danger alert-dismissible fade show';
                alertDiv.role = 'alert';
                alertDiv.innerHTML = `<i class='fas fa-exclamation-circle me-2'></i>Network error. Please try again.<button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>`;
                form.parentNode.insertBefore(alertDiv, form);
            } finally {
                submitBtn.disabled = false;
                submitBtn.innerHTML = originalBtnText;
            }
        });
    });
    </script>
</body>
</html> 