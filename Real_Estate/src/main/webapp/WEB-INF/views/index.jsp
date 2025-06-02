<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EstateAura - Find Your Dream Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        .navbar {
            background: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 1rem 0;
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
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('https://images.unsplash.com/photo-1560518883-ce09059eeffa?ixlib=rb-4.0.3') center/cover;
            min-height: 80vh;
            display: flex;
            align-items: center;
            position: relative;
        }
        .hero-content {
            text-align: center;
            color: white;
            padding: 2rem;
            max-width: 900px;
            margin: 0 auto;
        }
        .hero-title {
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            line-height: 1.2;
        }
        .hero-subtitle {
            font-size: 1.8rem;
            margin-bottom: 2.5rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
            opacity: 0.9;
        }
        .hero-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
            margin-bottom: 3rem;
        }
        .hero-button {
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-size: 1.1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.8rem;
        }
        .hero-button-primary {
            background: #3498db;
            color: white;
            border: none;
        }
        .hero-button-primary:hover {
            background: #2980b9;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .hero-button-secondary {
            background: transparent;
            color: white;
            border: 2px solid white;
        }
        .hero-button-secondary:hover {
            background: white;
            color: #2c3e50;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        .hero-highlights {
            display: flex;
            justify-content: center;
            gap: 3rem;
            margin-top: 2rem;
        }
        .highlight-item {
            text-align: center;
            color: white;
        }
        .highlight-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        .highlight-label {
            font-size: 1.1rem;
            opacity: 0.9;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
        }
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            .hero-subtitle {
                font-size: 1.3rem;
            }
            .hero-buttons {
                flex-direction: column;
                gap: 1rem;
            }
            .hero-highlights {
                flex-wrap: wrap;
                gap: 2rem;
            }
            .highlight-item {
                flex: 1 1 40%;
            }
        }
        .property-card {
            border: none;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            background: white;
            margin-bottom: 2rem;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .property-card:hover {
            transform: translateY(-10px);
        }
        .property-image {
            position: relative;
            height: 200px;
            overflow: hidden;
        }
        .property-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .property-card:hover .property-image img {
            transform: scale(1.1);
        }
        .property-price {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: rgba(52, 152, 219, 0.95);
            color: white;
            padding: 8px 15px;
            border-radius: 6px;
            font-weight: 600;
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255,255,255,0.1);
            transition: all 0.3s ease;
            line-height: 1.2;
        }
        .property-card:hover .property-price {
            transform: translateY(-5px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.3);
        }
        .property-info {
            padding: 1.2rem;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .property-info h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #333;
            line-height: 1.4;
        }
        .property-location {
            color: #666;
            margin-bottom: 0.8rem;
            font-size: 0.95rem;
        }
        .property-features {
            display: flex;
            gap: 1rem;
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        .property-features span {
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        .property-features i {
            color: #3498db;
        }
        .mt-3 {
            margin-top: auto !important;
        }
        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }
        .section-title h2 {
            font-size: 2.5rem;
            color: #333;
            margin-bottom: 1rem;
        }
        .cta-section {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }
        .btn-cta {
            background: #e74c3c;
            color: white;
            padding: 12px 30px;
            border-radius: 30px;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-cta:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
        .btn-cta-outline {
            border: 2px solid white;
            color: white;
            padding: 12px 30px;
            border-radius: 30px;
            transition: all 0.3s ease;
        }
        .btn-cta-outline:hover {
            background: white;
            color: #2c3e50;
        }
        .features-section {
            padding: 5rem 0;
            background: #f8f9fa;
        }
        .feature-card {
            text-align: center;
            padding: 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-10px);
        }
        .feature-icon {
            font-size: 3rem;
            color: #3498db;
            margin-bottom: 1.5rem;
        }
        .testimonials-section {
            padding: 5rem 0;
        }
        .testimonial-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        .testimonial-text {
            font-style: italic;
            margin-bottom: 1.5rem;
        }
        .testimonial-author {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .testimonial-author img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }
        .stats-section {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 4rem 0;
        }
        .stat-item {
            text-align: center;
            padding: 2rem;
        }
        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        .stat-label {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        .hero-search {
            max-width: 800px;
            margin: 2rem auto;
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .search-title {
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        .search-form {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .search-group {
            flex: 1;
            min-width: 200px;
        }
        .search-group label {
            display: block;
            color: #2c3e50;
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }
        .search-input {
            width: 100%;
            padding: 0.8rem 1.2rem;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
        }
        .search-input:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            outline: none;
        }
        .search-input::placeholder {
            color: #adb5bd;
        }
        .search-button {
            background: #3498db;
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1.8rem;
        }
        .search-button:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .search-button i {
            font-size: 1.1rem;
        }
        .search-options {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
            flex-wrap: wrap;
        }
        .search-option {
            background: #f8f9fa;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            color: #2c3e50;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid #e9ecef;
        }
        .search-option:hover {
            background: #e9ecef;
            color: #2c3e50;
        }
        .search-option.active {
            background: #3498db;
            color: white;
            border-color: #3498db;
        }
        @media (max-width: 768px) {
            .hero-search {
                margin: 2rem 1rem;
                padding: 1.5rem;
            }
            .search-form {
                flex-direction: column;
            }
            .search-button {
                width: 100%;
                justify-content: center;
            }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/">
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/register">
                            <i class="fas fa-user-plus"></i>
                            <span>Register</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title">Discover Your Perfect Home in India's Finest Locations</h1>
                <p class="hero-subtitle">Experience luxury living with our exclusive collection of premium properties</p>
                <div class="hero-buttons">
                    <a href="${pageContext.request.contextPath}/login" class="hero-button hero-button-primary">
                        <i class="fas fa-building"></i>
                        Explore Properties
                    </a>
                    <a href="${pageContext.request.contextPath}/contact" class="hero-button hero-button-secondary">
                        <i class="fas fa-phone-alt"></i>
                        Contact Us
                    </a>
                </div>
                <div class="hero-highlights">
                    <div class="highlight-item">
                        <div class="highlight-number">500+</div>
                        <div class="highlight-label">Premium Properties</div>
                    </div>
                    <div class="highlight-item">
                        <div class="highlight-number">15+</div>
                        <div class="highlight-label">Cities</div>
                    </div>
                    <div class="highlight-item">
                        <div class="highlight-number">1000+</div>
                        <div class="highlight-label">Happy Clients</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="features-section">
        <div class="container">
            <div class="section-title">
                <h2>Why Choose Us</h2>
                <p>Experience the best in real estate services</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <h3>Premium Properties</h3>
                        <p>Access to exclusive luxury properties in prime locations</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <h3>Expert Guidance</h3>
                        <p>Professional assistance throughout your property journey</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3>Secure Transactions</h3>
                        <p>Safe and transparent property transactions</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="featured-properties">
        <div class="container">
            <div class="section-title">
                <h2>Premium Properties</h2>
                <p>Explore our exclusive collection of luxury homes and apartments</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="property-card">
                        <div class="property-image">
                            <img src="https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3" alt="Modern Villa">
                            <div class="property-price">₹2.5 Cr</div>
                        </div>
                        <div class="property-info">
                            <h3>Luxury Villa with Infinity Pool</h3>
                            <p class="property-location"><i class="fas fa-map-marker-alt me-2"></i>Bandra West, Mumbai</p>
                            <div class="property-features">
                                <span><i class="fas fa-bed me-1"></i>5 Beds</span>
                                <span><i class="fas fa-bath me-1"></i>4 Baths</span>
                                <span><i class="fas fa-ruler-combined me-1"></i>6,500 sqft</span>
                            </div>
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="property-card">
                        <div class="property-image">
                            <img src="https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3" alt="Luxury Apartment">
                            <div class="property-price">₹1.85 Cr</div>
                        </div>
                        <div class="property-info">
                            <h3>Skyline Penthouse</h3>
                            <p class="property-location"><i class="fas fa-map-marker-alt me-2"></i>Koramangala, Bangalore</p>
                            <div class="property-features">
                                <span><i class="fas fa-bed me-1"></i>4 Beds</span>
                                <span><i class="fas fa-bath me-1"></i>3.5 Baths</span>
                                <span><i class="fas fa-ruler-combined me-1"></i>4,200 sqft</span>
                            </div>
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="property-card">
                        <div class="property-image">
                            <img src="https://images.unsplash.com/photo-1613490493576-7fde63acd811?ixlib=rb-4.0.3" alt="Waterfront Estate">
                            <div class="property-price">₹3.5 Cr</div>
                        </div>
                        <div class="property-info">
                            <h3>Seaside Mansion</h3>
                            <p class="property-location"><i class="fas fa-map-marker-alt me-2"></i>Juhu Beach, Mumbai</p>
                            <div class="property-features">
                                <span><i class="fas fa-bed me-1"></i>6 Beds</span>
                                <span><i class="fas fa-bath me-1"></i>5.5 Baths</span>
                                <span><i class="fas fa-ruler-combined me-1"></i>8,000 sqft</span>
                            </div>
                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-primary w-100">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">500+</div>
                        <div class="stat-label">Properties Sold</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">1000+</div>
                        <div class="stat-label">Happy Clients</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">15+</div>
                        <div class="stat-label">Years Experience</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stat-item">
                        <div class="stat-number">50+</div>
                        <div class="stat-label">Cities Covered</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials-section">
        <div class="container">
            <div class="section-title">
                <h2>What Our Clients Say</h2>
                <p>Real experiences from our satisfied customers</p>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="testimonial-text">
                            "Found my dream home through EstateAura. The team was professional and made the process smooth."
                        </div>
                        <div class="testimonial-author">
                            <div>
                                <h4>Rajesh Kumar</h4>
                                <p>Mumbai</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="testimonial-text">
                            "Excellent service and great property options. Highly recommended for luxury real estate."
                        </div>
                        <div class="testimonial-author">
                            <div>
                                <h4>Priya Sharma</h4>
                                <p>Delhi</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="testimonial-card">
                        <div class="testimonial-text">
                            "The team went above and beyond to help me find the perfect investment property."
                        </div>
                        <div class="testimonial-author">
                            <div>
                                <h4>Amit Patel</h4>
                                <p>Bangalore</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="cta-section">
        <div class="container">
            <h2 class="cta-title">Start Your Journey to Luxury Living</h2>
            <p class="cta-description">Join our community of discerning homeowners and find your perfect property</p>
            <div class="cta-buttons">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-cta me-3">
                    <i class="fas fa-sign-in-alt me-2"></i>Get Started
                </a>
                <a href="${pageContext.request.contextPath}/contact" class="btn btn-cta-outline">
                    <i class="fas fa-envelope me-2"></i>Contact Us
                </a>
            </div>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
</body>
</html> 