<!-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Favorites - EstateAura</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        .property-card {
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(44,62,80,0.10);
            overflow: hidden;
            margin-bottom: 2rem;
            background: #fff;
            transition: box-shadow 0.2s;
        }
        .property-card:hover {
            box-shadow: 0 6px 24px rgba(44,62,80,0.15);
        }
        .property-img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .property-info {
            padding: 1rem;
        }
        .property-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #3498db;
        }
        .property-address {
            color: #7f8c8d;
            font-size: 0.95rem;
        }
        .property-price {
            color: #2ecc71;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .remove-btn {
            background: #e74c3c;
            color: #fff;
            border: none;
            border-radius: 6px;
            padding: 0.5rem 1rem;
            transition: background 0.2s;
        }
        .remove-btn:hover {
            background: #c0392b;
        }
        .empty-message {
            text-align: center;
            color: #7f8c8d;
            margin-top: 3rem;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <c:choose>
        <c:when test="${empty sessionScope.user}">
            <c:redirect url="${pageContext.request.contextPath}/login" />
        </c:when>
        <c:otherwise>
            <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />
            <main class="container py-4">
                <h2 class="fw-bold mb-4 text-center">My Favorite Properties</h2>
                <c:choose>
                    <c:when test="${empty favoriteProperties}">
                        <div class="empty-message">
                            <i class="fas fa-heart-broken fa-2x mb-3"></i><br/>
                            You haven't added any properties to your favorites yet.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="property" items="${favoriteProperties}">
                                <div class="col-md-6 col-lg-4">
                                    <div class="property-card mb-4">
                                        <img class="property-img" src="${property.imageUrl}" alt="Property Image" onerror="this.src='${pageContext.request.contextPath}/images/default-property.html'" />
                                        <div class="property-info">
                                            <div class="property-title">${property.title}</div>
                                            <div class="property-address mb-2">
                                                <i class="fas fa-map-marker-alt"></i> ${property.address}
                                            </div>
                                            <div class="property-price mb-2">
                                                <fmt:formatNumber value="${property.price}" type="currency" currencySymbol="$"/>
                                            </div>
                                            <form method="post" action="${pageContext.request.contextPath}/user/remove-favorite" style="display:inline;">
                                                <input type="hidden" name="propertyId" value="${property.id}" />
                                                <button type="submit" class="remove-btn"><i class="fas fa-trash"></i> Remove</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
            <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        </c:otherwise>
    </c:choose>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/4b8b59b5b2.js" crossorigin="anonymous"></script>
</body>
</html>  -->