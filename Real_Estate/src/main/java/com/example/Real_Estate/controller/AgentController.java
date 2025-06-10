package com.example.Real_Estate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.Real_Estate.ServiceImpl.PropServiceImpl;
import com.example.Real_Estate.dto.PropertyDto;
//import com.example.Real_Estate.ServiceImpl.UServiceImpl;
import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.UserRole;

import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/agent")
public class AgentController {
	// @Autowired
	// private UServiceImpl u1;
	@Autowired
	private PropServiceImpl p1;
	@GetMapping("/agent-properties")
	public String agentMyProperties(HttpSession session, Model model) {
		User user = (User) session.getAttribute("user");
		if (user == null || user.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}
		
		List<Properties> properties = p1.findByEmail(user.getEmail());
		model.addAttribute("AllProperties", properties);
		model.addAttribute("user", user);
		return "agent-properties";
	}
	@RequestMapping("/dashboard")
	public String agentDashboard(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null || user.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}
		
		List<Properties> properties = p1.findAllProperties();
		model.addAttribute("AllProperties", properties);
		model.addAttribute("user", user);
		return "agent";
	}
	@RequestMapping("/manage-properties")
	public String properties(Model model, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null || user.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}
		
		List<Properties> properties = p1.findAllProperties();
		model.addAttribute("Properties", properties);
		session.setAttribute("Properties", properties);
		List<Properties> myProperties = p1.findByEmail(user.getEmail());
		model.addAttribute("MyProperties", myProperties);
		model.addAttribute("user", user);
		return "manage-properties";
	}
	@PostMapping("/properties/add")
	public String addProperty(@ModelAttribute Properties p, HttpSession session) {
		User loggedInUser = (User) session.getAttribute("user");
		
		if (loggedInUser == null || loggedInUser.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}
		
		p.setUser_id(loggedInUser);
		p1.add(p);
		return "redirect:/agent/manage-properties";
	}
	@PostMapping("/properties/filter")
	public String filter(@ModelAttribute PropertyDto propertyDto, Model model, HttpSession session, HttpServletRequest request) {
		User user = (User) session.getAttribute("user");
		if (user == null || user.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}

		List<Properties> filteredProperties = p1.findByFilter(propertyDto);
		model.addAttribute("Properties", filteredProperties);
		session.setAttribute("Properties", filteredProperties);
		
		// Also add MyProperties to maintain consistency
		List<Properties> myProperties = p1.findByEmail(user.getEmail());
		model.addAttribute("MyProperties", myProperties);
		model.addAttribute("user", user);
		
		return "manage-properties";
	}
}
