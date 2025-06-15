package com.example.Real_Estate.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
	public String addProperty(@ModelAttribute Properties p, 
							@RequestParam("propertyImage") MultipartFile file,
							HttpSession session,
							Model model) {
		User loggedInUser = (User) session.getAttribute("user");
		
		if (loggedInUser == null || loggedInUser.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}
		
		try {
			if (file.isEmpty()) {
				model.addAttribute("error", "Please select an image file");
				return "redirect:/agent/manage-properties?error=no_image";
			}

			// Generate unique filename
			String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
			
			// Create directory if it doesn't exist
			String uploadDir = "src/main/webapp/images/properties/";
			File dir = new File(uploadDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			
			// Save file
			Path filePath = Paths.get(uploadDir + fileName);
			Files.write(filePath, file.getBytes());
			
			// Set image filename in property object
			p.setImage(fileName);
			
			// Save property
			p.setUser_id(loggedInUser);
			Properties savedProperty = p1.add(p);
			
			if (savedProperty != null) {
				return "redirect:/agent/manage-properties?success=true";
			} else {
				return "redirect:/agent/manage-properties?error=save_failed";
			}
		} catch (IOException e) {
			e.printStackTrace();
			return "redirect:/agent/manage-properties?error=upload";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/agent/manage-properties?error=unknown";
		}
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

	@RequestMapping("/properties/delete/{id}")
	public String deleteProperty(@PathVariable Long id, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user == null || user.getUr() != UserRole.AGENT) {
			return "redirect:/login";
		}

		// Get the property to verify ownership
		Properties property = p1.findById(id);
		if (property != null && property.getUser_id().getEmail().equals(user.getEmail())) {
			p1.deleteById(id);
		}

		return "redirect:/agent/agent-properties";
	}
}
