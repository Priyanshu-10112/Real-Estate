<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <i class="fas fa-home"></i>
            <span>EstateAura</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/user/dashboard">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/properties">
                        <i class="fas fa-building"></i>
                        <span>Properties</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/about">
                        <i class="fas fa-info-circle"></i>
                        <span>About</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/contact">
                        <i class="fas fa-envelope"></i>
                        <span>Contact</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                        <i class="fas fa-user"></i>
                        <span>Profile</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<style>
    .navbar {
        background: white;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 0.5rem 0;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 1000;
    }
    .navbar-brand {
        font-size: 1.3rem;
        font-weight: 600;
        color: #2c3e50;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    .navbar-brand i {
        color: #3498db;
    }
    .navbar-brand span {
        color: #2c3e50;
    }
    .nav-link {
        color: #2c3e50 !important;
        font-weight: 500;
        padding: 0.4rem 0.7rem !important;
        transition: color 0.3s ease;
        white-space: nowrap;
        font-size: 0.9rem;
    }
    .nav-link:hover {
        color: #3498db !important;
    }
    .nav-link i {
        margin-right: 0.3rem;
        color: #3498db;
        font-size: 0.9rem;
    }
    .navbar-toggler {
        border: none;
        padding: 0.4rem;
    }
    .navbar-toggler:focus {
        box-shadow: none;
    }
    .navbar-toggler-icon {
        background-image: none;
        position: relative;
        width: 20px;
        height: 2px;
        background-color: #2c3e50;
        display: inline-block;
        vertical-align: middle;
    }
    .navbar-toggler-icon::before,
    .navbar-toggler-icon::after {
        content: '';
        position: absolute;
        width: 20px;
        height: 2px;
        background-color: #2c3e50;
        left: 0;
        transition: all 0.3s ease;
    }
    .navbar-toggler-icon::before {
        top: -5px;
    }
    .navbar-toggler-icon::after {
        bottom: -5px;
    }
    .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon {
        background-color: transparent;
    }
    .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon::before {
        transform: rotate(45deg);
        top: 0;
    }
    .navbar-toggler[aria-expanded="true"] .navbar-toggler-icon::after {
        transform: rotate(-45deg);
        bottom: 0;
    }
    @media (max-width: 991.98px) {
        .navbar-collapse {
            background: white;
            padding: 0.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            margin-top: 0.5rem;
            max-height: calc(100vh - 60px);
            overflow-y: auto;
        }
        .nav-link {
            padding: 0.5rem 0.7rem !important;
            border-radius: 5px;
        }
        .nav-link:hover {
            background: #f8f9fa;
        }
        .navbar-nav {
            margin-bottom: 0;
        }
    }
</style> 