<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Properties - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        .properties-container {
            padding: 2rem;
            min-height: calc(100vh - 80px);
        }

        .filter-section {
            background: var(--card-bg);
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
        }

        .property-card {
            background: var(--card-bg);
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            height: 100%;
            border: 1px solid rgba(0,0,0,0.1);
        }

        .property-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
            border-color: var(--secondary-color);
        }

        .property-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 15px 15px 0 0;
        }

        .property-details {
            padding: 1.5rem;
        }

        .property-price {
            color: var(--secondary-color);
            font-size: 1.25rem;
            font-weight: 600;
        }

        .property-location {
            color: var(--text-color);
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        .property-features {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-color);
            font-size: 0.9rem;
        }

        .feature i {
            color: var(--secondary-color);
        }

        .btn-view {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 500;
            width: 100%;
            color: white;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-view:hover {
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
            color: white;
            transform: translateY(-1px);
        }

        .search-box {
            position: relative;
        }

        .search-box input {
            padding-right: 3rem;
        }

        .search-box i {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary-color);
        }
    </style>
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

    <div class="properties-container">
        <div class="container">
            <div class="filter-section">
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="search-box">
                            <input type="text" class="form-control" placeholder="Search properties...">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select">
                            <option value="">Property Type</option>
                            <option value="house">House</option>
                            <option value="apartment">Apartment</option>
                            <option value="villa">Villa</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select">
                            <option value="">Price Range</option>
                            <option value="0-100000">$0 - $100,000</option>
                            <option value="100000-300000">$100,000 - $300,000</option>
                            <option value="300000-500000">$300,000 - $500,000</option>
                            <option value="500000+">$500,000+</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button class="btn btn-primary w-100">Filter</button>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <c:forEach items="${properties}" var="property">
                    <div class="col-md-4">
                        <div class="property-card">
                            <img src="${property.imageUrl}" alt="${property.title}" class="property-image">
                            <div class="property-details">
                                <h3 class="property-title">${property.title}</h3>
                                <p class="property-price">$${property.price}</p>
                                <p class="property-location">
                                    <i class="fas fa-map-marker-alt me-1"></i>${property.location}
                                </p>
                                <div class="property-features">
                                    <span class="feature">
                                        <i class="fas fa-bed"></i>${property.bedrooms} Beds
                                    </span>
                                    <span class="feature">
                                        <i class="fas fa-bath"></i>${property.bathrooms} Baths
                                    </span>
                                    <span class="feature">
                                        <i class="fas fa-ruler-combined"></i>${property.area} sqft
                                    </span>
                                </div>
                                <a href="${pageContext.request.contextPath}/property/${property.id}" class="btn-view">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
</body>
</html> 