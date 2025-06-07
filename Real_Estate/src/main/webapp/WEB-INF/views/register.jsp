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
    <style>
        .register-container {
            min-height: 100vh;
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
    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <h1>Create Account</h1>
                <p class="text-muted">Join our real estate community</p>
            </div>
            <form id="registerForm" action="\regis" method="post">
                <div id="registrationStep1">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="firstName" class="form-label">First Name</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="lastName" class="form-label">Last Name</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="form-label">Email address</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber" class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" required pattern="[0-9]{10}" title="Please enter a valid 10-digit phone number">
                    </div>
                    <div class="form-group">
                        <label for="ur" class="form-label">I am a</label>
                        <select class="form-select" id="ur" name="ur" required>
                            <option value="">Select Role</option>
                            <option value="USER">User</option>
                            <option value="AGENT">Agent</option>
                        </select>
                    </div>
                    <button type="button" class="btn btn-register" onclick="sendOTP()">
                        <i class="fas fa-paper-plane me-2"></i>Send OTP
                    </button>
                </div>

                <div id="otpVerificationStep" style="display: none;">
                    <div class="form-group">
                        <label for="otp" class="form-label">Enter OTP</label>
                        <input type="text" class="form-control" id="otp" name="otp" required maxlength="6" pattern="[0-9]{6}">
                        <small class="text-muted">Please enter the 6-digit OTP sent to your email</small>
                    </div>
                    <div class="d-flex gap-2">
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
                <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let registrationData = null;

        async function sendOTP() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                alert('Passwords do not match!');
                return;
            }

            // Validate all required fields
            const firstName = document.getElementById('firstName').value;
            const lastName = document.getElementById('lastName').value;
            const email = document.getElementById('email').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            const ur = document.getElementById('ur').value;

            if (!firstName || !lastName || !email || !password || !confirmPassword || !phoneNumber || !ur) {
                alert('Please fill in all required fields');
                return;
            }

            registrationData = {
                firstName: firstName,
                lastName: lastName,
                email: email,
                password: password,
                confirmPassword: confirmPassword,
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
                    alert('OTP has been sent to your email!');
                } else {
                    alert(data.message || 'Failed to send OTP');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred while sending OTP');
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
                    alert('Registration successful!');
                    window.location.href = '${pageContext.request.contextPath}/login';
                } else {
                    alert(data.message || 'Invalid OTP');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred during OTP verification');
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
                    alert('New OTP has been sent to your email!');
                } else {
                    alert(data.message || 'Failed to resend OTP');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('An error occurred while resending OTP');
            }
        }
    </script>
</body>
</html> 