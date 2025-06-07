<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.Real_Estate.entity.Properties" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agent Portal - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #3b82f6;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #38bdf8;
            --light-bg: #f8fafc;
            --dark-text: #1e293b;
            --light-text: #ffffff;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
            --border-radius: 16px;
            --section-spacing: 2.5rem;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Inter', sans-serif;
            padding-top: 80px;
            color: var(--dark-text);
            line-height: 1.6;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 2rem;
            max-width: 1800px;
            margin: 0 auto;
            padding: 2rem;
        }

        .profile-section {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .profile-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            box-shadow: var(--card-shadow);
        }

        .profile-image {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            object-fit: cover;
        }

        .profile-info h4 {
            margin: 0;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .profile-info p {
            margin: 0;
            color: var(--dark-text);
            opacity: 0.7;
            font-size: 0.875rem;
        }

        @media (max-width: 1200px) {
            .profile-section {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .profile-section {
                grid-template-columns: 1fr;
            }
        }

        .main-grid {
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            gap: 1.5rem;
        }

        .tile {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--card-shadow);
            padding: 1.5rem;
            transition: var(--transition);
        }

        .tile:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
        }

        .tile-full {
            grid-column: span 12;
        }

        .tile-half {
            grid-column: span 6;
        }

        .tile-third {
            grid-column: span 4;
        }

        .tile-quarter {
            grid-column: span 3;
        }

        .tile-two-thirds {
            grid-column: span 8;
        }

        .tile-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .tile-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--dark-text);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .tile-title i {
            color: var(--primary-color);
            font-size: 1.5rem;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1rem;
        }

        .stat-tile {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 1.25rem;
            background: white;
            box-shadow: var(--card-shadow);
        }

        .stat-info h3 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .stat-info p {
            color: var(--dark-text);
            opacity: 0.7;
            font-size: 0.875rem;
            margin: 0;
        }

        .activity-tile {
            height: 100%;
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .activity-item {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 1.25rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: var(--transition);
        }

        .activity-item:hover {
            transform: translateX(5px);
            background: white;
            box-shadow: var(--card-shadow);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            font-size: 1.1rem;
        }

        .property-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
        }

        .property-tile {
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }

        .property-tile:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .property-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            transition: var(--transition);
        }

        .property-tile:hover .property-image {
            transform: scale(1.05);
        }

        .property-content {
            padding: 1.5rem;
        }

        .property-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .property-price {
            color: var(--primary-color);
            font-weight: 700;
            font-size: 1.25rem;
            margin-bottom: 1rem;
        }

        .property-features {
            display: flex;
            justify-content: space-between;
            color: var(--dark-text);
            opacity: 0.7;
            font-size: 0.875rem;
        }

        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: var(--border-radius);
            padding: 3rem;
            color: white;
            margin-bottom: var(--section-spacing);
            position: relative;
            overflow: hidden;
        }

        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(30%, -30%);
        }

        .welcome-banner h2 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .welcome-banner p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        .btn {
            padding: 0.8rem 1.5rem;
            border-radius: 12px;
            font-weight: 600;
            transition: var(--transition);
            font-size: 1rem;
        }

        .btn-primary {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-primary:hover {
            background: var(--secondary-color);
            border-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .btn-outline-primary {
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .btn-outline-primary:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
        }

        .appointment-time {
            background: var(--light-bg);
            border-radius: 12px;
            padding: 1rem;
            min-width: 100px;
            text-align: center;
            border: 1px solid rgba(0,0,0,0.05);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--dark-text);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary-color);
            font-size: 1.75rem;
        }

        .market-insight-card {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            height: 100%;
            transition: var(--transition);
        }

        .market-insight-card:hover {
            transform: translateY(-3px);
            box-shadow: var(--card-shadow);
        }

        .market-insight-card h6 {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.75rem;
        }

        .market-insight-card h4 {
            font-size: 1.75rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        @media (max-width: 1200px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .property-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            .tile-half, .tile-third, .tile-quarter, .tile-two-thirds {
                grid-column: span 12;
            }
            .property-grid {
                grid-template-columns: 1fr;
            }
        }

        .quick-actions-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin-top: 1rem;
        }

        .quick-action-item {
            background: var(--light-bg);
            border-radius: var(--border-radius);
            padding: 1.25rem;
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: var(--transition);
            text-decoration: none;
            color: var(--dark-text);
        }

        .quick-action-item:hover {
            background: white;
            transform: translateY(-2px);
            box-shadow: var(--card-shadow);
            color: var(--primary-color);
        }

        .quick-action-icon {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 1.25rem;
            background: white;
            box-shadow: var(--card-shadow);
        }

        .quick-action-info {
            flex: 1;
        }

        .quick-action-info h6 {
            margin: 0;
            font-weight: 600;
        }

        .quick-action-info p {
            margin: 0;
            font-size: 0.875rem;
            color: var(--dark-text);
            opacity: 0.7;
        }

        @media (max-width: 768px) {
            .quick-actions-grid {
                grid-template-columns: 1fr;
            }
        }

        .insights-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
        }

        .insight-tile {
            background: white;
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }

        .insight-tile:hover {
            transform: translateY(-2px);
            box-shadow: var(--hover-shadow);
        }

        .insight-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .insight-icon {
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 12px;
            font-size: 1.5rem;
        }

        .insight-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin: 0;
        }

        .insight-content {
            margin-top: 1rem;
        }

        .insight-stat {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .insight-description {
            color: var(--dark-text);
            opacity: 0.7;
            font-size: 0.875rem;
            margin: 0;
        }

        .insight-trend {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.5rem;
            font-size: 0.875rem;
        }

        .trend-up {
            color: var(--success-color);
        }

        .trend-down {
            color: var(--danger-color);
        }

        @media (max-width: 1200px) {
            .insights-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .insights-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <div class="dashboard-grid">
        <!-- Profile Section -->
        <div class="profile-section">
            <div class="profile-card">
                <img src="https://ui-avatars.com/api/?name=${user.firstName}+${user.lastName}&background=2563eb&color=fff" 
                     class="profile-image" alt="Agent Profile">
                <div class="profile-info">
                    <h4>${user.firstName} ${user.lastName}</h4>
                    <p>Senior Real Estate Agent</p>
                </div>
            </div>
            <div class="profile-card">
                <div class="quick-action-icon bg-primary bg-opacity-10">
                    <i class="fas fa-home text-primary"></i>
                </div>
                <div class="profile-info">
                    <h4>25</h4>
                    <p>Total Listings</p>
                </div>
            </div>
            <div class="profile-card">
                <div class="quick-action-icon bg-success bg-opacity-10">
                    <i class="fas fa-users text-success"></i>
                </div>
                <div class="profile-info">
                    <h4>7</h4>
                    <p>Active Leads</p>
                </div>
            </div>
            <div class="profile-card">
                <div class="quick-action-icon bg-info bg-opacity-10">
                    <i class="fas fa-rupee-sign text-info"></i>
                </div>
                <div class="profile-info">
                    <h4>₹8.2 Cr</h4>
                    <p>Sales Volume</p>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-grid">
            <!-- Welcome Banner -->
            <div class="tile tile-full welcome-banner">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h2 class="mb-2">Welcome back, ${user.firstName}!</h2>
                        <p class="mb-0 opacity-90">Here's your personalized overview for today.</p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <span class="h3 mb-0">Today</span>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="tile tile-full">
                <h5 class="tile-title mb-3">Quick Actions</h5>
                <div class="quick-actions-grid">
                    <a href="${pageContext.request.contextPath}/agent/agent-properties" class="quick-action-item">
                        <div class="quick-action-icon bg-primary bg-opacity-10">
                            <i class="fas fa-plus-circle text-primary"></i>
                        </div>
                        <div class="quick-action-info">
                            <h6>Add New Property</h6>
                            <p>List a new property for sale</p>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/agent/manage-properties" class="quick-action-item">
                        <div class="quick-action-icon bg-success bg-opacity-10">
                            <i class="fas fa-list-alt text-success"></i>
                        </div>
                        <div class="quick-action-info">
                            <h6>Manage Listings</h6>
                            <p>Update your property listings</p>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/agent/leads" class="quick-action-item">
                        <div class="quick-action-icon bg-info bg-opacity-10">
                            <i class="fas fa-users text-info"></i>
                        </div>
                        <div class="quick-action-info">
                            <h6>View Inquiries</h6>
                            <p>Check new property inquiries</p>
                        </div>
                    </a>
                    <a href="${pageContext.request.contextPath}/agent/appointments" class="quick-action-item">
                        <div class="quick-action-icon bg-warning bg-opacity-10">
                            <i class="fas fa-calendar-check text-warning"></i>
                        </div>
                        <div class="quick-action-info">
                            <h6>Schedule</h6>
                            <p>Manage your appointments</p>
                        </div>
                    </a>
                </div>
            </div>

            <!-- Performance Chart -->
            <div class="tile tile-two-thirds">
                <div class="tile-header">
                    <h2 class="tile-title">
                        <i class="fas fa-chart-line"></i>
                        Performance Overview
                    </h2>
                </div>
                <div style="height: 350px;">
                    <canvas id="agentPerformanceChart"></canvas>
                </div>
            </div>

            <!-- Market Insights -->
            <div class="tile tile-third">
                <div class="tile-header">
                    <h2 class="tile-title">
                        <i class="fas fa-chart-pie"></i>
                        Market Insights
                    </h2>
                </div>
                <div class="d-grid gap-3">
                    <div class="market-insight-card">
                        <h6 class="text-muted">Avg. Listing Price</h6>
                        <h4 class="mb-0">₹55.8L</h4>
                        <small class="text-success"><i class="fas fa-arrow-up"></i> 7% from last month</small>
                    </div>
                    <div class="market-insight-card">
                        <h6 class="text-muted">Days on Market</h6>
                        <h4 class="mb-0">32</h4>
                        <small class="text-danger"><i class="fas fa-arrow-down"></i> 5 days less</small>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div class="tile tile-half activity-tile">
                <div class="tile-header">
                    <h2 class="tile-title">
                        <i class="fas fa-bell"></i>
                        Recent Activity
                    </h2>
                </div>
                <div class="activity-list">
                    <div class="activity-item">
                        <div class="activity-icon bg-primary text-white">
                            <i class="fas fa-comment-dots"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">New inquiry on Luxury Villa</h6>
                            <p class="text-muted mb-0">2 mins ago</p>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon bg-success text-white">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Appointment scheduled</h6>
                            <p class="text-muted mb-0">1 hour ago</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Upcoming Appointments -->
            <div class="tile tile-half">
                <div class="tile-header">
                    <h2 class="tile-title">
                        <i class="fas fa-calendar-alt"></i>
                        Upcoming Appointments
                    </h2>
                </div>
                <div class="activity-list">
                    <div class="activity-item">
                        <div class="activity-icon bg-info text-white">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Showing: Ocean Breeze Villa</h6>
                            <p class="text-muted mb-0">Today, 3:00 PM</p>
                        </div>
                    </div>
                    <div class="activity-item">
                        <div class="activity-icon bg-warning text-white">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div>
                            <h6 class="mb-1">Client Meeting</h6>
                            <p class="text-muted mb-0">Tomorrow, 10:00 AM</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Important Insights -->
            <div class="tile tile-full">
                <div class="tile-header">
                    <h2 class="tile-title">
                        <i class="fas fa-chart-bar"></i>
                        Important Insights
                    </h2>
                </div>
                <div class="insights-grid">
                    <div class="insight-tile">
                        <div class="insight-header">
                            <div class="insight-icon bg-primary bg-opacity-10">
                                <i class="fas fa-trophy text-primary"></i>
                            </div>
                            <h3 class="insight-title">Performance Rating</h3>
                        </div>
                        <div class="insight-content">
                            <div class="insight-stat">4.8/5</div>
                            <p class="insight-description">Based on client feedback and successful transactions</p>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>0.2 points from last month</span>
                            </div>
                        </div>
                    </div>

                    <div class="insight-tile">
                        <div class="insight-header">
                            <div class="insight-icon bg-success bg-opacity-10">
                                <i class="fas fa-handshake text-success"></i>
                            </div>
                            <h3 class="insight-title">Deal Success Rate</h3>
                        </div>
                        <div class="insight-content">
                            <div class="insight-stat">92%</div>
                            <p class="insight-description">Properties listed that were successfully sold</p>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>3% higher than average</span>
                            </div>
                        </div>
                    </div>

                    <div class="insight-tile">
                        <div class="insight-header">
                            <div class="insight-icon bg-info bg-opacity-10">
                                <i class="fas fa-clock text-info"></i>
                            </div>
                            <h3 class="insight-title">Response Time</h3>
                        </div>
                        <div class="insight-content">
                            <div class="insight-stat">15m</div>
                            <p class="insight-description">Average response time to client inquiries</p>
                            <div class="insight-trend trend-down">
                                <i class="fas fa-arrow-down"></i>
                                <span>5m faster than last month</span>
                            </div>
                        </div>
                    </div>

                    <div class="insight-tile">
                        <div class="insight-header">
                            <div class="insight-icon bg-warning bg-opacity-10">
                                <i class="fas fa-star text-warning"></i>
                            </div>
                            <h3 class="insight-title">Client Satisfaction</h3>
                        </div>
                        <div class="insight-content">
                            <div class="insight-stat">98%</div>
                            <p class="insight-description">Happy clients from recent transactions</p>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>2% increase from last quarter</span>
                            </div>
                        </div>
                    </div>

                    <div class="insight-tile">
                        <div class="insight-header">
                            <div class="insight-icon bg-danger bg-opacity-10">
                                <i class="fas fa-bullseye text-danger"></i>
                            </div>
                            <h3 class="insight-title">Conversion Rate</h3>
                        </div>
                        <div class="insight-content">
                            <div class="insight-stat">68%</div>
                            <p class="insight-description">Inquiries converted to appointments</p>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>5% higher than target</span>
                            </div>
                        </div>
                    </div>

                    <div class="insight-tile">
                        <div class="insight-header">
                            <div class="insight-icon bg-secondary bg-opacity-10">
                                <i class="fas fa-chart-line text-secondary"></i>
                            </div>
                            <h3 class="insight-title">Market Position</h3>
                        </div>
                        <div class="insight-content">
                            <div class="insight-stat">Top 5%</div>
                            <p class="insight-description">Among local real estate agents</p>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>2 positions up this month</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const ctxAgent = document.getElementById('agentPerformanceChart').getContext('2d');
            new Chart(ctxAgent, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Listings Added',
                        data: [5, 7, 6, 8, 9, 7],
                        borderColor: 'rgb(37, 99, 235)',
                        backgroundColor: 'rgba(37, 99, 235, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: 'Properties Sold',
                        data: [2, 3, 2, 4, 3, 5],
                        borderColor: 'rgb(16, 185, 129)',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                usePointStyle: true,
                                padding: 20
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                display: true,
                                drawBorder: false
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html> 