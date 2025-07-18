<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="com.example.Real_Estate.entity.UserRole" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - EstateAura</title>
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
        .about-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            text-align: center;
            color: white;
            padding: 8rem 0 4rem 0;
            margin-top: 80px;
        }
        .about-hero h1 {
            font-size: 3.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
        }
        .about-hero p {
            font-size: 1.5rem;
            opacity: 0.9;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
        }
        .about-section {
            padding: 5rem 0;
            background: #f8f9fa;
        }
        .about-content {
            padding: 2rem;
        }
        .about-content h2 {
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
        }
        .about-content p {
            color: #666;
            font-size: 1.1rem;
            line-height: 1.8;
            margin-bottom: 1.5rem;
        }
        .about-image img {
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
        }
        .about-image img:hover {
            transform: scale(1.02);
        }
        .feature-card {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
            height: 100%;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .feature-icon {
            font-size: 3rem;
            color: #3498db;
            margin-bottom: 1.5rem;
        }
        .feature-card h3 {
            color: #2c3e50;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }
        .feature-card p {
            color: #666;
            font-size: 1rem;
            line-height: 1.6;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/about">
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
        }
    }
    %>

    <section class="about-hero" data-aos="fade-up" data-aos-duration="1200">
        <div class="container" style="text-align: center;">
            <h1 style="font-size: 3.5rem; font-weight: 700; color: #fff; margin-bottom: 1rem; text-shadow: 2px 2px 4px rgba(0,0,0,0.5);">About EstateAura</h1>
            <p style="font-size: 1.5rem; color: #f1c40f; font-weight: 600; margin-bottom: 2.2rem; text-shadow: 1px 1px 2px rgba(0,0,0,0.5);">Your Trusted Partner in Luxury Real Estate</p>
        </div>
    </section>

    <section class="about-section">
        <div class="container">
            <div class="row align-items-center mb-5">
                <div class="col-lg-6" data-aos="fade-right" data-aos-delay="100">
                    <div class="about-content">
                        <h2>Our Story</h2>
                        <p>Founded in 2010, EstateAura has been at the forefront of luxury real estate, helping clients find their dream properties across the most prestigious locations. Our commitment to excellence and personalized service has made us a trusted name in the industry.</p>
                        <p>We believe that finding the perfect property is more than just a transaction – it's about creating lasting relationships and understanding our clients' unique needs and aspirations.</p>
                    </div>
                </div>
                <div class="col-lg-6" data-aos="fade-left" data-aos-delay="200">
                    <div class="about-image">
                        <img src="https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3" alt="Luxury Estate" class="img-fluid rounded">
                    </div>
                </div>
            </div>

            <!-- Mission & Vision Section -->
            <div class="row mb-5" data-aos="fade-up" data-aos-delay="100">
                <div class="col-12 text-center mb-4">
                    <h2>Our Mission & Vision</h2>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-bullseye feature-icon"></i>
                        <h3>Our Mission</h3>
                        <p>To empower our clients to achieve their real estate dreams by providing unparalleled service, expert guidance, and a seamless experience from start to finish.</p>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-eye feature-icon"></i>
                        <h3>Our Vision</h3>
                        <p>To be the most trusted and innovative real estate partner, setting new standards in luxury living and client satisfaction across India and beyond.</p>
                    </div>
                </div>
            </div>

            <!-- What Sets Us Apart -->
            <div class="row mb-5" data-aos="zoom-in" data-aos-delay="100">
                <div class="col-12">
                    <div style="background: linear-gradient(90deg, #3498db 0%, #2c3e50 100%); color: #fff; border-radius: 18px; padding: 2.5rem 2rem; box-shadow: 0 8px 32px rgba(44,62,80,0.15); text-align: center;">
                        <h2 style="font-weight: 700; margin-bottom: 1rem;">What Sets Us Apart</h2>
                        <p style="font-size: 1.2rem; max-width: 800px; margin: 0 auto;">At EstateAura, we blend technology, market expertise, and a personal touch to deliver a real estate experience that is truly exceptional. Our commitment to integrity, innovation, and client success is at the heart of everything we do.</p>
                    </div>
                </div>
            </div>

            <!-- Our Values Section -->
            <div class="row mb-5" data-aos="fade-up" data-aos-delay="100">
                <div class="col-12 text-center mb-4">
                    <h2>Our Values</h2>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-gem feature-icon"></i>
                        <h3>Integrity</h3>
                        <p>We uphold the highest standards of honesty and transparency in every interaction.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-lightbulb feature-icon"></i>
                        <h3>Innovation</h3>
                        <p>We embrace new ideas and technologies to deliver the best results for our clients.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="feature-card h-100">
                        <i class="fas fa-trophy feature-icon"></i>
                        <h3>Excellence</h3>
                        <p>We strive for excellence in every aspect of our business, from service to results.</p>
                    </div>
                </div>
            </div>

            <!-- Testimonial Section -->
            <div class="row mb-5" data-aos="fade-up" data-aos-delay="100">
                <div class="col-12 text-center">
                    <blockquote style="font-size: 1.3rem; color: #2c3e50; font-style: italic; background: #e9ecef; border-radius: 12px; padding: 2rem 1.5rem; max-width: 700px; margin: 0 auto; box-shadow: 0 2px 8px rgba(0,0,0,0.05);">
                        "EstateAura made my home buying journey effortless and enjoyable. Their team truly cares about their clients!"
                        <footer class="blockquote-footer mt-3" style="color: #888;">— Priyanshu Sharma,Indore</footer>
                    </blockquote>
                </div>
            </div>

            <!-- Existing Why Choose Us Section (with AOS) -->
            <div class="row mb-5" data-aos="fade-up" data-aos-delay="100">
                <div class="col-12 text-center">
                    <h2 class="mb-4">Why Choose Us</h2>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-medal feature-icon"></i>
                        <h3>Expertise</h3>
                        <p>Our team of experienced agents brings years of market knowledge and negotiation skills to every transaction.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-handshake feature-icon"></i>
                        <h3>Trust</h3>
                        <p>We build lasting relationships with our clients based on transparency, integrity, and exceptional service.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <i class="fas fa-chart-line feature-icon"></i>
                        <h3>Results</h3>
                        <p>Our track record of successful transactions and satisfied clients speaks to our commitment to excellence.</p>
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