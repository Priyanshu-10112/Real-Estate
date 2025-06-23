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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js/dist/chart.min.css"/>
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #10b981;
            --accent-color: #38bdf8;
            --grey-bg: #f4f6fa;
            --card-bg: #fff;
            --border-radius: 18px;
            --shadow: 0 4px 24px rgba(37,99,235,0.10);
            --shadow-hover: 0 8px 32px rgba(37,99,235,0.15);
        }
        body { background: var(--grey-bg); }
        .dashboard-main { display: flex; gap: 2rem; }
        .dashboard-left {
            flex: 0 0 320px;
            min-width: 260px;
            max-width: 350px;
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        .dashboard-right { flex: 1; min-width: 0; }
        .profile-summary {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 2rem 1.5rem 1.5rem 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        .profile-summary .profile-image {
            width: 90px; height: 90px; border-radius: 50%; object-fit: cover;
            border: 4px solid var(--primary-color);
            margin-bottom: 1rem;
        }
        .profile-summary h4 { margin: 0.5rem 0 0.2rem 0; font-weight: 700; font-size: 1.3rem; }
        .profile-summary .contact-info { color: #64748b; font-size: 1rem; margin-bottom: 0.2rem; }
        .profile-summary .contact-info i { margin-right: 0.5em; color: var(--primary-color); }
        .side-nav {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.2rem 0.5rem;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        .side-nav a {
            color: #2563eb;
            font-weight: 500;
            padding: 0.7em 1.2em;
            border-radius: 10px;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.7em;
            transition: background 0.2s, color 0.2s;
        }
        .side-nav a:hover, .side-nav a.active {
            background: var(--primary-color);
            color: #fff;
        }
        .main-content {
            display: flex;
            flex-direction: column;
            gap: 2rem;
        }
        .quick-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1.2rem;
        }
        .stat-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.3rem 1.2rem;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 0.5rem;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .stat-card:hover {
            box-shadow: var(--shadow-hover);
            transform: translateY(-2px) scale(1.03);
        }
        .stat-icon {
            font-size: 1.7rem;
            border-radius: 10px;
            padding: 0.5em;
            margin-bottom: 0.2em;
        }
        .stat-title { font-size: 1.05rem; color: #64748b; font-weight: 600; }
        .stat-value { font-size: 1.5rem; font-weight: 700; color: var(--primary-color); }
        .stat-stars { color: #fbbf24; font-size: 1.2rem; }
        .cta-row {
            display: flex;
            gap: 1.2rem;
            margin-bottom: 1.2rem;
        }
        .cta-btn {
            background: var(--primary-color);
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 0.8em 1.5em;
            font-weight: 600;
            font-size: 1.05rem;
            box-shadow: 0 2px 8px rgba(37,99,235,0.08);
            transition: background 0.2s, transform 0.2s;
            display: flex;
            align-items: center;
            gap: 0.7em;
        }
        .cta-btn:hover {
            background: var(--secondary-color);
            transform: translateY(-2px) scale(1.04);
        }
        .card-section {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.5rem 1.2rem;
            margin-bottom: 1.5rem;
        }
        .activities-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 0.5rem;
        }
        .activities-table th, .activities-table td {
            padding: 0.7em 0.6em;
            text-align: left;
        }
        .activities-table th {
            color: #64748b;
            font-size: 1.02rem;
            font-weight: 600;
            border-bottom: 2px solid #e5e7eb;
        }
        .activities-table tr {
            border-bottom: 1px solid #e5e7eb;
        }
        .activities-table td {
            font-size: 0.98rem;
        }
        .chart-section {
            display: flex;
            gap: 2rem;
            flex-wrap: wrap;
        }
        .chart-card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 1.2rem 1.2rem 1.5rem 1.2rem;
            flex: 1 1 320px;
            min-width: 260px;
            max-width: 480px;
        }
        @media (max-width: 1200px) {
            .dashboard-main { flex-direction: column; }
            .dashboard-left { flex-direction: row; gap: 1.5rem; }
            .dashboard-right { width: 100%; }
        }
        @media (max-width: 900px) {
            .dashboard-main { flex-direction: column; }
            .dashboard-left { flex-direction: column; }
        }
        @media (max-width: 768px) {
            .dashboard-main { flex-direction: column; gap: 1rem; }
            .dashboard-left { flex-direction: column; min-width: 0; max-width: 100%; }
            .dashboard-right { width: 100%; }
            .chart-section { flex-direction: column; gap: 1.2rem; }
        }
        .welcome-banner {
            margin-top: 3.5rem; /* Ensures it clears the nav bar */
            background: linear-gradient(90deg, #2563eb 0%, #38bdf8 100%);
            color: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 2.5rem 2rem 2rem 2rem;
            position: relative;
        }
        .welcome-banner h2 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            color: #fff;
        }
        .welcome-banner p {
            font-size: 1.15rem;
            color: #e0e7ef;
        }
        @media (max-width: 768px) {
            .welcome-banner {
                padding: 1.5rem 1rem 1.2rem 1rem;
                margin-top: 2.5rem;
            }
            .welcome-banner h2 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <!-- 1. Header: Welcome Banner (Full Width) -->
    <div class="container-fluid px-4 py-3">
        <div class="tile tile-full welcome-banner mb-4 animate__animated animate__fadeInDown">
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

        <!-- Stat Cards Row (Centered) -->
        <div class="row justify-content-center mb-5">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card h-100">
                    <span class="stat-icon" style="background: #e0f2fe;"><i class="fas fa-list-alt text-primary"></i></span>
                    <span class="stat-title">Total Properties</span>
                    <span class="stat-value">${AllProperties != null ? AllProperties.size() : 0}</span>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card h-100">
                    <span class="stat-icon" style="background: #e0ffe0;"><i class="fas fa-bolt text-success"></i></span>
                    <span class="stat-title">Active Listings</span>
                    <span class="stat-value">${AllProperties != null ? AllProperties.stream().filter(p -> p.status.name() == 'AVAILABLE').count() : 0}</span>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card h-100">
                    <span class="stat-icon" style="background: #ffe0e0;"><i class="fas fa-check-circle text-danger"></i></span>
                    <span class="stat-title">Properties Sold</span>
                    <span class="stat-value">${AllProperties != null ? AllProperties.stream().filter(p -> p.status.name() == 'SOLD').count() : 0}</span>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card h-100">
                    <span class="stat-icon" style="background: #fffbe0;"><i class="fas fa-star text-warning"></i></span>
                    <span class="stat-title">Customer Ratings</span>
                    <span class="stat-value stat-stars">
                        <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i> 4.5
                    </span>
                </div>
            </div>
        </div>

        <!-- Graphs Row (Centered) -->
        <div class="row justify-content-center mb-5">
            <div class="col-md-6 mb-4 mb-md-0">
                <div class="chart-card h-100">
                    <h6 class="mb-3"><i class="fas fa-chart-pie text-primary"></i> Property Types Listed</h6>
                    <canvas id="propertyTypeChart" height="180"></canvas>
                </div>
            </div>
            <div class="col-md-6">
                <div class="chart-card h-100">
                    <h6 class="mb-3"><i class="fas fa-globe-asia text-success"></i> Region-wise Distribution</h6>
                    <canvas id="regionChart" height="180"></canvas>
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

        // Dummy data for charts
        const propertyTypeChart = new Chart(document.getElementById('propertyTypeChart'), {
            type: 'pie',
            data: {
                labels: ['Apartment', 'Villa', 'Plot', 'Commercial'],
                datasets: [{
                    data: [12, 7, 5, 3],
                    backgroundColor: ['#2563eb', '#10b981', '#38bdf8', '#64748b'],
                }]
            },
            options: { plugins: { legend: { position: 'bottom' } } }
        });
        const regionChart = new Chart(document.getElementById('regionChart'), {
            type: 'bar',
            data: {
                labels: ['North', 'South', 'East', 'West'],
                datasets: [{
                    label: 'Properties',
                    data: [8, 6, 9, 4],
                    backgroundColor: '#2563eb',
                    borderRadius: 8,
                }]
            },
            options: {
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true } }
            }
        });
    </script>
</body>
</html> 