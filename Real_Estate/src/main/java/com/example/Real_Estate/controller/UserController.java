package com.example.Real_Estate.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.example.Real_Estate.ServiceImpl.PropServiceImpl;
//import com.example.Real_Estate.ServiceImpl.UServiceImpl;
import com.example.Real_Estate.dto.PropertyDto;
import com.example.Real_Estate.entity.Properties;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserController {
//	@Autowired
//	private UServiceImpl us;
	@Autowired
	private PropServiceImpl ps;
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		
		return "dashboard";
	}
	@GetMapping("/properties")
	public String properties(HttpSession session, Model model) {
		List<Properties> properties = ps.findAllProperties();
		session.setAttribute("Properties", properties);
		model.addAttribute("Properties", properties);
		return "properties";
	}
	@PostMapping("/property")
	@ResponseBody
	public String propertyDetail() {
		return "go"; // for ajax function
	}
	@GetMapping("/property-details/{id}")
	public String showPropertyDetails(@PathVariable Long id,HttpSession session,Model model) {
		Properties p1=ps.findById(id);
		model.addAttribute("prop", p1);
	    return "property-details"; 
	}

	@PostMapping("/properties/filter")
	public String filter(@ModelAttribute PropertyDto propertyDto, Model model, HttpSession session, HttpServletRequest request) {
		List<Properties> filteredProperties = ps.findByFilter(propertyDto);
		model.addAttribute("Properties", filteredProperties);
		session.setAttribute("Properties", filteredProperties);
		
		return "properties";
	}
}
