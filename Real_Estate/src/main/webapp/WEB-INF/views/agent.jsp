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
            --primary-color: #2563eb; /* A vibrant blue for main elements */
            --secondary-color: #1e40af; /* A darker blue for accents */
            --accent-color: #3b82f6; /* A lighter blue for highlights */
            --success-color: #10b981; /* Green for success states */
            --warning-color: #f59e0b; /* Orange for warnings */
            --danger-color: #ef4444; /* Red for errors/danger */
            --info-color: #38bdf8; /* Light blue for info */
            --light-bg: #f8fafc; /* Very light grey for backgrounds */
            --dark-text: #1e293b; /* Dark grey for main text */
            --light-text: #ffffff; /* White for text on dark backgrounds */
            --card-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06); /* Subtle shadow for cards */
            --hover-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05); /* Deeper shadow on hover */
            --transition: all 0.3s ease; /* Smooth transitions for interactive elements */
            --gradient-primary: linear-gradient(135deg, var(--primary-color), var(--secondary-color)); /* Gradient for hero/CTA */
        }

        body {
            background-color: var(--light-bg);
            font-family: 'Inter', sans-serif; /* Modern font */
            padding-top: 80px; /* Adjust based on actual navbar height */
        }

        /* Navigation Styles - Kept from nav-agent.jsp if present, or newcss.css */
        .navbar {
            background: white !important;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 0.8rem 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
            padding: 0.5rem 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--primary-color) !important;
            transition: all 0.3s ease;
        }

        .navbar-brand:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }

        .navbar-brand i {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

        .nav-link {
            color: var(--dark-text) !important;
            font-weight: 500;
            padding: 0.8rem 1.2rem !important;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.95rem;
            margin: 0 0.2rem;
            position: relative;
            overflow: hidden;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 2px;
            background: var(--primary-color);
            transition: width 0.3s ease;
        }

        .nav-link:hover {
            background: var(--light-bg);
            transform: translateY(-2px);
            color: var(--primary-color) !important;
        }

        .nav-link:hover::before {
            width: 80%;
        }

        .nav-link.active {
            background: var(--light-bg);
            font-weight: 600;
            color: var(--primary-color) !important;
        }

        .nav-link.active::before {
            width: 80%;
        }

        .nav-link i {
            font-size: 1.1rem;
            transition: transform 0.3s ease;
            color: var(--primary-color);
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .navbar-toggler {
            border: none;
            padding: 0.5rem;
            margin-right: 1rem;
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }

        .navbar-toggler-icon {
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba%2852, 152, 219, 0.9%29' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
        }

        @media (max-width: 991.98px) {
            .navbar-collapse {
                background: white;
                padding: 1rem;
                border-radius: 10px;
                margin-top: 1rem;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .nav-link {
                padding: 0.8rem 1rem !important;
                margin: 0.2rem 0;
            }

            .nav-link::before {
                display: none;
            }
        }

        /* Agent Dashboard Specific Styles (inspired by dashboard.jsp) */
        .dashboard-container {
            padding-top: 2rem; /* Add padding for the overall dashboard content below navbar */
        }

        .agent-dashboard-header {
            background: var(--gradient-primary);
            border-radius: 20px;
            padding: 2.5rem;
            color: white;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            margin-top: 20px; /* Spacing below navbar */
        }

        .agent-dashboard-header::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(30%, -30%);
            z-index: 0;
        }

        .header-content {
            position: relative;
            z-index: 1;
        }

        .header-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
        }

        .header-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 1.5rem;
        }

        .header-stats {
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
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
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
            display: flex;
            flex-direction: column;
            align-items: flex-start;
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

        /* General Card Styles for consistency */
        .card {
            background: white;
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
            border: none;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            height: 100%; /* Ensure cards in a row have equal height */
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }

        .card-title-custom {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .card-icon {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

        /* Specific styles for lists within cards */
        .list-group-item {
            border: none;
            padding: 0.75rem 0;
            background-color: transparent;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--dark-text);
        }
        .list-group-item:last-child {
            border-bottom: none;
        }

        .list-item-icon {
            color: var(--primary-color);
            font-size: 1.1rem;
        }

        .list-item-text {
            flex-grow: 1;
            font-size: 0.95rem;
        }

        .list-item-meta {
            font-size: 0.85rem;
            color: #64748b;
        }

        .badge-custom {
            padding: 0.4em 0.8em;
            border-radius: 1rem;
            font-weight: 600;
            font-size: 0.75rem;
        }
        .badge-success { background-color: rgba(16, 185, 129, 0.15); color: var(--success-color); }
        .badge-info { background-color: rgba(59, 130, 246, 0.15); color: var(--accent-color); }
        .badge-warning { background-color: rgba(245, 158, 11, 0.15); color: var(--warning-color); }

        /* Chart container */
        .chart-container {
            background: white;
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            margin-bottom: 2rem;
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

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .agent-dashboard-header {
                padding: 1.5rem;
            }
            .header-title {
                font-size: 2rem;
            }
            .header-stats {
                grid-template-columns: 1fr;
            }
            .quick-actions {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/nav-agent.jsp" />

    <div class="dashboard-container container">
        <!-- Agent Dashboard Header -->
        <section class="agent-dashboard-header">
            <div class="header-content">
                <h1 class="header-title">Welcome back, Agent ${user.firstName}!</h1>
                <p class="header-subtitle">Your personalized overview of listings, leads, and performance.</p>
                <div class="header-stats">
                    <div class="stat-card">
                        <div class="stat-value">25</div>
                        <div class="stat-label">Total Listings</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">7</div>
                        <div class="stat-label">Active Leads</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">3</div>
                        <div class="stat-label">Properties Sold (Month)</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-value">₹8.2 Cr</div>
                        <div class="stat-label">Sales Volume (Month)</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Quick Actions -->
        <section class="quick-actions">
            <a href="${pageContext.request.contextPath}/agent/agent-properties" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h3 class="action-title">Add New Property</h3>
                <p class="action-description">Quickly list a new property for sale or rent.</p>
            </a>
            <a href="${pageContext.request.contextPath}/agent/manage-properties" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-list-alt"></i>
                </div>
                <h3 class="action-title">Manage My Listings</h3>
                <p class="action-description">View, edit, and update your current properties.</p>
            </a>
            <a href="${pageContext.request.contextPath}/agent/leads" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3 class="action-title">View Client Inquiries</h3>
                <p class="action-description">Respond to potential buyers and renters.</p>
            </a>
            <a href="${pageContext.request.contextPath}/agent/appointments" class="action-card">
                <div class="action-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h3 class="action-title">Schedule Appointments</h3>
                <p class="action-description">Manage your property showings and meetings.</p>
            </a>
        </section>

        <div class="row">
            <!-- Recent Activity/Notifications -->
            <div class="col-lg-7">
                <div class="card">
                    <h2 class="card-title-custom"><i class="fas fa-bell card-icon"></i> Recent Activity</h2>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">
                            <i class="fas fa-comment-dots list-item-icon"></i>
                            <span class="list-item-text">New inquiry on <strong>Luxury Villa, Bandra</strong>.</span>
                            <span class="list-item-meta">2 mins ago</span>
                            <span class="badge badge-info badge-custom">New Lead</span>
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-calendar-plus list-item-icon"></i>
                            <span class="list-item-text">Appointment scheduled for <strong>Skyline Apartment</strong>.</span>
                            <span class="list-item-meta">1 hour ago</span>
                            <span class="badge badge-success badge-custom">Confirmed</span>
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-edit list-item-icon"></i>
                            <span class="list-item-text">You updated <strong>Green Valley Home</strong> details.</span>
                            <span class="list-item-meta">Yesterday</span>
                            <span class="badge badge-info badge-custom">Update</span>
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-star list-item-icon"></i>
                            <span class="list-item-text">New review for your profile.</span>
                            <span class="list-item-meta">2 days ago</span>
                            <span class="badge badge-warning badge-custom">Review</span>
                        </li>
                        <li class="list-group-item">
                            <i class="fas fa-chart-bar list-item-icon"></i>
                            <span class="list-item-text"><strong>Luxury Villa</strong> views increased by 15%.</span>
                            <span class="list-item-meta">3 days ago</span>
                            <span class="badge badge-success badge-custom">Growth</span>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Performance Overview (Placeholder Chart or Stats) -->
            <div class="col-lg-5">
                <div class="card">
                    <h2 class="card-title-custom"><i class="fas fa-chart-area card-icon"></i> Performance Overview</h2>
                    <div style="position: relative; height: 250px;">
                        <canvas id="agentPerformanceChart"></canvas>
                    </div>
                    <div class="d-flex justify-content-around mt-4">
                        <div>
                            <h4 class="h5 text-primary">Leads Converted</h4>
                            <p class="fs-4 fw-bold text-center">60%</p>
                        </div>
                        <div>
                            <h4 class="h5 text-primary">Avg. Time to Close</h4>
                            <p class="fs-4 fw-bold text-center">45 days</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Market Insights for Agents -->
        <div class="card mb-4">
            <h2 class="card-title-custom"><i class="fas fa-chart-bar card-icon"></i> Market Insights for You</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="stat-box">
                        <div class="stat-icon"><i class="fas fa-money-bill-wave"></i></div>
                        <div class="stat-title">Avg. Listing Price</div>
                        <div class="stat-value">₹55.8L</div>
                        <p class="text-success small"><i class="fas fa-arrow-up"></i> 7% from last month</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-box">
                        <div class="stat-icon"><i class="fas fa-house-damage"></i></div>
                        <div class="stat-title">Avg. Days on Market</div>
                        <div class="stat-value">32</div>
                        <p class="text-danger small"><i class="fas fa-arrow-down"></i> 5 days less</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-box">
                        <div class="stat-icon"><i class="fas fa-chart-pie"></i></div>
                        <div class="stat-title">Market Share (Local)</div>
                        <div class="stat-value">18%</div>
                        <p class="text-info small"><i class="fas fa-arrow-up"></i> 1% increase</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Hot Properties / Recommendations for Agents -->
        <div class="card mb-4">
            <h2 class="card-title-custom"><i class="fas fa-fire card-icon"></i> Hot Properties for You</h2>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="card action-card">
                        <img src="https://images.unsplash.com/photo-1570129476815-ba6110f031f0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60" class="card-img-top" alt="Property Image" style="border-radius: 15px;">
                        <div class="card-body">
                            <h5 class="card-title">Modern City Apartment</h5>
                            <p class="card-text text-primary fw-bold">₹1.2 Cr</p>
                            <div class="d-flex justify-content-between text-muted small">
                                <span><i class="fas fa-bed"></i> 3 Beds</span>
                                <span><i class="fas fa-bath"></i> 2 Baths</span>
                                <span><i class="fas fa-ruler-combined"></i> 1500 sqft</span>
                            </div>
                            <a href="#" class="btn btn-sm btn-outline-primary mt-3">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="card action-card">
                        <img src="https://images.unsplash.com/photo-1560518883-ff51f81c96a7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60" class="card-img-top" alt="Property Image" style="border-radius: 15px;">
                        <div class="card-body">
                            <h5 class="card-title">Spacious Suburban Home</h5>
                            <p class="card-text text-primary fw-bold">₹85 Lac</p>
                            <div class="d-flex justify-content-between text-muted small">
                                <span><i class="fas fa-bed"></i> 4 Beds</span>
                                <span><i class="fas fa-bath"></i> 3 Baths</span>
                                <span><i class="fas fa-ruler-combined"></i> 2200 sqft</span>
                            </div>
                            <a href="#" class="btn btn-sm btn-outline-primary mt-3">View Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="card action-card">
                        <img src="https://images.unsplash.com/photo-1580582932707-52054a37397b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=60" class="card-img-top" alt="Property Image" style="border-radius: 15px;">
                        <div class="card-body">
                            <h5 class="card-title">Cozy Family Villa</h5>
                            <p class="card-text text-primary fw-bold">₹95 Lac</p>
                            <div class="d-flex justify-content-between text-muted small">
                                <span><i class="fas fa-bed"></i> 3 Beds</span>
                                <span><i class="fas fa-bath"></i> 2 Baths</span>
                                <span><i class="fas fa-ruler-combined"></i> 1800 sqft</span>
                            </div>
                            <a href="#" class="btn btn-sm btn-outline-primary mt-3">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Upcoming Appointments -->
        <div class="card mb-4">
            <h2 class="card-title-custom"><i class="fas fa-calendar-alt card-icon"></i> Upcoming Appointments</h2>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <i class="fas fa-house-damage list-item-icon"></i>
                    <span class="list-item-text">Showing for <strong>Ocean Breeze Villa</strong> with John Doe.</span>
                    <span class="list-item-meta">Today, 3:00 PM</span>
                    <span class="badge badge-success badge-custom">Confirmed</span>
                </li>
                <li class="list-group-item">
                    <i class="fas fa-user-tie list-item-icon"></i>
                    <span class="list-item-text">Meeting with new client Jane Smith.</span>
                    <span class="list-item-meta">Tomorrow, 10:00 AM</span>
                    <span class="badge badge-info badge-custom">New Client</span>
                </li>
                <li class="list-group-item">
                    <i class="fas fa-file-invoice-dollar list-item-icon"></i>
                    <span class="list-item-text">Closing on <strong>Park View Condo</strong>.</span>
                    <span class="list-item-meta">25th October, 11:30 AM</span>
                    <span class="badge badge-warning badge-custom">Closing</span>
                </li>
            </ul>
        </div>

        <!-- Client Feedback/Reviews -->
        <div class="card mb-4">
            <h2 class="card-title-custom"><i class="fas fa-star card-icon"></i> Client Feedback</h2>
            <div class="list-group list-group-flush">
                <div class="list-group-item">
                    <div class="d-flex w-100 justify-content-between align-items-center">
                        <h5 class="mb-1">Excellent Service!</h5>
                        <small class="text-muted">5 days ago</small>
                    </div>
                    <p class="mb-1">"Agent ${user.lastName} was incredibly helpful throughout the entire process. Highly recommended!"</p>
                    <small class="text-success">- Happy Client</small>
                </div>
                <div class="list-group-item">
                    <div class="d-flex w-100 justify-content-between align-items-center">
                        <h5 class="mb-1">Professional and Prompt</h5>
                        <small class="text-muted">1 week ago</small>
                    </div>
                    <p class="mb-1">"Quick responses and great negotiation skills. Found us our dream home!"</p>
                    <small class="text-success">- Satisfied Buyer</small>
                </div>
            </div>
        </div>

        <!-- Recent Leads/Inquiries -->
        <div class="card mb-4">
            <h2 class="card-title-custom"><i class="fas fa-headset card-icon"></i> Recent Leads/Inquiries</h2>
            <ul class="list-group list-group-flush">
                <li class="list-group-item">
                    <i class="fas fa-user-tag list-item-icon"></i>
                    <span class="list-item-text">New lead: **Ravi Sharma** interested in commercial properties.</span>
                    <span class="list-item-meta">Just now</span>
                    <span class="badge badge-info badge-custom">New</span>
                </li>
                <li class="list-group-item">
                    <i class="fas fa-reply list-item-icon"></i>
                    <span class="list-item-text">Reply sent to **Priya Singh** regarding apartment in Powai.</span>
                    <span class="list-item-meta">30 mins ago</span>
                    <span class="badge badge-success badge-custom">Follow Up</span>
                </li>
                <li class="list-group-item">
                    <i class="fas fa-phone-alt list-item-icon"></i>
                    <span class="list-item-text">Call with **Amit Kumar** for pre-approval consultation.</span>
                    <span class="list-item-meta">2 hours ago</span>
                    <span class="badge badge-warning badge-custom">Call</span>
                </li>
            </ul>
        </div>

        <!-- Resources & Quick Links -->
        <div class="card mb-4">
            <h2 class="card-title-custom"><i class="fas fa-link card-icon"></i> Resources & Quick Links</h2>
            <div class="row g-3">
                <div class="col-md-6 col-lg-4">
                    <a href="#" class="action-card p-3 d-flex align-items-center">
                        <div class="action-icon me-3" style="width: 40px; height: 40px; font-size: 1.2rem;"><i class="fas fa-file-alt"></i></div>
                        <div>
                            <h6 class="mb-0">Marketing Templates</h6>
                            <small class="text-muted">Download customizable flyers</small>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-4">
                    <a href="#" class="action-card p-3 d-flex align-items-center">
                        <div class="action-icon me-3" style="width: 40px; height: 40px; font-size: 1.2rem;"><i class="fas fa-calculator"></i></div>
                        <div>
                            <h6 class="mb-0">Mortgage Calculator</h6>
                            <small class="text-muted">Assist clients with estimates</small>
                        </div>
                    </a>
                </div>
                <div class="col-md-6 col-lg-4">
                    <a href="#" class="action-card p-3 d-flex align-items-center">
                        <div class="action-icon me-3" style="width: 40px; height: 40px; font-size: 1.2rem;"><i class="fas fa-book"></i></div>
                        <div>
                            <h6 class="mb-0">Agent Training Guides</h6>
                            <small class="text-muted">Enhance your real estate skills</small>
                        </div>
                    </a>
                </div>
            </div>
        </div>

    </div>

    <!-- Include Common Footer -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="${pageContext.request.contextPath}/js/navbar.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Agent Performance Chart (Example - replace with actual data)
            const ctxAgent = document.getElementById('agentPerformanceChart').getContext('2d');
            new Chart(ctxAgent, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Listings Added',
                        data: [5, 7, 6, 8, 9, 7],
                        backgroundColor: 'rgba(37, 99, 235, 0.7)',
                        borderColor: 'rgb(37, 99, 235)',
                        borderWidth: 1
                    }, {
                        label: 'Properties Sold',
                        data: [2, 3, 2, 4, 3, 5],
                        backgroundColor: 'rgba(16, 185, 129, 0.7)',
                        borderColor: 'rgb(16, 185, 129)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                color: '#1e293b'
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(255, 255, 255, 0.9)',
                            titleColor: '#1e293b',
                            bodyColor: '#64748b',
                            borderColor: '#e2e8f0',
                            borderWidth: 1,
                            padding: 10
                        }
                    },
                    scales: {
                        x: {
                            grid: {
                                display: false
                            },
                            ticks: {
                                color: '#64748b'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            },
                            ticks: {
                                color: '#64748b'
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html> 