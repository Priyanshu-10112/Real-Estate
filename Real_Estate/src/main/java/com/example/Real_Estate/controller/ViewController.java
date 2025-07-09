package com.example.Real_Estate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import java.util.HashMap;
import java.util.Map;

import com.example.Real_Estate.ServiceImpl.UServiceImpl;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.UserRole;
import com.example.Real_Estate.Services.AppointmentService;
import com.example.Real_Estate.entity.Appointment;
import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.repository.PropertiesRepository;

import jakarta.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ViewController {
	@Autowired
	private UServiceImpl u1;
	
	@Autowired
	private AppointmentService appointmentService;
	
	@Autowired
	private PropertiesRepository propertiesRepository;
	
	// @Autowired
	// private PropServiceImpl p1;

	@RequestMapping("/")
	public String index() {
		return "index";
	}
	@RequestMapping("/about")
	public String about() {
		return "about";
	}
	@RequestMapping("/contact")
	public String contact() {
		return "contact";
	}
	@RequestMapping("/login")
	public String login(Model model) {
		return "login";
	}
	@RequestMapping("/log")
	public String log(@RequestParam String email,
					 @RequestParam String password,
					 HttpSession session,
					 Model model) {
		User u = u1.login(email, password);
		if(u != null ) {
			session.setAttribute("user", u);
			if(UserRole.USER == u.getUr()) return "redirect:/user/dashboard";
			else if(UserRole.AGENT == u.getUr()) return "redirect:/agent/dashboard";
		}
		
		model.addAttribute("error", "Invalid email or password. Please try again.");
		model.addAttribute("email", email);
//		model.addAttribute("userType", u.getUr());
		return "login";
	}
	@PostMapping("/regis")
	public String regis(@ModelAttribute User user) {
		u1.save(user);
		return "redirect:/login";
	}
	@RequestMapping("/register")
	public String register() {
		return "register";
	}
	@RequestMapping("/properties")
	public String Property() {
		return "properties";
	}
	@GetMapping("/profile")
	public String profile(HttpSession session,Model model) {
		User u=(User)session.getAttribute("user");
		if(u==null)return "redirect:/login";
		model.addAttribute("ur",u.getUr().name().toLowerCase());
		return "profile";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	@RequestMapping("/notifications")
	public String notifications(HttpSession session, Model model) {
		User loggedInUser = (User) session.getAttribute("user");
		if (loggedInUser == null) {
			return "redirect:/login";
		}
		// Get user's active (non-dismissed) notifications
		List<Appointment> notifications = appointmentService.getActiveNotificationsByUser(loggedInUser);
		model.addAttribute("notifications", notifications);
		model.addAttribute("user", loggedInUser);
		return "notifications";
	}
	
	@RequestMapping("/property-details")
	public String propertyDetails(@RequestParam Long id, Model model, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("user");
		if (loggedInUser == null) {
			return "redirect:/login";
		}
		
		// Get property details by ID
		Properties property = propertiesRepository.findById(id).orElse(null);
		if (property == null) {
			return "redirect:/properties";
		}
		
		model.addAttribute("prop", property);
		model.addAttribute("user", loggedInUser);
		return "property-details";
	}
	
	@GetMapping("/agent/appointments")
	public String agentAppointments(Model model, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("user");
		if (loggedInUser == null || loggedInUser.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}
		List<Appointment> appointments = appointmentService.getAppointmentsByAgent(loggedInUser);
		model.addAttribute("appointments", appointments);
		return "appointments";
	}
	@GetMapping("/profile/change-password")
	public String showChangePasswordPage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		return "change-password";
	}
	@PostMapping("/profile/change-password")
	public String changePassword(
			@RequestParam("currentPassword") String currentPassword,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("confirmPassword") String confirmPassword,
			HttpSession session,
			Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		// Validate current password
		if (!user.getPassword().equals(currentPassword)) {
			model.addAttribute("error", "Current password is incorrect.");
			return "change-password";
		}
		// Validate new password match
		if (!newPassword.equals(confirmPassword)) {
			model.addAttribute("error", "New passwords do not match.");
			return "change-password";
		}
		// Update password
		user.setPassword(newPassword);
		u1.save(user); // Save updated user
		session.setAttribute("user", user); // Update session
		model.addAttribute("success", "Password changed successfully.");
		return "change-password";
	}
	@GetMapping("/profile/edit")
	public String showEditProfilePage(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		model.addAttribute("user", user);
		return "edit-profile";
	}
	@PostMapping("/profile/edit")
	public String editProfile(
			@RequestParam("firstName") String firstName,
			@RequestParam("lastName") String lastName,
			@RequestParam("phoneNumber") String phoneNumber,
			HttpSession session,
			Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login";
		}
		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setPhoneNumber(phoneNumber);
		u1.save(user); // Save updated user
		session.setAttribute("user", user); // Update session
		model.addAttribute("user", user);
		model.addAttribute("success", "Profile updated successfully.");
		return "profile";
	}

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage() {
        return "forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email, Model model) {
        User user = u1.findByEmail(email);
        if (user == null) {
            model.addAttribute("error", "No account found with that email address.");
            return "forgot-password";
        }
        // TODO: Trigger OTP for password reset (to be implemented in OTPController or service)
        // For now, just show a success message
        model.addAttribute("success", "If this email is registered, an OTP has been sent to your email address.");
        return "forgot-password";
    }

    @GetMapping("/verify-reset-otp")
    public String showVerifyResetOtpPage() {
        return "verify-reset-otp";
    }

    @PostMapping("/verify-reset-otp")
    public String handleVerifyResetOtp(@RequestParam("email") String email,
                                       @RequestParam("otp") String otp,
                                       @RequestParam("newPassword") String newPassword,
                                       @RequestParam("confirmPassword") String confirmPassword,
                                       Model model) {
        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            return "verify-reset-otp";
        }
        // Call OTPController's /api/verify-reset-otp endpoint
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:8080/api/verify-reset-otp";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        Map<String, String> requestBody = new HashMap<>();
        requestBody.put("email", email);
        requestBody.put("otp", otp);
        HttpEntity<Map<String, String>> request = new HttpEntity<>(requestBody, headers);
        try {
            ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                // OTP verified, update password
                User user = u1.findByEmail(email);
                if (user == null) {
                    model.addAttribute("error", "No account found with that email address.");
                    return "verify-reset-otp";
                }
                user.setPassword(newPassword);
                u1.save(user);
                model.addAttribute("success", "Password reset successful. You may now <a href='" + 
                    "login' style='color:#3498db;'>login</a>.");
                return "verify-reset-otp";
            } else {
                model.addAttribute("error", response.getBody().get("message"));
                return "verify-reset-otp";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Invalid OTP or server error. Please try again.");
            return "verify-reset-otp";
        }
    }
}
