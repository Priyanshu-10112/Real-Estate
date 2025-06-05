<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.Real_Estate.entity.User,java.util.List,com.example.Real_Estate.entity.Properties" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - LuxuryEstate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/newcss.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1e40af;
            --accent-color: #3b82f6;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --light-bg: #f8fafc;
            --dark-text: #1e293b;
            --light-text: #ffffff;
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            --hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --transition: all 0.3s ease;
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Inter', sans-serif;
            padding-top: 80px;
        }

        /* Welcome Section */
        .welcome-section {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            border-radius: 20px;
            padding: 2.5rem;
            color: white;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(30%, -30%);
        }

        .welcome-content {
            position: relative;
            z-index: 1;
        }

        .welcome-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .welcome-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 1.5rem;
        }

        .welcome-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            padding: 1.5rem;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .action-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            cursor: pointer;
            text-decoration: none;
            color: var(--dark-text);
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .action-icon {
            width: 50px;
            height: 50px;
            background: var(--light-bg);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.5rem;
            color: var(--primary-color);
        }

        .action-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .action-description {
            font-size: 0.9rem;
            color: #64748b;
        }

        /* Interactive Elements */
        .interactive-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .chart-container {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .chart-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
        }

        .chart-legend {
            display: flex;
            gap: 1rem;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: #64748b;
        }

        .legend-color {
            width: 12px;
            height: 12px;
            border-radius: 3px;
        }

        .chatbot-button {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: var(--primary-color);
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            box-shadow: var(--card-shadow);
            cursor: pointer;
            transition: var(--transition);
            z-index: 1000;
        }

        .chatbot-button:hover {
            transform: scale(1.1);
            background: var(--secondary-color);
        }

        .quick-stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
        }

        .stat-box {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }

        .stat-box:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            background: var(--light-bg);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.2rem;
            color: var(--primary-color);
        }

        .stat-title {
            font-size: 0.9rem;
            color: #64748b;
            margin-bottom: 0.5rem;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--dark-text);
        }

        /* Market Insights */
        .market-insights {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
        }

        .insight-card {
            background: var(--light-bg);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
        }

        .insight-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-text);
            margin-bottom: 0.5rem;
        }

        .insight-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .insight-trend {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        .trend-up {
            color: var(--success-color);
        }

        .trend-down {
            color: var(--danger-color);
        }

        /* Notification and Activity Section */
        .notification-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
        }

        .notification-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .notification-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--dark-text);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .notification-badge {
            background: var(--primary-color);
            color: white;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
        }

        .notification-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .notification-item {
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            padding: 1rem;
            background: var(--light-bg);
            border-radius: 12px;
            transition: var(--transition);
        }

        .notification-item:hover {
            transform: translateX(5px);
            background: #f1f5f9;
        }

        .notification-icon {
            width: 40px;
            height: 40px;
            background: white;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: var(--primary-color);
            box-shadow: var(--card-shadow);
        }

        .notification-content {
            flex: 1;
        }

        .notification-text {
            font-size: 0.95rem;
            color: var(--dark-text);
            margin-bottom: 0.25rem;
        }

        .notification-time {
            font-size: 0.8rem;
            color: #64748b;
        }

        /* Property Recommendations */
        .recommendations-section {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
        }

        .recommendation-card {
            background: var(--light-bg);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: var(--transition);
            cursor: pointer;
        }

        .recommendation-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .recommendation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .recommendation-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-text);
        }

        .recommendation-price {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .recommendation-details {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .recommendation-detail {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: #64748b;
        }

        .recommendation-detail i {
            color: var(--primary-color);
        }

        .recommendation-tags {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .recommendation-tag {
            background: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
        }

        /* Market Activity Feed */
        .activity-feed {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
        }

        .activity-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #e2e8f0;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            background: var(--light-bg);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            color: var(--primary-color);
        }

        .activity-content {
            flex: 1;
        }

        .activity-text {
            font-size: 0.95rem;
            color: var(--dark-text);
            margin-bottom: 0.25rem;
        }

        .activity-time {
            font-size: 0.8rem;
            color: #64748b;
        }

        @media (max-width: 768px) {
            .welcome-section {
                padding: 1.5rem;
            }

            .welcome-title {
                font-size: 2rem;
            }

            .quick-actions {
                grid-template-columns: 1fr;
            }

            .interactive-section {
                grid-template-columns: 1fr;
            }

            .quick-stats {
                grid-template-columns: 1fr;
            }

            .notification-list,
            .recommendation-details {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />

    <div class="dashboard-container">
        <div class="container">
            <!-- Welcome Section -->
            <div class="welcome-section">
                <div class="welcome-content">
                    <h1 class="welcome-title">Welcome back, ${user.firstName}!</h1>
                    <p class="welcome-subtitle">Here's what's happening with your real estate journey today.</p>
                    <div class="welcome-stats">
                        <div class="stat-card">
                            <div class="stat-value">500+</div>
                            <div class="stat-label">Properties Available</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value">20+</div>
                            <div class="stat-label">Cities Covered</div>
                        </div>
                        <div class="stat-card">
                            <div class="stat-value">4.8</div>
                            <div class="stat-label">Average Rating</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <a href="${pageContext.request.contextPath}/user/properties" class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <h3 class="action-title">Browse Properties</h3>
                    <p class="action-description">Explore our extensive collection of properties</p>
                </a>
                <a href="${pageContext.request.contextPath}/profile" class="action-card">
                    <div class="action-icon">
                        <i class="fas fa-user"></i>
                    </div>
                    <h3 class="action-title">Profile</h3>
                    <p class="action-description">Manage your account preferences</p>
                </a>
            </div>

            <!-- Interactive Section -->
            <div class="interactive-section">
                <div class="chart-container">
                    <div class="chart-header">
                        <h3 class="chart-title">Property Market Analysis</h3>
                        <div class="chart-legend">
                            <div class="legend-item">
                                <div class="legend-color" style="background: var(--primary-color);"></div>
                                <span>Listings</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-color" style="background: var(--success-color);"></div>
                                <span>Sales</span>
                            </div>
                            <div class="legend-item">
                                <div class="legend-color" style="background: var(--warning-color);"></div>
                                <span>Price Trend</span>
                            </div>
                        </div>
                    </div>
                    <div style="position: relative; height: 300px;">
                        <canvas id="marketTrendsChart"></canvas>
                    </div>
                </div>
                <div class="quick-stats">
                    <div class="stat-box">
                        <div class="stat-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="stat-title">Market Growth</div>
                        <div class="stat-value">+15.3%</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-title">Avg. Response Time</div>
                        <div class="stat-value">2.5h</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-title">Active Buyers</div>
                        <div class="stat-value">1.2k</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-icon">
                            <i class="fas fa-home"></i>
                        </div>
                        <div class="stat-title">New Listings</div>
                        <div class="stat-value">45</div>
                    </div>
                </div>
            </div>

            <!-- Market Insights -->
            <div class="market-insights">
                <div class="section-header">
                    <h2 class="section-title">Market Insights</h2>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <div class="insight-card">
                            <h3 class="insight-title">Average Property Price</h3>
                            <div class="insight-value">₹45.2L</div>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>12% from last month</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="insight-card">
                            <h3 class="insight-title">Properties Listed</h3>
                            <div class="insight-value">1,234</div>
                            <div class="insight-trend trend-up">
                                <i class="fas fa-arrow-up"></i>
                                <span>8% from last month</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="insight-card">
                            <h3 class="insight-title">Average Days on Market</h3>
                            <div class="insight-value">45</div>
                            <div class="insight-trend trend-down">
                                <i class="fas fa-arrow-down"></i>
                                <span>5% from last month</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Chatbot Button -->
    <div class="chatbot-button" id="chatbotButton">
        <i class="fas fa-comments"></i>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script>
        $(document).ready(function() {
            // Handle property details click
            $('.btn-view').on('click', function(e) {
                e.preventDefault();
                var propertyId = $(this).data('property-id');
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/user/property',
                    method: 'GET',
                    success: function(response) {
                        if (response.trim() === 'go') {
                            window.location.href = '${pageContext.request.contextPath}/user/property-details/' + propertyId;
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('Error occurred while loading property details. Please try again.');
                    }
                });
            });

            // Market Trends Chart
            const ctx = document.getElementById('marketTrendsChart').getContext('2d');
            
            // Gradient for the area under the line
            const gradient1 = ctx.createLinearGradient(0, 0, 0, 300);
            gradient1.addColorStop(0, 'rgba(37, 99, 235, 0.2)');
            gradient1.addColorStop(1, 'rgba(37, 99, 235, 0)');

            const gradient2 = ctx.createLinearGradient(0, 0, 0, 300);
            gradient2.addColorStop(0, 'rgba(16, 185, 129, 0.2)');
            gradient2.addColorStop(1, 'rgba(16, 185, 129, 0)');

            const gradient3 = ctx.createLinearGradient(0, 0, 0, 300);
            gradient3.addColorStop(0, 'rgba(245, 158, 11, 0.2)');
            gradient3.addColorStop(1, 'rgba(245, 158, 11, 0)');

            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                        label: 'Listings',
                        data: [120, 150, 180, 170, 190, 210, 230, 220, 240, 260, 280, 300],
                        borderColor: 'rgb(37, 99, 235)',
                        backgroundColor: gradient1,
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: 'white',
                        pointBorderColor: 'rgb(37, 99, 235)',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }, {
                        label: 'Sales',
                        data: [80, 100, 120, 110, 130, 150, 170, 160, 180, 200, 220, 240],
                        borderColor: 'rgb(16, 185, 129)',
                        backgroundColor: gradient2,
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: 'white',
                        pointBorderColor: 'rgb(16, 185, 129)',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }, {
                        label: 'Price Trend',
                        data: [45, 47, 48, 49, 50, 52, 53, 54, 55, 57, 58, 60],
                        borderColor: 'rgb(245, 158, 11)',
                        backgroundColor: gradient3,
                        borderWidth: 2,
                        tension: 0.4,
                        fill: true,
                        pointBackgroundColor: 'white',
                        pointBorderColor: 'rgb(245, 158, 11)',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6,
                        yAxisID: 'y1'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    interaction: {
                        intersect: false,
                        mode: 'index'
                    },
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(255, 255, 255, 0.9)',
                            titleColor: '#1e293b',
                            bodyColor: '#64748b',
                            borderColor: '#e2e8f0',
                            borderWidth: 1,
                            padding: 12,
                            boxPadding: 6,
                            usePointStyle: true,
                            callbacks: {
                                label: function(context) {
                                    let label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    if (context.dataset.yAxisID === 'y1') {
                                        label += '₹' + context.parsed.y + 'L';
                                    } else {
                                        label += context.parsed.y;
                                    }
                                    return label;
                                }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)',
                                drawBorder: false
                            },
                            ticks: {
                                color: '#64748b',
                                font: {
                                    size: 11
                                }
                            }
                        },
                        y1: {
                            position: 'right',
                            beginAtZero: true,
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#64748b',
                                font: {
                                    size: 11
                                },
                                callback: function(value) {
                                    return '₹' + value + 'L';
                                }
                            }
                        },
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#64748b',
                                font: {
                                    size: 11
                                }
                            }
                        }
                    }
                }
            });

            // Chatbot Button Click Handler
            $('#chatbotButton').click(function() {
                // This will be implemented later
                alert('Chatbot feature coming soon!');
            });
        });
    </script>
</body>
</html> 