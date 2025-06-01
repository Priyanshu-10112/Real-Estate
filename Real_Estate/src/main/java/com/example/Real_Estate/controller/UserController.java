package com.example.Real_Estate.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.Real_Estate.ServiceImpl.PropServiceImpl;
import com.example.Real_Estate.ServiceImpl.UServiceImpl;
import com.example.Real_Estate.dto.PropertyDto;
import com.example.Real_Estate.entity.Properties;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UServiceImpl us;
	@Autowired
	private PropServiceImpl ps;
	@RequestMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		List<Properties> properties = ps.findAllProperties();
		session.setAttribute("Properties", properties);
		model.addAttribute("Properties", properties);
		return "dashboard";
	}
	@GetMapping("/property")
	@ResponseBody
	public String propertyDetail() {
		return "go"; // for ajax function
	}
	@RequestMapping("/property-details/{id}")
	public String showPropertyDetails(@PathVariable Long id,HttpSession session,Model model) {
		Properties p1=ps.findById(id);
		model.addAttribute("prop", p1);
	    return "property-details"; 
	}

	@GetMapping("/dashboard/filter")
	public String filter(@ModelAttribute PropertyDto propertyDto, Model model, HttpSession session, HttpServletRequest request) {
		List<Properties> filteredProperties = ps.findByFilter(propertyDto);
		model.addAttribute("Properties", filteredProperties);
		session.setAttribute("Properties", filteredProperties);
		
		return "dashboard";
	}
}
