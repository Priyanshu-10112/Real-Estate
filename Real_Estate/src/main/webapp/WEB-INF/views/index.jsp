<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LuxuryEstate - Find Your Dream Home</title>
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
                <h1 class="hero-title">Find Your Dream Home</h1>
                <p class="hero-subtitle">Discover the perfect property that matches your lifestyle and preferences</p>
            </div>
        </div>
    </section>

    <section class="featured-properties">
        <div class="container">
            <div class="section-title">
                <h2>Featured Properties</h2>
                <p>Explore our handpicked selection of premium properties</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="property-card">
                        <div class="property-image">
                            <img src="https://images.unsplash.com/photo-1613977257363-707ba9348227?ixlib=rb-4.0.3" alt="Modern Villa">
                            <div class="property-price">₹1,250,000</div>
                        </div>
                        <div class="property-info">
                            <h3>Modern Villa with Pool</h3>
                            <p class="property-location"><i class="fas fa-map-marker-alt me-2"></i>Beverly Hills, CA</p>
                            <div class="property-features">
                                <span><i class="fas fa-bed me-1"></i>4 Beds</span>
                                <span><i class="fas fa-bath me-1"></i>3 Baths</span>
                                <span><i class="fas fa-ruler-combined me-1"></i>3,500 sqft</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="property-card">
                        <div class="property-image">
                            <img src="https://images.unsplash.com/photo-1512917774080-9991f1c4c750?ixlib=rb-4.0.3" alt="Luxury Apartment">
                            <div class="property-price">₹850,000</div>
                        </div>
                        <div class="property-info">
                            <h3>Downtown Penthouse</h3>
                            <p class="property-location"><i class="fas fa-map-marker-alt me-2"></i>Manhattan, NY</p>
                            <div class="property-features">
                                <span><i class="fas fa-bed me-1"></i>3 Beds</span>
                                <span><i class="fas fa-bath me-1"></i>2 Baths</span>
                                <span><i class="fas fa-ruler-combined me-1"></i>2,200 sqft</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="property-card">
                        <div class="property-image">
                            <img src="https://images.unsplash.com/photo-1613490493576-7fde63acd811?ixlib=rb-4.0.3" alt="Waterfront Estate">
                            <div class="property-price">₹2,100,000</div>
                        </div>
                        <div class="property-info">
                            <h3>Waterfront Estate</h3>
                            <p class="property-location"><i class="fas fa-map-marker-alt me-2"></i>Miami Beach, FL</p>
                            <div class="property-features">
                                <span><i class="fas fa-bed me-1"></i>5 Beds</span>
                                <span><i class="fas fa-bath me-1"></i>4.5 Baths</span>
                                <span><i class="fas fa-ruler-combined me-1"></i>4,800 sqft</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="cta-section">
        <div class="container">
            <h2 class="cta-title">Ready to Find Your Dream Home?</h2>
            <p class="cta-description">Join thousands of satisfied customers who found their perfect property with us</p>
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