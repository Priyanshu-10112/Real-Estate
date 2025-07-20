<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .footer {
        background: #2c3e50;
        color: white;
        padding: 4rem 0 2rem;
        position: relative;
    }
    .footer h4 {
        color: #3498db;
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
    }
    .footer p {
        color: #ecf0f1;
        line-height: 1.6;
        margin-bottom: 1.5rem;
    }
    .footer-links {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .footer-links li {
        margin-bottom: 1rem;
    }
    .footer-links a {
        color: #ecf0f1;
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-block;
    }
    .footer-links a:hover {
        color: #3498db;
        transform: translateX(5px);
    }
    .footer-contact {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .footer-contact li {
        color: #ecf0f1;
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
    }
    .footer-contact i {
        color: #3498db;
        margin-right: 1rem;
        width: 20px;
    }
    .social-links {
        display: flex;
        gap: 1.5rem;
        margin-top: 1.5rem;
    }
    .social-link {
        color: #ecf0f1;
        font-size: 1.5rem;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.1);
    }
    .social-link:hover {
        color: #3498db;
        transform: translateY(-3px);
        background: rgba(255, 255, 255, 0.2);
    }
    .footer-bottom {
        margin-top: 3rem;
        padding-top: 2rem;
        border-top: 1px solid rgba(255,255,255,0.1);
        text-align: center;
        color: #ecf0f1;
    }
    @media (max-width: 768px) {
        .footer {
            text-align: center;
        }
        .footer-contact li {
            justify-content: center;
        }
        .social-links {
            justify-content: center;
        }
    }
</style>
<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h4>EstateAura</h4>
                <p>Your trusted partner in finding the perfect property. We specialize in premium real estate and provide exceptional service to our clients.</p>
            </div>
            <div class="col-md-4">
                <h4>Quick Links</h4>
                <ul class="footer-links">
                    <li><a href="${pageContext.request.contextPath}/about">About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/privacy">Privacy Policy</a></li>
                    <li><a href="${pageContext.request.contextPath}/terms">Terms & Conditions</a></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h4>Contact Info</h4>
                <ul class="footer-contact">
                    <li><i class="fas fa-map-marker-alt"></i>325/11, Vijay nagar, Indore, MP</li>
                    <li><i class="fas fa-phone"></i>+91 9826000000</li>
                    <li><i class="fas fa-envelope"></i>priyanshusharma0152@gmail.com</li>
                </ul>
                <div class="social-links">
                    <a href="https://github.com/Priyanshu-10112" class="social-link" target="_blank" rel="noopener noreferrer">
                        <i class="fab fa-github"></i>
                    </a>
                    <a href="https://www.linkedin.com/in/priyanshu-sharma-13b629309/" class="social-link" target="_blank" rel="noopener noreferrer">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 EstateAura. All rights reserved.</p>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> 