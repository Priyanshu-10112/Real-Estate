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

import jakarta.servlet.http.HttpSession;

@Controller
public class ViewController {
	@Autowired
	private UServiceImpl u1;
	
	
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
	@GetMapping("/login")
	public String login(Model model) {
		return "login";
	}
	@PostMapping("/log")
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
		model.addAttribute("ur",u.getUr().name().toLowerCase());
		return "profile";
	}
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		return "login";
	}
}
