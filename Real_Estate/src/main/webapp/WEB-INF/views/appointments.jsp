<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Appointments - Real Estate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #2ecc71;
            --warning-color: #f1c40f;
            --danger-color: #e74c3c;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
            --card-shadow: 0 2px 4px rgba(0,0,0,0.1);
            --hover-shadow: 0 4px 8px rgba(0,0,0,0.15);
            --button-transition: all 0.3s ease;
            --gradient-primary: linear-gradient(135deg, #3498db, #2980b9);
            --transition: all 0.3s ease;
            --border-radius: 16px;
        }
        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 0;
        }
        .page-header {
            background: var(--gradient-primary);
            color: white;
            padding: 40px 0;
            margin-top: 80px;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: var(--card-shadow);
            border-radius: 0 0 20px 20px;
        }
        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        .page-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 600px;
            margin: 0 auto;
        }
        .container {
            padding: 0 30px;
            max-width: 1400px;
            margin: 0 auto;
        }
        .filter-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            margin-bottom: 40px;
            position: relative;
            overflow: hidden;
        }
        .filter-section h3 {
            color: var(--dark-text);
            font-size: 1.3rem;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .filter-section .form-group {
            margin-bottom: 20px;
        }
        .filter-section label {
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--dark-text);
            display: block;
        }
        .filter-section select {
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #ddd;
            width: 100%;
            transition: var(--button-transition);
            background-color: white;
            cursor: pointer;
            font-size: 1rem;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            margin: 40px 0;
        }
        .empty-state i {
            font-size: 5rem;
            color: var(--primary-color);
            margin-bottom: 20px;
            opacity: 0.8;
        }
        .empty-state h3 {
            color: var(--dark-text);
            font-size: 1.8rem;
            margin-bottom: 15px;
            font-weight: 600;
        }
        .empty-state p {
            color: var(--secondary-color);
            font-size: 1.1rem;
            margin-bottom: 30px;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
        }
        .empty-state .btn {
            padding: 12px 30px;
            font-size: 1.1rem;
            border-radius: 8px;
            transition: var(--button-transition);
            background: var(--gradient-primary);
            border: none;
            color: white;
            font-weight: 500;
        }
        .empty-state .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(52, 152, 219, 0.3);
        }
        .empty-state .btn i {
            font-size: 1.2rem;
            margin-right: 8px;
        }
        .appointment-card {
            background: white;
            border-radius: 15px;
            box-shadow: var(--card-shadow);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 20px;
            overflow: hidden;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        .appointment-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }
        .property-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .appointment-status {
            padding: 0.8rem 1.5rem;
            border-radius: 30px;
            font-size: 0.95rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            transition: var(--transition);
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-pending {
            background: linear-gradient(135deg, #f1c40f, #f39c12);
            color: #fff;
        }
        .status-confirmed {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            color: #fff;
        }
        .status-rejected {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: #fff;
        }
        .appointment-status i {
            font-size: 1rem;
        }
        .appointment-details {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        .appointment-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: var(--dark-text);
        }
        .appointment-info {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 12px;
            color: var(--secondary-color);
            font-size: 0.95rem;
        }
        .appointment-info i {
            width: 20px;
            color: var(--primary-color);
        }
        .appointment-actions {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 1rem;
            margin-top: auto;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.1);
            flex-shrink: 0;
        }
        .appointment-actions .btn {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
            flex: 1;
            min-width: 120px;
            max-width: 200px;
        }
        .appointment-actions .btn-primary {
            background: var(--primary-color);
            color: white;
            border: none;
        }
        .appointment-actions .btn-primary:hover {
            background: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.3);
        }
        .appointment-actions .btn-success {
            background: var(--success-color);
            color: white;
            border: none;
        }
        .appointment-actions .btn-success:hover {
            background: #27ae60;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3);
        }
        .appointment-actions .btn-danger {
            background: var(--danger-color);
            color: white;
            border: none;
        }
        .appointment-actions .btn-danger:hover {
            background: #c0392b;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.3);
        }
        .appointment-actions .btn i {
            font-size: 1.1rem;
        }
        .section-divider {
            border-top: 1px solid #eee;
            margin: 15px 0;
            padding-top: 15px;
        }
        .property-details {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin: 15px 0;
            transition: var(--button-transition);
            border: 1px solid #eee;
        }
        .property-details:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border-color: #ddd;
        }
        .user-details {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin: 15px 0;
            transition: var(--button-transition);
            border: 1px solid #eee;
        }
        .user-details:hover {
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border-color: #ddd;
        }
        .user-name {
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 5px;
            transition: var(--button-transition);
        }
        .user-name:hover {
            color: var(--primary-color);
        }
        .section-title {
            color: var(--dark-text);
            margin-bottom: 30px;
            font-weight: 600;
        }
        @media (max-width: 991.98px) {
            .page-title {
                font-size: 2rem;
            }
        }
        @media (max-width: 768px) {
            .page-header {
                padding: 30px 0;
                margin-top: 70px;
                margin-bottom: 30px;
            }
            .page-title {
                font-size: 1.8rem;
            }
            .container {
                padding: 0 15px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <div class="page-header" style="background: linear-gradient(90deg, #3498db 0%, #2980b9 100%); color: #fff; box-shadow: 0 2px 10px rgba(52,152,219,0.08); border-radius: 0 0 30px 30px;">
        <div class="container">
            <div class="header-wrapper">
                <div class="header-content">
                    <div class="header-left">
                        <h1 class="page-title" style="font-size:2.5rem;font-weight:800;letter-spacing:-1px;">My Appointments</h1>
                        <p class="page-subtitle" style="font-size:1.15rem;opacity:0.95;">Manage and track all your property viewing appointments in one place</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Filter Section -->
        <div class="filter-section mb-4" style="background:#fff;box-shadow:0 2px 8px rgba(52,152,219,0.07);border-radius:18px;">
            <h3 style="font-weight:700;color:#3498db;font-size:1.3rem;margin-bottom:20px;">Filter Appointments</h3>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="statusFilter">Status</label>
                        <select class="form-select" id="statusFilter">
                            <option value="all">All Status</option>
                            <option value="PENDING">Pending</option>
                            <option value="CONFIRMED">Confirmed</option>
                            <option value="REJECTED">Rejected</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="dateFilter">Date Range</label>
                        <select class="form-select" id="dateFilter">
                            <option value="all">All Dates</option>
                            <option value="today">Today</option>
                            <option value="week">This Week</option>
                            <option value="month">This Month</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="appointmentsContainer">
            <c:forEach items="${appointments}" var="appointment">
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="appointment-card" style="border-radius:18px;box-shadow:0 4px 16px rgba(52,152,219,0.09);">
                        <img src="${pageContext.request.contextPath}/images/properties/${appointment.property.image}" 
                             class="property-image" 
                             alt="${appointment.property.propertyType}">
                        <div class="appointment-details">
                            <h5 class="appointment-title" style="font-size:1.25rem;font-weight:700;color:#2c3e50;">${appointment.property.propertyType}</h5>
                            
                            <div class="property-details">
                                <div class="appointment-info">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${appointment.property.address}, ${appointment.property.city}</span>
                                </div>
                                <div class="appointment-info">
                                    <i class="fas fa-ruler-combined"></i>
                                    <span>${appointment.property.area} ${appointment.property.areaUnit}</span>
                                </div>
                            </div>

                            <div class="section-divider"></div>

                            <div class="user-details">
                                <div class="user-name">
                                    ${appointment.user.firstName} ${appointment.user.lastName}
                                </div>
                                <div class="appointment-info">
                                    <i class="fas fa-envelope"></i>
                                    <span>${appointment.user.email}</span>
                                </div>
                                <div class="appointment-info">
                                    <i class="fas fa-phone"></i>
                                    <span>${appointment.user.phoneNumber}</span>
                                </div>
                            </div>

                            <div class="section-divider"></div>
                            
                            <div class="appointment-info">
                                <i class="fas fa-calendar"></i>
                                <span>
                                    <fmt:parseDate value="${appointment.appointmentDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy"/>
                                </span>
                            </div>
                            
                            <div class="appointment-info">
                                <i class="fas fa-clock"></i>
                                <span>
                                    <fmt:formatDate value="${parsedDate}" pattern="hh:mm a"/>
                                </span>
                            </div>

                            <c:choose>
                                <c:when test="${appointment.status == 'PENDING'}">
                                    <span class="appointment-status status-pending" style="background:linear-gradient(135deg,#f1c40f,#f39c12);color:#fff;font-weight:700;">
                                        <i class="fas fa-clock"></i> Pending
                                    </span>
                                </c:when>
                                <c:when test="${appointment.status == 'CONFIRMED'}">
                                    <span class="appointment-status status-confirmed" style="background:linear-gradient(135deg,#2ecc71,#27ae60);color:#fff;font-weight:700;">
                                        <i class="fas fa-check-circle"></i> Confirmed
                                    </span>
                                </c:when>
                                <c:when test="${appointment.status == 'REJECTED'}">
                                    <span class="appointment-status status-rejected" style="background:linear-gradient(135deg,#e74c3c,#c0392b);color:#fff;font-weight:700;">
                                        <i class="fas fa-times-circle"></i> Rejected
                                    </span>
                                </c:when>
                            </c:choose>

                            <div class="appointment-actions">
                                <c:if test="${appointment.status == 'PENDING'}">
                                    <c:if test="${sessionScope.user.ur == 'AGENT'}">
                                        <button class="btn btn-success" 
                                                onclick="approveAppointment('${appointment.id}')">
                                            <i class="fas fa-check"></i> Approve
                                        </button>
                                        <button class="btn btn-danger" 
                                                onclick="rejectAppointment('${appointment.id}')">
                                            <i class="fas fa-times"></i> Reject
                                        </button>
                                    </c:if>
                                    <c:if test="${sessionScope.user.ur == 'USER'}">
                                        <button class="btn btn-danger" 
                                                onclick="cancelAppointment('${appointment.id}')">
                                            <i class="fas fa-times"></i> Cancel
                                        </button>
                                    </c:if>
                                </c:if>
                                <c:if test="${appointment.status != 'PENDING'}">
                                    <button class="btn btn-danger" 
                                            onclick="deleteAppointment('${appointment.id}')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/user/property-details/${appointment.property.id}" 
                                   class="btn btn-primary">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty appointments}">
                <div class="col-12">
                    <div class="empty-state" style="background:#fff;box-shadow:0 2px 8px rgba(52,152,219,0.07);border-radius:18px;">
                        <i class="fas fa-calendar-times"></i>
                        <h3 style="color:#2c3e50;font-weight:700;">No Appointments Found</h3>
                        <p style="color:#2c3e50;">You haven't scheduled any property viewings yet. Start exploring available properties and schedule your first viewing.</p>
                        <a href="${pageContext.request.contextPath}/agent/manage-properties" class="btn" style="background:linear-gradient(135deg,#3498db,#2980b9);color:#fff;font-weight:600;">
                            <i class="fas fa-search"></i> Browse Properties
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        function cancelAppointment(appointmentId) {
            if (confirm('Are you sure you want to cancel this appointment?')) {
                $.ajax({
                    url: '/api/appointments/' + appointmentId + '/cancel',
                    type: 'POST',
                    success: function(response) {
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to cancel appointment. Please try again.');
                    }
                });
            }
        }

        function approveAppointment(appointmentId) {
            if (confirm('Are you sure you want to approve this appointment?')) {
                $.ajax({
                    url: '/api/appointments/' + appointmentId + '/approve',
                    type: 'POST',
                    success: function(response) {
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to approve appointment. Please try again.');
                    }
                });
            }
        }

        function rejectAppointment(appointmentId) {
            if (confirm('Are you sure you want to reject this appointment?')) {
                $.ajax({
                    url: '/api/appointments/' + appointmentId + '/reject',
                    type: 'POST',
                    success: function(response) {
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        alert('Failed to reject appointment. Please try again.');
                    }
                });
            }
        }

        function deleteAppointment(appointmentId) {
            if (confirm('Are you sure you want to delete this appointment? This action cannot be undone.')) {
                $.ajax({
                    url: '/api/appointments/' + appointmentId + '/delete',
                    type: 'POST',
                    success: function(response) {
                        location.reload();
                    },
                    error: function(xhr, status, error) {
                        let errorMsg = 'Failed to delete appointment. Please try again.';
                        if (xhr.responseJSON && xhr.responseJSON.error) {
                            errorMsg = xhr.responseJSON.error;
                        } else if (xhr.responseText) {
                            try {
                                const resp = JSON.parse(xhr.responseText);
                                if (resp.error) errorMsg = resp.error;
                            } catch (e) {}
                        }
                        alert(errorMsg);
                    }
                });
            }
        }

        // Filter functionality
        $('#statusFilter, #dateFilter').change(function() {
            filterAppointments();
        });

        function filterAppointments() {
            const status = $('#statusFilter').val();
            const date = $('#dateFilter').val();
            
            $.ajax({
                url: '/api/appointments/filter',
                type: 'GET',
                data: {
                    status: status,
                    date: date
                },
                success: function(response) {
                    // Update the appointments container with filtered results
                    updateAppointmentsContainer(response);
                },
                error: function(xhr, status, error) {
                    console.error('Error filtering appointments:', error);
                }
            });
        }

        function updateAppointmentsContainer(appointments) {
            const container = $('#appointmentsContainer');
            container.empty();

            if (appointments.length === 0) {
                container.html(`
                    <div class="col-12">
                        <div class="empty-state">
                            <i class="fas fa-calendar-times"></i>
                            <h3>No Appointments Found</h3>
                            <p>No appointments match your selected filters.</p>
                        </div>
                    </div>
                `);
                return;
            }

            appointments.forEach(appointment => {
                const card = createAppointmentCard(appointment);
                container.append(card);
            });
        }

        function createAppointmentCard(appointment) {
            const cancelButton = appointment.status === 'PENDING' 
                ? `<button class="btn btn-danger" onclick="cancelAppointment('${appointment.id}')">
                    <i class="fas fa-times"></i> Cancel
                   </button>`
                : '';
            const deleteButton = (appointment.status !== 'PENDING')
                ? `<button class="btn btn-danger" onclick="deleteAppointment('${appointment.id}')">
                    <i class="fas fa-trash"></i> Delete
                   </button>`
                : '';
            const formattedDate = new Date(appointment.appointmentDate).toLocaleDateString('en-US', {
                month: 'short',
                day: 'numeric',
                year: 'numeric'
            });
            const formattedTime = new Date(appointment.appointmentDate).toLocaleTimeString('en-US', {
                hour: 'numeric',
                minute: 'numeric',
                hour12: true
            });
            return `
                <div class="col-md-6 col-lg-4 mb-4">
                    <div class="appointment-card">
                        <img src="${pageContext.request.contextPath}/images/properties/${appointment.property.image}" 
                             class="property-image" 
                             alt="${appointment.property.propertyType}">
                        <div class="appointment-details">
                            <h5 class="appointment-title">${appointment.property.propertyType}</h5>
                            
                            <div class="property-details">
                                <div class="appointment-info">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${appointment.property.address}, ${appointment.property.city}</span>
                                </div>
                                <div class="appointment-info">
                                    <i class="fas fa-ruler-combined"></i>
                                    <span>${appointment.property.area} ${appointment.property.areaUnit}</span>
                                </div>
                            </div>

                            <div class="section-divider"></div>

                            <div class="user-details">
                                <div class="user-name">
                                    ${appointment.user.firstName} ${appointment.user.lastName}
                                </div>
                                <div class="appointment-info">
                                    <i class="fas fa-envelope"></i>
                                    <span>${appointment.user.email}</span>
                                </div>
                                <div class="appointment-info">
                                    <i class="fas fa-phone"></i>
                                    <span>${appointment.user.phoneNumber}</span>
                                </div>
                            </div>

                            <div class="section-divider"></div>
                            
                            <div class="appointment-info">
                                <i class="fas fa-calendar"></i>
                                <span>${formattedDate}</span>
                            </div>
                            
                            <div class="appointment-info">
                                <i class="fas fa-clock"></i>
                                <span>${formattedTime}</span>
                            </div>

                            <span class="appointment-status status-${appointment.status.toLowerCase()}">
                                ${appointment.status}
                            </span>

                            <div class="appointment-actions">
                                ${cancelButton}
                                ${deleteButton}
                                <a href="${pageContext.request.contextPath}/user/property-details/${appointment.property.id}" 
                                   class="btn btn-primary">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            `;
        }
    </script>
</body>
</html>