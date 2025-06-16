package com.example.Real_Estate.controller;

import com.example.Real_Estate.Services.AppointmentService;
import com.example.Real_Estate.entity.Appointment;
import com.example.Real_Estate.entity.AppointmentStatus;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.repository.PropertiesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@Controller
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PropertiesRepository propertiesRepository;

    @PostMapping("/api/appointments")
    @ResponseBody
    public Appointment createAppointment(@RequestBody Appointment appointment, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            throw new RuntimeException("User not logged in");
        }

        if (appointment.getProperty() == null || appointment.getProperty().getId() == null) {
            throw new RuntimeException("Property ID is required");
        }

        // Fetch the property from database
        Properties property = propertiesRepository.findById(appointment.getProperty().getId())
            .orElseThrow(() -> new RuntimeException("Property not found with ID: " + appointment.getProperty().getId()));

        // Set the fetched property and user
        appointment.setProperty(property);
        appointment.setUser(loggedInUser);
        appointment.setStatus(AppointmentStatus.PENDING);

        return appointmentService.createAppointment(appointment);
    }

    @GetMapping("/agent/appointments")
    public String viewAppointments(Model model, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            return "redirect:/login";
        }

        List<Appointment> appointments = appointmentService.getAppointmentsByAgent(loggedInUser);
        model.addAttribute("appointments", appointments);
        return "appointments";
    }

    @PostMapping("/api/appointments/{id}/cancel")
    @ResponseBody
    public String cancelAppointment(@PathVariable Long id) {
        try {
            appointmentService.cancelAppointment(id);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    @PostMapping("/api/appointments/{id}/status")
    @ResponseBody
    public String updateAppointmentStatus(
            @PathVariable Long id,
            @RequestParam AppointmentStatus status) {
        try {
            appointmentService.updateAppointmentStatus(id, status);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    @GetMapping("/api/appointments/filter")
    @ResponseBody
    public List<Appointment> filterAppointments(
            @RequestParam(required = false) AppointmentStatus status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime endDate,
            HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        
        if (status != null) {
            return appointmentService.getAppointmentsByUserAndStatus(loggedInUser, status);
        } else if (startDate != null && endDate != null) {
            return appointmentService.getAppointmentsByUserAndDateRange(loggedInUser, startDate, endDate);
        }
        
        return appointmentService.getAppointmentsByUser(loggedInUser);
    }

    @PostMapping("/api/appointments/{id}/approve")
    @ResponseBody
    public ResponseEntity<?> approveAppointment(@PathVariable Long id) {
        try {
            Appointment appointment = appointmentService.approveAppointment(id);
            return ResponseEntity.ok(appointment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/api/appointments/{id}/reject")
    @ResponseBody
    public ResponseEntity<?> rejectAppointment(@PathVariable Long id) {
        try {
            Appointment appointment = appointmentService.rejectAppointment(id);
            return ResponseEntity.ok(appointment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}
