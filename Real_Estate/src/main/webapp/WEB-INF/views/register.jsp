<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - EstateAura</title>
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
        .register-container {
            min-height: 150vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }
        .register-card {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
        }
        .register-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }
        .register-header h1 {
            color: #2c3e50;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 0.8rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        .form-label {
            color: #2c3e50;
            font-weight: 500;
            margin-bottom: 0.6rem;
        }
        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 2px solid #e9ecef;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }
        .btn-register {
            background: #3498db;
            color: white;
            border: none;
            padding: 0.85rem;
            border-radius: 8px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
        }
        .btn-register:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
        .login-link {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e9ecef;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt"></i>
                            <span>Login</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/register">
                            <i class="fas fa-user-plus"></i>
                            <span>Register</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="register-container" data-aos="fade-up" data-aos-duration="1200">
        <div class="register-card">
            <div class="register-header">
                <div style="font-size: 2.5rem; color: #3498db; margin-bottom: 0.5rem;"><i class="fas fa-user-plus"></i></div>
                <h1>Create Account</h1>
                <p class="text-muted">Join our real estate community</p>
            </div>
            <form id="registerForm" action="\regis" method="post">
                <div id="registrationStep1">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
                                <label for="firstName">First Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
                                <label for="lastName">Last Name</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email address" required>
                        <label for="email">Email address</label>
                    </div>
                    <div class="form-floating mb-3 position-relative">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required oninput="checkStrength()">
                        <label for="password">Password</label>
                        <span class="position-absolute top-50 end-0 translate-middle-y me-3" style="cursor:pointer;" onclick="togglePassword()"><i class="fas fa-eye" id="togglePasswordIcon"></i></span>
                        <div class="progress mt-2" style="height: 5px;">
                            <div id="passwordStrength" class="progress-bar" role="progressbar" style="width: 0%;"></div>
                        </div>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" placeholder="Phone Number" required pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">
                        <label for="phoneNumber">Phone Number</label>
                    </div>
                    <div class="form-floating mb-3">
                        <select class="form-select" id="ur" name="ur" required>
                            <option value="">Select Role</option>
                            <option value="USER">User</option>
                            <option value="AGENT">Agent</option>
                        </select>
                        <label for="ur">I am a</label>
                    </div>
                    <button type="button" class="btn btn-register" onclick="sendOTP()">
                        <i class="fas fa-paper-plane me-2"></i>Send OTP
                    </button>
                </div>
                <div id="otpVerificationStep" style="display: none;">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" id="otp" name="otp" placeholder="Enter OTP" required maxlength="6" pattern="[0-9]{6}">
                        <label for="otp">Enter OTP</label>
                    </div>
                    <small class="text-muted">Please enter the 6-digit OTP sent to your email</small>
                    <div class="d-flex gap-2 mt-3">
                        <button type="button" class="btn btn-register" onclick="verifyOTP()">
                            <i class="fas fa-check me-2"></i>Verify OTP
                        </button>
                        <button type="button" class="btn btn-secondary" onclick="resendOTP()">
                            <i class="fas fa-redo me-2"></i>Resend OTP
                        </button>
                    </div>
                </div>
            </form>
            <div class="login-link">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/login" style="color:#3498db; font-weight:600;">Login here</a></p>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
      AOS.init({ once: true });
      let registrationData = null;

      async function sendOTP() {
          // Validate all required fields
          const firstName = document.getElementById('firstName').value;
          const lastName = document.getElementById('lastName').value;
          const email = document.getElementById('email').value;
          const password = document.getElementById('password').value;
          const phoneNumber = document.getElementById('phoneNumber').value;
          const ur = document.getElementById('ur').value;

          if (!firstName || !lastName || !email || !password || !phoneNumber || !ur) {
              showAlert('Please fill in all required fields', 'warning');
              return;
          }

          registrationData = {
              firstName: firstName,
              lastName: lastName,
              email: email,
              password: password,
              phoneNumber: phoneNumber,
              ur: ur
          };

          console.log('Sending registration data:', registrationData);

          try {
              const response = await fetch('${pageContext.request.contextPath}/api/send-otp', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(registrationData)
              });

              const data = await response.json();

              if (response.ok) {
                  document.getElementById('registrationStep1').style.display = 'none';
                  document.getElementById('otpVerificationStep').style.display = 'block';
                  showAlert('OTP has been sent to your email!', 'success');
              } else {
                  showAlert(data.message || 'Failed to send OTP', 'error');
              }
          } catch (error) {
              console.error('Error:', error);
              showAlert('An error occurred while sending OTP', 'error');
          }
      }

      async function verifyOTP() {
          const otp = document.getElementById('otp').value;
          console.log('Verifying OTP:', otp, 'for email:', registrationData.email);

          try {
              const response = await fetch('${pageContext.request.contextPath}/api/verify-otp', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify({
                      email: registrationData.email,
                      otp: otp
                  })
              });

              const data = await response.json();
              console.log('Verification response:', data);

              if (response.ok) {
                  showAlert('Registration successful!', 'success');
                  window.location.href = '${pageContext.request.contextPath}/login';
              } else {
                  showAlert(data.message || 'Invalid OTP', 'error');
              }
          } catch (error) {
              console.error('Error:', error);
              showAlert('An error occurred during OTP verification', 'error');
          }
      }

      async function resendOTP() {
          try {
              const response = await fetch('${pageContext.request.contextPath}/api/send-otp', {
                  method: 'POST',
                  headers: {
                      'Content-Type': 'application/json'
                  },
                  body: JSON.stringify(registrationData)
              });

              const data = await response.json();

              if (response.ok) {
                  showAlert('New OTP has been sent to your email!', 'success');
              } else {
                  showAlert(data.message || 'Failed to resend OTP', 'error');
              }
          } catch (error) {
              console.error('Error:', error);
              showAlert('An error occurred while resending OTP', 'error');
          }
      }
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
      function checkStrength() {
        const pwd = document.getElementById('password').value;
        const bar = document.getElementById('passwordStrength');
        let strength = 0;
        if (pwd.length > 5) strength += 1;
        if (pwd.match(/[A-Z]/)) strength += 1;
        if (pwd.match(/[0-9]/)) strength += 1;
        if (pwd.match(/[^A-Za-z0-9]/)) strength += 1;
        bar.style.width = (strength * 25) + '%';
        bar.className = 'progress-bar';
        if (strength === 1) bar.classList.add('bg-danger');
        else if (strength === 2) bar.classList.add('bg-warning');
        else if (strength === 3) bar.classList.add('bg-info');
        else if (strength === 4) bar.classList.add('bg-success');
      }
    </script>
</body>
</html> 