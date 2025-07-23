<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies
%>
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

        /* Responsive improvements and interactive card hover */
        @media (max-width: 991.98px) {
            .row.g-4 > [class^='col-'] {
                flex: 0 0 100%;
                max-width: 100%;
            }
            .quick-actions {
                grid-template-columns: 1fr !important;
            }
            .welcome-section, .notification-section, .market-insights {
                margin-bottom: 1.5rem;
            }
        }
        .action-card, .market-insights, .notification-section, .stat-card {
            cursor: pointer;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .action-card:hover, .market-insights:hover, .notification-section:hover, .stat-card:hover {
            box-shadow: 0 8px 32px rgba(52,152,219,0.18) !important;
            transform: translateY(-4px) scale(1.02);
            z-index: 2;
        }
        .btn[style*='background:#3498db'] {
            transition: background 0.3s, transform 0.2s, box-shadow 0.2s;
        }
        .btn[style*='background:#3498db']:hover {
            background: #2980b9 !important;
            transform: translateY(-2px) scale(1.04);
            box-shadow: 0 8px 24px rgba(41,128,185,0.18);
        }

        .dashboard-tile {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 4px 24px rgba(52,152,219,0.08);
            padding: 2rem 1.5rem;
            margin-bottom: 0;
            transition: box-shadow 0.2s, transform 0.2s;
        }
        .dashboard-tile:hover {
            box-shadow: 0 8px 32px rgba(52,152,219,0.16);
            transform: translateY(-4px) scale(1.01);
            z-index: 2;
        }

        .dashboard-tiles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
            gap: 2.5rem;
            margin-top: 2.5rem;
        }
        @media (max-width: 767.98px) {
            .dashboard-tiles-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-user.jsp" />

    <div class="dashboard-container" style="padding-top: 2.5rem; padding-bottom: 2.5rem;">
        <div class="container">
            <!-- Quick Links at the top -->
            <div class="quick-actions mb-5" style="gap:2.5rem;">
                <a href="${pageContext.request.contextPath}/agent/agent-properties" class="action-card">
                    <div class="action-icon" style="background:#eaf4fb;"><i class="fas fa-building"></i></div>
                    <h3 class="action-title">My Properties</h3>
                    <p class="action-description">View and manage your listed or saved properties</p>
                </a>
                <a href="${pageContext.request.contextPath}/user/properties" class="action-card">
                    <div class="action-icon" style="background:#eaf4fb;"><i class="fas fa-search"></i></div>
                    <h3 class="action-title">Browse Properties</h3>
                    <p class="action-description">Explore our extensive collection of properties</p>
                </a>
                <a href="${pageContext.request.contextPath}/profile" class="action-card">
                    <div class="action-icon" style="background:#eaf4fb;"><i class="fas fa-user"></i></div>
                    <h3 class="action-title">Profile</h3>
                    <p class="action-description">Manage your account preferences</p>
                </a>
                <a href="${pageContext.request.contextPath}/notifications" class="action-card">
                    <div class="action-icon" style="background:#eaf4fb;"><i class="fas fa-bell"></i></div>
                    <h3 class="action-title">Notifications</h3>
                    <p class="action-description">Check your latest notifications</p>
                </a>
            </div>

            <div class="d-flex flex-column gap-5">
                <div class="welcome-section" style="padding:3rem 2rem;">
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
                <div class="notification-section" style="min-height: 260px; padding:2rem 1.5rem;">
                    <div class="notification-header">
                        <span class="notification-title"><i class="fas fa-history"></i> Recent Activities</span>
                    </div>
                    <div class="notification-list">
                        <div class="notification-item">
                            <div class="notification-icon"><i class="fas fa-home"></i></div>
                            <div class="notification-content">
                                <div class="notification-text">You viewed <b>Luxury Villa in Bandra</b></div>
                                <div class="notification-time">2 hours ago</div>
                            </div>
                        </div>
                        <div class="notification-item">
                            <div class="notification-icon"><i class="fas fa-envelope"></i></div>
                            <div class="notification-content">
                                <div class="notification-text">You sent an inquiry for <b>Skyline Penthouse</b></div>
                                <div class="notification-time">Yesterday</div>
                            </div>
                        </div>
                        <div class="notification-item">
                            <div class="notification-icon"><i class="fas fa-calendar-check"></i></div>
                            <div class="notification-content">
                                <div class="notification-text">Appointment scheduled for <b>Seaside Mansion</b></div>
                                <div class="notification-time">3 days ago</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="dashboard-tiles-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(340px, 1fr)); gap: 2.5rem; margin-top: 2.5rem;">
                    <!-- Your Saved Properties -->
                    <div class="dashboard-tile market-insights" style="min-height: 160px;">
                        <h3 class="section-title" style="font-size:1.2rem; color:#3498db; margin-bottom:1rem;">Your Saved Properties</h3>
                        <div style="display:flex; gap:1.2rem; flex-wrap:wrap;">
                            <a href="${pageContext.request.contextPath}/user/property-details/1" style="background:#f8fafc; border-radius:12px; box-shadow:0 2px 8px rgba(52,152,219,0.07); padding:0.7rem 1rem; display:flex; align-items:center; gap:0.7rem; text-decoration:none;">
                                <img src="https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=80&q=80" alt="Saved Property" style="width:48px; height:48px; border-radius:8px;">
                                <div>
                                    <div style="font-weight:600; color:#2563eb;">Skyline Penthouse</div>
                                    <div style="font-size:0.95rem; color:#555;">Bangalore</div>
                                </div>
                            </a>
                            <a href="${pageContext.request.contextPath}/user/property-details/2" style="background:#f8fafc; border-radius:12px; box-shadow:0 2px 8px rgba(52,152,219,0.07); padding:0.7rem 1rem; display:flex; align-items:center; gap:0.7rem; text-decoration:none;">
                                <img src="https://images.unsplash.com/photo-1613490493576-7fde63acd811?auto=format&fit=crop&w=80&q=80" alt="Saved Property" style="width:48px; height:48px; border-radius:8px;">
                                <div>
                                    <div style="font-weight:600; color:#2563eb;">Seaside Mansion</div>
                                    <div style="font-size:0.95rem; color:#555;">Mumbai</div>
                                </div>
                            </a>
                        </div>
                    </div>

                    <!-- Top Rated Agents -->
                    <div class="dashboard-tile market-insights" style="min-height: 180px;">
                        <h3 class="section-title" style="font-size:1.2rem; color:#3498db; margin-bottom:1.5rem;">Top Rated Agents</h3>
                        <div style="display:flex; gap:1.5rem; flex-wrap:wrap; justify-content: flex-start;">
                            <div style="display:flex; align-items:center; gap:0.7rem;">
                                <img src="https://randomuser.me/api/portraits/men/32.jpg" alt="Agent" style="width:48px; height:48px; border-radius:50%; border:2px solid #3498db;">
                                <div>
                                    <div style="font-weight:600; color:#2563eb;">Amit Sharma</div>
                                    <div style="font-size:0.95rem; color:#f1c40f;"><i class="fas fa-star"></i> 4.9</div>
                                </div>
                            </div>
                            <div style="display:flex; align-items:center; gap:0.7rem;">
                                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="Agent" style="width:48px; height:48px; border-radius:50%; border:2px solid #3498db;">
                                <div>
                                    <div style="font-weight:600; color:#2563eb;">Priya Verma</div>
                                    <div style="font-size:0.95rem; color:#f1c40f;"><i class="fas fa-star"></i> 4.8</div>
                                </div>
                            </div>
                            <div style="display:flex; align-items:center; gap:0.7rem;">
                                <img src="https://randomuser.me/api/portraits/men/65.jpg" alt="Agent" style="width:48px; height:48px; border-radius:50%; border:2px solid #3498db;">
                                <div>
                                    <div style="font-weight:600; color:#2563eb;">Rahul Singh</div>
                                    <div style="font-size:0.95rem; color:#f1c40f;"><i class="fas fa-star"></i> 4.7</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Upcoming Events -->
                    <div class="dashboard-tile market-insights" style="min-height: 140px;">
                        <h3 class="section-title" style="font-size:1.2rem; color:#3498db; margin-bottom:1rem;">Upcoming Events</h3>
                        <ul style="padding-left:1.2rem; color:#333; font-size:1rem; margin-bottom:0;">
                            <li>Virtual Property Expo – 25th July</li>
                            <li>Live Q&A with Top Agents – 1st August</li>
                            <li>Investment Webinar – 10th August</li>
                        </ul>
                    </div>

                    <!-- Real Estate Tip -->
                    <div class="dashboard-tile market-insights" style="min-height: 120px;">
                        <h3 class="section-title" style="font-size:1.2rem; color:#3498db; margin-bottom:1rem;">Real Estate Tip</h3>
                        <p style="color:#333; font-size:1rem;">Always verify property documents and legal clearances before making a purchase. Consult with a trusted real estate advisor for a smooth transaction.</p>
                    </div>

                    <!-- Market Insight -->
                    <div class="dashboard-tile market-insights" style="min-height: 120px;">
                        <h3 class="section-title" style="font-size:1.2rem; color:#3498db; margin-bottom:1rem;">Market Insight</h3>
                        <p style="color:#333; font-size:1rem;">Property prices in top Indian cities have seen a 12% rise in the last year. Stay updated for the best investment opportunities!</p>
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
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        $(document).ready(function() {
            // Chatbot Button Click Handler
            $('#chatbotButton').click(function() {
                showAlert('Chatbot feature coming soon!', 'info');
            });
        });
    </script>
</body>
</html> 