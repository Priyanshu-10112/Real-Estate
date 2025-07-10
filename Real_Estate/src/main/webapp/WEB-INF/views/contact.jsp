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
    <title>Contact Us - EstateAura</title>
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
        .navbar-brand span {
            color: #2c3e50;
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
        .navbar-toggler {
            border: none;
            padding: 0.5rem;
        }
        .navbar-toggler:focus {
            box-shadow: none;
        }
        .navbar-toggler-icon {
            background-image: none;
            position: relative;
            width: 24px;
            height: 2px;
            background-color: #2c3e50;
            display: inline-block;
            vertical-align: middle;
        }
        .navbar-toggler-icon::before,
        .navbar-toggler-icon::after {
            content: '';
            position: absolute;
            width: 24px;
            height: 2px;
            background-color: #2c3e50;
            left: 0;
            transition: all 0.3s ease;
        }
        .navbar-toggler-icon::before {
            top: -6px;
        }
        .navbar-toggler-icon::after {
            bottom: -6px;
        }
        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon {
            background-color: transparent;
        }
        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon::before {
            transform: rotate(45deg);
            top: 0;
        }
        .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon::after {
            transform: rotate(-45deg);
            bottom: 0;
        }
        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: white;
                padding: 1rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                margin-top: 1rem;
            }
            .nav-link {
                padding: 0.75rem 1rem !important;
                border-radius: 5px;
            }
            .nav-link:hover {
                background: #f8f9fa;
            }
        }
        .contact-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            text-align: center;
            color: white;
            padding: 8rem 0 4rem 0;
            margin-top: 80px;
        }
        .contact-hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        .contact-hero p {
            font-size: 1.5rem;
            opacity: 0.9;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }
        .contact-section {
            padding: 5rem 0;
            background: #f8f9fa;
        }
        .contact-info, .contact-form {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            height: 100%;
        }
        .contact-info h2, .contact-form h2 {
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }
        .contact-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .contact-item i {
            font-size: 1.5rem;
            color: #3498db;
            margin-top: 0.5rem;
        }
        .contact-item h4 {
            color: #2c3e50;
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
        }
        .contact-item p {
            color: #666;
            margin: 0;
        }
        .form-control {
            padding: 0.8rem 1.2rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        .btn-primary {
            background: #3498db;
            border: none;
            padding: 1rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .map-container {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .map-container h2 {
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 1.5rem;
        }
        .feature-card {
            padding: 2rem;
            border-radius: 15px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <%
    User user = (User) session.getAttribute("user");
    if (user == null) {
    %>
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/contact">
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
    } else {
        String userType = user.getUr().name().toLowerCase();
        if (userType.equals("user")) {
    %>
    <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />
    <%
        } else if (userType.equals("agent")) {
    %>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />
    <%
        }}
    %>

    <section class="contact-hero" data-aos="fade-up" data-aos-duration="1200">
        <div class="container" style="text-align: center;">
            <div style="font-size: 3rem; color: #f1c40f; margin-bottom: 1rem;"><i class="fas fa-envelope-open-text"></i></div>
            <h1 style="font-size: 3.5rem; font-weight: 700; color: #fff; margin-bottom: 1rem; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">Contact Us</h1>
            <p style="font-size: 1.5rem; color: #f1c40f; font-weight: 600; margin-bottom: 2.2rem; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">We're here to help you with all your real estate needs</p>
        </div>
    </section>

    <!-- Why Contact Us Section -->
    <section class="py-5" data-aos="fade-up" data-aos-delay="100">
        <div class="container">
            <div class="row text-center mb-4">
                <div class="col-12">
                    <h2 style="color: #2c3e50; font-weight: 700;">Why Contact Us?</h2>
                </div>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-md-4">
                    <div class="feature-card h-100" style="background: #e3f2fd;">
                        <i class="fas fa-bolt feature-icon" style="color: #3498db;"></i>
                        <h3>Quick Response</h3>
                        <p>We value your time and strive to respond to all inquiries as quickly as possible.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100" style="background: #e8f5e9;">
                        <i class="fas fa-user-tie feature-icon" style="color: #27ae60;"></i>
                        <h3>Expert Advice</h3>
                        <p>Our experienced team is ready to provide you with the best real estate guidance.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card h-100" style="background: #fff3e0;">
                        <i class="fas fa-heart feature-icon" style="color: #e67e22;"></i>
                        <h3>Personalized Support</h3>
                        <p>We offer tailored solutions to match your unique property needs and goals.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="contact-section">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-6" data-aos="fade-right" data-aos-delay="100">
                    <div class="contact-info" style="background: linear-gradient(135deg, #e3f2fd 0%, #f8f9fa 100%);">
                        <h2>Get in Touch</h2>
                        <p class="mb-4">We're here to help and answer any questions you might have. We look forward to hearing from you.</p>
                        <div class="contact-details">
                            <div class="contact-item">
                                <i class="fas fa-map-marker-alt" style="color: #e74c3c;"></i>
                                <div>
                                    <h4>Our Location</h4>
                                    <p>123 Vijay nagar, Indore, MP</p>
                                </div>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-phone" style="color: #27ae60;"></i>
                                <div>
                                    <h4>Phone Number</h4>
                                    <p>+91 7477081440</p>
                                </div>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-envelope" style="color: #3498db;"></i>
                                <div>
                                    <h4>Email Address</h4>
                                    <p>priyanshusharma0152@gmail.com</p>
                                </div>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-clock" style="color: #f1c40f;"></i>
                                <div>
                                    <h4>Working Hours</h4>
                                    <p>Monday - Friday: 9:00 AM - 6:00 PM</p>
                                </div>
                            </div>
                        </div>
                        <!-- Social Media Row -->
                        <div class="mt-4 text-center">
                            <a href="https://wa.me/917477081440" class="me-3" style="color: #25d366; font-size: 2rem;"><i class="fab fa-whatsapp"></i></a>
                            <a href="https://github.com/Priyanshu-10112" class="me-3" style="color: #333; font-size: 2rem;"><i class="fab fa-github"></i></a>
                            <a href="https://www.linkedin.com/in/priyanshu-sharma-13b629309/" style="color: #0a66c2; font-size: 2rem;"><i class="fab fa-linkedin"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left" data-aos-delay="200">
                    <div class="contact-form" style="background: linear-gradient(135deg, #f8f9fa 0%, #e3f2fd 100%);">
                        <h2>Send us a Message</h2>
                        <!-- Success Message Placeholder -->
                        <div id="contact-success" class="alert alert-success d-none" role="alert">
                            <i class="fas fa-check-circle me-2"></i>Your message has been sent! We'll get back to you soon.
                        </div>
                        <form action="${pageContext.request.contextPath}/contact/submit" method="POST">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="name" name="name" placeholder="Your Name" required>
                                <label for="name">Your Name</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email Address" required>
                                <label for="email">Email Address</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" id="subject" name="subject" placeholder="Subject" required>
                                <label for="subject">Subject</label>
                            </div>
                            <div class="form-floating mb-3">
                                <textarea class="form-control" id="message" name="message" placeholder="Message" style="height: 120px;" required></textarea>
                                <label for="message">Message</label>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg w-100">
                                <i class="fas fa-paper-plane me-2"></i>Send Message
                            </button>
                        </form>
                    </div>
                </div>
                <div class="col-12 mt-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="map-container" style="box-shadow: 0 8px 32px rgba(44,62,80,0.15); border: 2px solid #e3f2fd;">
                        <h2>Our Location on Map</h2>
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d117763.1726642!2d75.78226230901932!3d22.72410190642036!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3962fdc48f465641%3A0xd6f1d8687f8b918f!2sIndore%2C%20Madhya%20Pradesh!5e0!3m2!1sen!2sin!4v1700000000000!5m2!1sen!2sin"
                            width="100%" 
                            height="450" 
                            style="border:0; border-radius: 15px;"
                            allowfullscreen="" 
                            loading="lazy" 
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script>
      AOS.init({ once: true });
    </script>
</body>
</html> 