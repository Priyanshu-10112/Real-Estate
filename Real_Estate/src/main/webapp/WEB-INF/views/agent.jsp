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
        .welcome-banner {
            margin-top: 3.9rem;
            background: linear-gradient(90deg, var(--primary-color) 0%, var(--accent-color) 100%);
            color: #fff;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            padding: 2.8rem 2.2rem 2.2rem 2.2rem;
            position: relative;
            overflow: hidden;
        }
        .welcome-banner::before {
            content: '';
            position: absolute;
            inset: 0;
            background: rgba(37,99,235,0.18);
            backdrop-filter: blur(1.5px);
            z-index: 1;
        }
        .confetti {
            position: absolute;
            top: 1.2rem;
            right: 2.2rem;
            font-size: 2.2rem;
            z-index: 3;
            animation: floatConfetti 2.5s infinite alternate ease-in-out;
        }
        @keyframes floatConfetti {
            0% { transform: translateY(0) rotate(-10deg); }
            100% { transform: translateY(-18px) rotate(10deg); }
        }
        .welcome-banner .header-title {
            font-size: 2.5rem;
            font-weight: 900;
            color: #fff;
            margin-bottom: 0.3rem;
            display: flex;
            align-items: center;
            gap: 0.7rem;
            position: relative;
            z-index: 2;
        }
        .welcome-banner .header-username {
            background: none;
            -webkit-background-clip: initial;
            -webkit-text-fill-color: initial;
            background-clip: initial;
            color: #fff;
            font-weight: 900;
            font-size: 2.6rem;
            display: inline-block;
            position: relative;
        }
        .welcome-banner .header-title-underline {
            display: block;
            height: 5px;
            width: 120px;
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            border-radius: 3px;
            margin-top: 0.2rem;
            animation: underlineGrow 1.2s cubic-bezier(.68,-0.55,.27,1.55) 1;
        }
        @keyframes underlineGrow {
            0% { width: 0; opacity: 0; }
            100% { width: 120px; opacity: 1; }
        }
        .welcome-banner .header-subtitle {
            font-size: 1.18rem;
            color: #e0e7ef;
            margin-bottom: 0.7rem;
            font-weight: 500;
            position: relative;
            z-index: 2;
        }
        .welcome-banner .header-tip {
            background: rgba(255,255,255,0.13);
            color: #fffbe0;
            border-radius: 10px;
            padding: 0.7em 1.2em;
            font-size: 1.05rem;
            font-weight: 600;
            display: inline-block;
            margin-top: 0.5rem;
            box-shadow: 0 2px 8px rgba(37,99,235,0.08);
            min-height: 2.2em;
            transition: background 0.2s;
            position: relative;
            z-index: 2;
        }
        .welcome-banner .header-progress {
            width: 180px;
            height: 10px;
            background: var(--grey-bg);
            border-radius: 6px;
            margin-top: 1.2rem;
            overflow: hidden;
            position: relative;
            z-index: 2;
        }
        .welcome-banner .header-progress-bar {
            height: 100%;
            width: 70%;
            background: linear-gradient(90deg, var(--secondary-color) 0%, var(--accent-color) 100%);
            border-radius: 6px;
            animation: progressGrow 1.5s cubic-bezier(.68,-0.55,.27,1.55) 1;
        }
        @keyframes progressGrow {
            0% { width: 0; }
            100% { width: 70%; }
        }
        .welcome-banner .header-btn {
            margin-top: 1.5rem;
            background: #fff;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            border-radius: 8px;
            padding: 0.7em 1.7em;
            font-weight: 700;
            font-size: 1.08rem;
            box-shadow: 0 2px 8px rgba(37,99,235,0.10);
            transition: background 0.2s, color 0.2s, border 0.2s, transform 0.2s;
            z-index: 2;
            position: relative;
        }
        .welcome-banner .header-btn:hover {
            background: var(--primary-color);
            color: #fff;
            border: 2px solid var(--primary-color);
            transform: translateY(-2px) scale(1.04);
        }
        .agent-quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }
        .agent-action-card {
            background: #fff;
            border-radius: 15px;
            padding: 1.5rem 1.2rem;
            box-shadow: 0 4px 6px -1px rgba(37,99,235,0.08), 0 2px 4px -1px rgba(37,99,235,0.04);
            transition: box-shadow 0.2s, transform 0.2s;
            cursor: pointer;
            text-decoration: none;
            color: var(--primary-color);
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            min-height: 160px;
        }
        .agent-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px -3px rgba(37,99,235,0.13), 0 4px 6px -2px rgba(37,99,235,0.08);
            color: var(--secondary-color);
        }
        .agent-action-icon {
            width: 48px;
            height: 48px;
            background: var(--grey-bg);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
            font-size: 1.7rem;
            color: var(--primary-color);
        }
        .agent-action-title {
            font-size: 1.15rem;
            font-weight: 700;
            margin-bottom: 0.4rem;
            color: var(--primary-color);
        }
        .agent-action-desc {
            font-size: 0.97rem;
            color: #64748b;
            font-weight: 400;
        }
        .chart-card {
            background: linear-gradient(135deg, #f0f6ff 0%, #e9f3fa 100%);
            border-radius: 28px;
            box-shadow: 0 4px 24px rgba(37,99,235,0.13), 0 1.5px 6px rgba(16,185,129,0.07);
            border: 1.5px solid #e0e7ef;
            padding: 1.8rem 1.5rem 2rem 1.5rem;
            margin-left: 0;
            transition: box-shadow 0.22s, transform 0.22s, background 0.22s;
            position: relative;
        }
        .chart-card:hover {
            box-shadow: 0 8px 32px rgba(37,99,235,0.18), 0 2px 8px rgba(16,185,129,0.10);
            background: linear-gradient(135deg, #e0f2fe 0%, #f0f6ff 100%);
            transform: translateY(-4px) scale(1.03);
        }
        .chart-card .chart-title {
            font-size: 1.35rem;
            font-weight: 800;
            color: #2563eb;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .chart-card .accent-bar {
            display: inline-block;
            width: 6px;
            height: 28px;
            background: linear-gradient(180deg, #2563eb 0%, #38bdf8 100%);
            border-radius: 4px;
            margin-right: 0.7rem;
        }
        .chart-card .chart-desc {
            color: #64748b;
            font-size: 0.98rem;
            margin-bottom: 1.2rem;
        }
        .chart-area-bg {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 1.5px 6px rgba(37,99,235,0.06);
            padding: 1.1rem 0.5rem 0.5rem 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .stat-cards-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.2rem;
        }
        .stat-card {
            background: linear-gradient(135deg, #fff 0%, #f4f8fb 100%);
            border-radius: 22px;
            box-shadow: 0 2px 12px rgba(37,99,235,0.07);
            padding: 1.5rem 1rem 1.2rem 1rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: box-shadow 0.2s, transform 0.2s, background 0.2s;
            min-height: 120px;
        }
        .stat-card:hover {
            box-shadow: 0 6px 24px rgba(37,99,235,0.13);
            background: #e9f3fa;
            transform: translateY(-4px) scale(1.03);
        }
        .stat-icon {
            font-size: 2.2rem;
            border-radius: 12px;
            padding: 0.6em;
            margin-bottom: 0.3em;
        }
        .stat-title {
            font-size: 1.08rem;
            color: #64748b;
            font-weight: 700;
        }
        .stat-value {
            font-size: 1.7rem;
            font-weight: 800;
            color: #2563eb;
        }
        @media (max-width: 991px) {
            .stat-cards-grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        @media (max-width: 600px) {
            .stat-cards-grid {
                grid-template-columns: 1fr;
            }
            .agent-quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <!-- 1. Header: Welcome Banner (Full Width) -->
    <div class="container-fluid px-4 py-3">
        <div class="tile tile-full welcome-banner mb-4 animate__animated animate__fadeInDown position-relative">
            <div class="row align-items-center position-relative" style="z-index:2;">
                <div class="col-md-8">
                    <div class="header-title mb-1">
                        Welcome back, <span class="header-username">${user.firstName}</span>!
                    </div>
                    <span class="header-title-underline"></span>
                    <div class="header-subtitle mb-2">Ready to close your next deal? Your dashboard is here to help you succeed every day.</div>
                    <div class="header-tip" id="headerTip">Did you know? <b>Updating your listings regularly</b> increases your chances of getting more client inquiries!</div>
                    <div class="header-progress">
                        <div class="header-progress-bar"></div>
                    </div>
                    <button class="header-btn" onclick="window.location.href='${pageContext.request.contextPath}/agent/manage-properties'">Let's get started!</button>
                </div>
                <div class="col-md-4 text-md-end">
                    <span class="h3 mb-0">Today</span>
                </div>
            </div>
        </div>

        <!-- Quick Links: Attractive Card Grid -->
        <div class="agent-quick-actions">
            <a href="${pageContext.request.contextPath}/agent/dashboard" class="agent-action-card">
                <div class="agent-action-icon" style="background:#eaf4fb;"><i class="fas fa-home"></i></div>
                <div class="agent-action-title">Dashboard</div>
                <div class="agent-action-desc">Overview of your activity and stats</div>
            </a>
            <a href="${pageContext.request.contextPath}/agent/manage-properties" class="agent-action-card">
                <div class="agent-action-icon" style="background:#eaf4fb;"><i class="fas fa-building"></i></div>
                <div class="agent-action-title">Manage Properties</div>
                <div class="agent-action-desc">Add, edit, or remove your property listings</div>
            </a>
            <a href="${pageContext.request.contextPath}/agent/appointments" class="agent-action-card">
                <div class="agent-action-icon" style="background:#eaf4fb;"><i class="fas fa-calendar-check"></i></div>
                <div class="agent-action-title">Appointments</div>
                <div class="agent-action-desc">View and manage your appointments</div>
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="agent-action-card">
                <div class="agent-action-icon" style="background:#eaf4fb;"><i class="fas fa-user"></i></div>
                <div class="agent-action-title">Profile</div>
                <div class="agent-action-desc">Update your profile and preferences</div>
            </a>
        </div>

        <!-- Pie Chart and Stat Cards Row -->
        <%
        // Prepare property type chart data for the pie chart
        List propertyTypeDist = (List) request.getAttribute("propertyTypeDist");
        StringBuilder propertyTypeLabels = new StringBuilder();
        StringBuilder propertyTypeCounts = new StringBuilder();
        if (propertyTypeDist != null) {
            for (int i = 0; i < propertyTypeDist.size(); i++) {
                Object[] row = (Object[]) propertyTypeDist.get(i);
                if (i > 0) {
                    propertyTypeLabels.append(", ");
                    propertyTypeCounts.append(", ");
                }
                propertyTypeLabels.append("\"" + (row[0] != null ? row[0].toString().replace("_", " ") : "Unknown") + "\"");
                propertyTypeCounts.append(row[1]);
            }
        }
    %>
        <div id="statsSection" class="row mb-4 align-items-stretch">
            <div class="col-12 col-lg-5 d-flex">
                <div class="chart-card h-100 w-100" style="max-width: 480px; min-width: 260px;">
                    <div class="chart-title mb-2">
                        <span class="accent-bar"></span>
                        <span><i class="fas fa-chart-pie me-2"></i>Property Types Distribution</span>
                    </div>
                    <div class="chart-desc mb-3">Visual breakdown of all property types currently listed by you</div>
                    <div class="chart-area-bg">
                        <canvas id="propertyTypeChart" height="220"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-12 col-lg-7 d-flex flex-column justify-content-center">
                <div class="stat-cards-grid">
                    <div class="stat-card">
                        <span class="stat-icon" style="background: #f0f6ff;"><i class="fas fa-list-alt text-primary"></i></span>
                        <span class="stat-title">Total Properties</span>
                        <span class="stat-value">${AllProperties != null ? AllProperties.size() : 0}</span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-icon" style="background: #e6f9ec;"><i class="fas fa-bolt text-success"></i></span>
                        <span class="stat-title">Active Listings</span>
                        <span class="stat-value">${AllProperties != null ? AllProperties.stream().filter(p -> p.status.name() == 'AVAILABLE').count() : 0}</span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-icon" style="background: #ffe0e0;"><i class="fas fa-check-circle text-danger"></i></span>
                        <span class="stat-title">Properties Sold</span>
                        <span class="stat-value">${AllProperties != null ? AllProperties.stream().filter(p -> p.status.name() == 'SOLD').count() : 0}</span>
                    </div>
                    <div class="stat-card">
                        <span class="stat-icon" style="background: #fffbe0;"><i class="fas fa-star text-warning"></i></span>
                        <span class="stat-title">Customer Ratings</span>
                        <span class="stat-value stat-stars">
                            <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star-half-alt"></i> 4.5
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <!-- Chatbot Button -->
    <div class="chatbot-button" id="chatbotButton">
        <i class="fas fa-comments"></i>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var propertyTypeLabels = JSON.parse('<%= propertyTypeLabels.length() > 0 ? "[" + propertyTypeLabels.toString() + "]" : "[]" %>');
            var propertyTypeCounts = JSON.parse('<%= propertyTypeCounts.length() > 0 ? "[" + propertyTypeCounts.toString() + "]" : "[]" %>');

            const propertyTypeChart = new Chart(document.getElementById('propertyTypeChart'), {
                type: 'pie',
                data: {
                    labels: propertyTypeLabels,
                    datasets: [{
                        data: propertyTypeCounts,
                        backgroundColor: [
                            '#2563eb', '#10b981', '#38bdf8', '#64748b', '#ffe066', '#ff6f61', '#6f42c1', '#fd7e14', '#20c997', '#adb5bd'
                        ],
                    }]
                },
                options: { plugins: { legend: { position: 'bottom' } } }
            });

            // Chatbot Button Click Handler
            document.getElementById('chatbotButton').addEventListener('click', function() {
                alert('Chatbot feature coming soon!');
            });

            // Rotating tips for header
            var tips = [
                "Did you know? <b>Updating your listings regularly</b> increases your chances of getting more client inquiries!",
                "Tip: <b>Respond to client inquiries quickly</b> to build trust and close deals faster!",
                "Pro tip: <b>High-quality photos</b> make your properties stand out!",
                "Did you know? <b>Scheduling open houses</b> can boost your property's visibility!"
            ];
            var tipIndex = 0;
            var tipElem = document.getElementById('headerTip');
            setInterval(function() {
                tipIndex = (tipIndex + 1) % tips.length;
                tipElem.innerHTML = tips[tipIndex];
            }, 5000);
        });
    </script>
</body>
</html> 