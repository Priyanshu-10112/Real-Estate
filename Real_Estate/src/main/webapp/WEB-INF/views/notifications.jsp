<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="com.example.Real_Estate.entity.Appointment" %>
<%@ page import="com.example.Real_Estate.entity.AppointmentStatus" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications - EstateAura</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --accent-color: #e74c3c;
            --success-color: #27ae60;
            --warning-color: #f39c12;
            --light-bg: #f8f9fa;
            --dark-text: #2c3e50;
            --light-text: #ffffff;
            --card-shadow: 0 10px 20px rgba(0,0,0,0.1);
            --hover-shadow: 0 15px 30px rgba(0,0,0,0.15);
            --transition: all 0.3s ease;
            --gradient-primary: linear-gradient(135deg, #3498db, #2980b9);
            --gradient-success: linear-gradient(135deg, #27ae60, #229954);
            --gradient-warning: linear-gradient(135deg, #f39c12, #e67e22);
            --gradient-danger: linear-gradient(135deg, #e74c3c, #c0392b);
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            padding-top: 80px;
            margin: 0;
        }

        .notifications-header {
            background: var(--gradient-primary);
            color: white;
            padding: 3rem 0;
            margin-bottom: 3rem;
            box-shadow: var(--card-shadow);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .header-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .header-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin: 0.5rem 0 0 0;
        }

        .notification-stats {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.2);
            padding: 0.8rem 1.5rem;
            border-radius: 50px;
            backdrop-filter: blur(5px);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 600;
        }

        .stat-item i {
            font-size: 1.2rem;
        }

        .notifications-container {
            display: flex;
            flex-direction: column;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .notification-card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 2.5rem;
            transition: var(--transition);
            border-left: 5px solid var(--primary-color);
            position: relative;
            overflow: hidden;
            margin: 0;
        }

        .notification-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
            opacity: 0;
            transition: var(--transition);
        }

        .notification-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .notification-card:hover::before {
            opacity: 1;
        }

        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            gap: 1rem;
        }

        .notification-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--dark-text);
            margin: 0;
            flex: 1;
        }

        .notification-status {
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            white-space: nowrap;
        }

        .status-pending {
            background: var(--gradient-warning);
            color: white;
        }

        .status-confirmed {
            background: var(--gradient-success);
            color: white;
        }

        .status-rejected {
            background: var(--gradient-danger);
            color: white;
        }

        .status-completed {
            background: #95a5a6;
            color: white;
        }

        .notification-content {
            display: grid;
            grid-template-columns: 1fr auto;
            gap: 2rem;
            align-items: start;
        }

        .notification-details {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .detail-row {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.8rem;
            background: var(--light-bg);
            border-radius: 12px;
            transition: var(--transition);
        }

        .detail-row:hover {
            background: var(--primary-color);
            color: white;
        }

        .detail-row:hover .detail-icon {
            color: white;
        }

        .detail-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 1.1rem;
            transition: var(--transition);
            flex-shrink: 0;
        }

        .detail-content {
            flex: 1;
        }

        .detail-label {
            font-size: 0.9rem;
            color: var(--secondary-color);
            margin-bottom: 0.2rem;
            font-weight: 500;
        }

        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--dark-text);
        }

        .detail-row:hover .detail-label,
        .detail-row:hover .detail-value {
            color: white;
        }

        .notification-actions {
            display: flex;
            flex-direction: column;
            gap: 1rem;
            min-width: 200px;
        }

        .action-button {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
            color: white;
        }

        .btn-danger {
            background: var(--gradient-danger);
            color: white;
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
            color: white;
        }

        .btn-secondary {
            background: #95a5a6;
            color: white;
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
            color: white;
        }

        .btn-outline-danger {
            background: transparent;
            color: var(--accent-color);
            border: 2px solid var(--accent-color);
        }

        .btn-outline-danger:hover {
            background: var(--gradient-danger);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
            border-color: transparent;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
        }

        .empty-icon {
            width: 100px;
            height: 100px;
            background: var(--light-bg);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 2rem;
            color: var(--secondary-color);
            font-size: 3rem;
        }

        .empty-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 1rem;
        }

        .empty-text {
            color: var(--secondary-color);
            margin-bottom: 2rem;
        }

        .filter-section {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .filter-row {
            display: flex;
            gap: 1.5rem;
            align-items: end;
            flex-wrap: wrap;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            flex: 1;
            min-width: 200px;
        }

        .filter-label {
            font-weight: 600;
            color: var(--dark-text);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .filter-select {
            padding: 0.75rem 1rem;
            border: 2px solid var(--light-bg);
            border-radius: 12px;
            background: white;
            color: var(--dark-text);
            font-weight: 500;
            transition: var(--transition);
            font-size: 0.95rem;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }

        .filter-button {
            padding: 0.75rem 1.5rem;
            background: var(--gradient-primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.95rem;
            white-space: nowrap;
        }

        .filter-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
        }

        @media (max-width: 991.98px) {
            .notification-content {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .notification-actions {
                min-width: auto;
            }

            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 1.5rem;
            }

            .notification-stats {
                width: 100%;
                justify-content: flex-start;
            }
            
            .filter-row {
                flex-direction: column;
                align-items: stretch;
                gap: 1rem;
            }
            
            .filter-group {
                min-width: auto;
            }
        }

        @media (max-width: 768px) {
            .header-title {
                font-size: 2rem;
            }
            
            .notifications-header {
                padding: 2rem 0;
                margin-bottom: 2rem;
            }

            .notification-card {
                padding: 1.5rem;
            }

            .notification-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 1rem;
            }

            .detail-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }

            .detail-icon {
                align-self: flex-start;
            }

            .filter-section {
                padding: 1.5rem;
            }
            
            .container {
                padding: 0 0.75rem;
            }
        }
        
        @media (max-width: 576px) {
            .header-title {
                font-size: 1.8rem;
            }
            
            .header-subtitle {
                font-size: 1rem;
            }
            
            .notification-stats {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            .stat-item {
                justify-content: center;
            }
            
            .notification-card {
                padding: 1rem;
            }
            
            .filter-section {
                padding: 1rem;
            }
        }

        .notification-date {
            font-size: 0.9rem;
            color: var(--secondary-color);
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--light-bg);
        }

        .property-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
        }

        .property-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />

    <!-- Notifications Header -->
    <div class="notifications-header">
        <div class="container">
            <div class="header-content">
                <div>
                    <h1 class="header-title">Notifications</h1>
                    <p class="header-subtitle">Stay updated with your appointment requests</p>
                </div>
                <div class="notification-stats">
                    <div class="stat-item">
                        <i class="fas fa-calendar-check"></i>
                        <span>${notifications.size()} Total</span>
                    </div>
                    <div class="stat-item">
                        <i class="fas fa-clock"></i>
                        <span>${notifications.stream().filter(n -> n.getStatus() == 'PENDING').count()} Pending</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-12">
                <!-- Filter Section -->
                <div class="filter-section">
                    <div class="filter-row">
                        <div class="filter-group">
                            <label class="filter-label">Filter by Status</label>
                            <select class="filter-select" id="statusFilter">
                                <option value="">All Status</option>
                                <option value="PENDING">Pending</option>
                                <option value="CONFIRMED">Confirmed</option>
                                <option value="REJECTED">Rejected</option>
                                <option value="COMPLETED">Completed</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Sort by</label>
                            <select class="filter-select" id="sortFilter">
                                <option value="date-desc">Date (Newest First)</option>
                                <option value="date-asc">Date (Oldest First)</option>
                                <option value="status">Status</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">&nbsp;</label>
                            <button class="filter-button" onclick="applyFilters()">
                                <i class="fas fa-filter"></i> Apply Filters
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Notifications Container -->
                <div class="notifications-container" id="notificationsContainer">
                    <% 
                    List<Appointment> notifications = (List<Appointment>) request.getAttribute("notifications");
                    if (notifications != null && !notifications.isEmpty()) {
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' hh:mm a");
                        for (Appointment notification : notifications) {
                    %>
                        <div class="notification-card" data-status="<%= notification.getStatus() %>" data-date="<%= notification.getAppointmentDate() %>">
                            <div class="notification-header">
                                <h3 class="notification-title">
                                    Appointment Request for 
                                    <a href="${pageContext.request.contextPath}/property-details?id=<%= notification.getProperty().getId() %>" 
                                       class="property-link">
                                        <%= notification.getProperty().getPropertyType() %>
                                    </a>
                                </h3>
                                <span class="notification-status status-<%= notification.getStatus().toString().toLowerCase() %>">
                                    <%= notification.getStatus() %>
                                </span>
                            </div>
                            
                            <div class="notification-content">
                                <div class="notification-details">
                                    <div class="detail-row">
                                        <div class="detail-icon">
                                            <i class="fas fa-calendar-alt"></i>
                                        </div>
                                        <div class="detail-content">
                                            <div class="detail-label">Appointment Date</div>
                                            <div class="detail-value">
                                                <%= notification.getAppointmentDate().format(formatter) %>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-row">
                                        <div class="detail-icon">
                                            <i class="fas fa-user-tie"></i>
                                        </div>
                                        <div class="detail-content">
                                            <div class="detail-label">Agent</div>
                                            <div class="detail-value">
                                                <%= notification.getProperty().getUser_id().getFirstName() %> 
                                                <%= notification.getProperty().getUser_id().getLastName() %>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="detail-row">
                                        <div class="detail-icon">
                                            <i class="fas fa-map-marker-alt"></i>
                                        </div>
                                        <div class="detail-content">
                                            <div class="detail-label">Property Location</div>
                                            <div class="detail-value">
                                                <%= notification.getProperty().getAddress() %>, 
                                                <%= notification.getProperty().getCity() %>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <% if (notification.getMessage() != null && !notification.getMessage().trim().isEmpty()) { %>
                                    <div class="detail-row">
                                        <div class="detail-icon">
                                            <i class="fas fa-comment"></i>
                                        </div>
                                        <div class="detail-content">
                                            <div class="detail-label">Your Message</div>
                                            <div class="detail-value">
                                                <%= notification.getMessage() %>
                                            </div>
                                        </div>
                                    </div>
                                    <% } %>
                                    
                                    <div class="notification-date">
                                        <i class="fas fa-clock"></i>
                                        Requested on <%= notification.getAppointmentDate().format(DateTimeFormatter.ofPattern("MMM dd, yyyy")) %>
                                    </div>
                                </div>
                                
                                <div class="notification-actions">
                                    <a href="${pageContext.request.contextPath}/property-details?id=<%= notification.getProperty().getId() %>" 
                                       class="action-button btn-primary">
                                        <i class="fas fa-eye"></i>
                                        View Property
                                    </a>
                                    
                                    <% if (notification.getStatus() == AppointmentStatus.CONFIRMED) { %>
                                    <button class="action-button btn-secondary mark-read-btn" 
                                            data-appointment-id="<%= notification.getId() %>">
                                        <i class="fas fa-check"></i>
                                        Mark as Read
                                    </button>
                                    <% } %>
                                    
                                    <button class="action-button btn-outline-danger delete-notification-btn" 
                                            data-appointment-id="<%= notification.getId() %>">
                                        <i class="fas fa-trash"></i>
                                        cancel Appointment
                                    </button>
                                </div>
                            </div>
                        </div>
                    <% 
                        }
                    } else {
                    %>
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-bell-slash"></i>
                            </div>
                            <h3 class="empty-title">No Notifications Yet</h3>
                            <p class="empty-text">You haven't made any appointment requests yet. Start exploring properties to schedule viewings!</p>
                            <a href="${pageContext.request.contextPath}/properties" class="action-button btn-primary">
                                <i class="fas fa-search"></i>
                                Browse Properties
                            </a>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
function applyFilters() {
    const statusFilter = document.getElementById('statusFilter').value;
    const sortFilter = document.getElementById('sortFilter').value;
    const notifications = document.querySelectorAll('.notification-card');
    notifications.forEach(card => {
        const status = card.dataset.status;
        const date = new Date(card.dataset.date);
        if (statusFilter && status !== statusFilter) {
            card.style.display = 'none';
        } else {
            card.style.display = 'block';
        }
    });
    const container = document.getElementById('notificationsContainer');
    const cards = Array.from(notifications);
    cards.sort((a, b) => {
        const dateA = new Date(a.dataset.date);
        const dateB = new Date(b.dataset.date);
        if (sortFilter === 'date-desc') {
            return dateB - dateA;
        } else if (sortFilter === 'date-asc') {
            return dateA - dateB;
        } else if (sortFilter === 'status') {
            return a.dataset.status.localeCompare(b.dataset.status);
        }
        return 0;
    });
    cards.forEach(card => {
        if (card.style.display !== 'none') {
            container.appendChild(card);
        }
    });
}
window.applyFilters = applyFilters;
document.addEventListener('DOMContentLoaded', function() {
    function markAsRead(appointmentId) {
        showAlert('Notification marked as read!', 'success');
    }
    async function deleteNotification(appointmentId) {
        const result = await window.showConfirmAlert('Are you sure you want to cancel this appointment? This action cannot be undone.');
        if (!result) return;
        if (!appointmentId || appointmentId === 'null' || appointmentId === '') {
            showAlert('Invalid notification ID', 'error');
            return;
        }
        const url = '${pageContext.request.contextPath}/api/appointments/' + appointmentId + '/delete';
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            }
        })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    let msg = text;
                    try {
                        const json = JSON.parse(text);
                        msg = json.error || json.message || text;
                    } catch (e) {}
                    throw new Error(msg);
                });
            }
            return response.text();
        })
        .then(data => {
            showAlert('Appointment Cancelled successfully!', 'success');
            const button = document.querySelector('[data-appointment-id="' + appointmentId + '"]');
            if (button) {
                const notificationCard = button.closest('.notification-card');
                if (notificationCard) {
                    notificationCard.style.opacity = '0';
                    notificationCard.style.transform = 'translateX(100%)';
                    setTimeout(() => {
                        notificationCard.remove();
                        const remainingCards = document.querySelectorAll('.notification-card');
                        if (remainingCards.length === 0) location.reload();
                    }, 300);
                } else { location.reload(); }
            } else { location.reload(); }
        })
        .catch(error => {
            showAlert(error.message || 'Failed to delete notification. Please try again.', 'error');
        });
    }
    document.addEventListener('click', function(e) {
        if (e.target.closest('.cancel-appointment-btn')) {
            const button = e.target.closest('.cancel-appointment-btn');
            const appointmentId = button.getAttribute('data-appointment-id');
        }
        if (e.target.closest('.mark-read-btn')) {
            const button = e.target.closest('.mark-read-btn');
            const appointmentId = button.getAttribute('data-appointment-id');
            markAsRead(appointmentId);
        }
        if (e.target.closest('.delete-notification-btn')) {
            const button = e.target.closest('.delete-notification-btn');
            const appointmentId = button.getAttribute('data-appointment-id');
            deleteNotification(appointmentId);
        }
    });
});
</script>
</body>
</html> 