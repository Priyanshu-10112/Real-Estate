package com.example.Real_Estate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

//import com.example.Real_Estate.ServiceImpl.PropServiceImpl;
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
}
