package com.example.Real_Estate.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.example.Real_Estate.ServiceImpl.UServiceImpl;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.UserRole;
import com.example.Real_Estate.util.EmailUtil;

@RestController
@RequestMapping("/api")
public class OTPController {
    private static final Logger logger = LoggerFactory.getLogger(OTPController.class);

    @Autowired
    private UServiceImpl userService;

    // In-memory storage for OTPs and pending registrations
    private static final Map<String, String> otpStore = new HashMap<>();
    private static final Map<String, User> pendingRegistrations = new HashMap<>();

    @PostMapping("/send-otp")
    public ResponseEntity<?> sendOTP(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        logger.info("Received registration request for email: {}", email);
        
        // Validate required fields
        if (email == null || email.trim().isEmpty()) {
            return ResponseEntity.badRequest().body(Map.of("message", "Email is required"));
        }

        // Check if email already exists
        if (userService.findByEmail(email) != null) {
            logger.warn("Email already registered: {}", email);
            return ResponseEntity.badRequest().body(Map.of("message", "Email already registered"));
        }

        // Store the registration data
        User user = new User();
        user.setEmail(email);
        user.setFirstName(request.get("firstName"));
        user.setLastName(request.get("lastName"));
        user.setPassword(request.get("password"));
        user.setPhoneNumber(request.get("phoneNumber"));
        
        // Set default role if not provided
        String role = request.get("ur");
        if (role == null || role.trim().isEmpty()) {
            user.setUr(UserRole.USER); // Default role
        } else {
            try {
                user.setUr(UserRole.valueOf(role));
            } catch (IllegalArgumentException e) {
                logger.warn("Invalid role provided: {}. Using default role USER", role);
                user.setUr(UserRole.USER);
            }
        }

        // Log the user data being stored
        logger.info("Storing registration data: {}", user);
        pendingRegistrations.put(email, user);

        // Generate 6-digit OTP
        String otp = String.format("%06d", new Random().nextInt(1000000));
        otpStore.put(email, otp);
        logger.info("Generated OTP for email: {}", email);

        // Send OTP via email
        try {
            String subject = "Your OTP for EstateAura Registration";
            String body = "Your OTP for registration is: " + otp + "\n\nThis OTP is valid for 10 minutes.\n\nIf you didn't request this OTP, please ignore this email.";
            EmailUtil.sendEmail(email, subject, body);
            logger.info("Successfully sent OTP to email: {}", email);
            return ResponseEntity.ok(Map.of("message", "OTP sent successfully"));
        } catch (Exception e) {
            logger.error("Failed to send OTP to email: {}. Error: {}", email, e.getMessage(), e);
            otpStore.remove(email);
            pendingRegistrations.remove(email);
            return ResponseEntity.badRequest().body(Map.of("message", "Failed to send OTP. Please try again."));
        }
    }

    @PostMapping("/verify-otp")
    public ResponseEntity<?> verifyOTP(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String otp = request.get("otp");
        logger.info("Attempting to verify OTP for email: {}", email);

        String storedOTP = otpStore.get(email);
        if (storedOTP == null) {
            logger.warn("No OTP found for email: {}", email);
            return ResponseEntity.badRequest().body(Map.of("message", "No OTP found for this email"));
        }

        if (!storedOTP.equals(otp)) {
            logger.warn("Invalid OTP provided for email: {}", email);
            return ResponseEntity.badRequest().body(Map.of("message", "Invalid OTP"));
        }

        // Get the pending registration data
        User user = pendingRegistrations.get(email);
        if (user == null) {
            logger.warn("No pending registration found for email: {}", email);
            return ResponseEntity.badRequest().body(Map.of("message", "Registration data not found"));
        }

        // Log the user data before saving
        logger.info("Saving user data: {}", user);

        try {
            // Save the user
            User savedUser = userService.save(user);
            logger.info("Successfully registered user: {}", savedUser);

            // Clean up
            otpStore.remove(email);
            pendingRegistrations.remove(email);

            return ResponseEntity.ok(Map.of(
                "message", "Registration successful",
                "redirect", "/login"
            ));
        } catch (Exception e) {
            logger.error("Failed to register user with email: {}. Error: {}", email, e.getMessage(), e);
            return ResponseEntity.badRequest().body(Map.of("message", "Registration failed: " + e.getMessage()));
        }
    }
} 