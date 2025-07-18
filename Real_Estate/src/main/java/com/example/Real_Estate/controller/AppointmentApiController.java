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
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@RestController
public class AppointmentApiController {
    @Autowired
    private AppointmentService appointmentService;

    @Autowired
    private PropertiesRepository propertiesRepository;

    @PostMapping("/api/appointments")
    public Appointment createAppointment(@RequestBody Appointment appointment, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            throw new RuntimeException("User not logged in");
        }
        if (appointment.getProperty() == null || appointment.getProperty().getId() == null) {
            throw new RuntimeException("Property ID is required");
        }
        Properties property = propertiesRepository.findById(appointment.getProperty().getId())
            .orElseThrow(() -> new RuntimeException("Property not found with ID: " + appointment.getProperty().getId()));
        appointment.setProperty(property);
        appointment.setUser(loggedInUser);
        appointment.setStatus(AppointmentStatus.PENDING);
        return appointmentService.createAppointment(appointment);
    }

    @PostMapping("/api/appointments/{id}/cancel")
    public String cancelAppointment(@PathVariable Long id) {
        try {
            appointmentService.cancelAppointment(id);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    @PostMapping("/api/appointments/{id}/status")
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
    public ResponseEntity<?> approveAppointment(@PathVariable Long id) {
        try {
            Appointment appointment = appointmentService.approveAppointment(id);
            return ResponseEntity.ok(appointment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/api/appointments/{id}/reject")
    public ResponseEntity<?> rejectAppointment(@PathVariable Long id) {
        try {
            Appointment appointment = appointmentService.rejectAppointment(id);
            return ResponseEntity.ok(appointment);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/api/appointments/pending-count")
    public ResponseEntity<?> getPendingAppointmentCount(HttpSession session) {
        try {
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser == null) {
                return ResponseEntity.status(401).body("User not logged in");
            }
            List<Appointment> pendingAppointments = appointmentService.getAppointmentsByUserAndStatus(loggedInUser, AppointmentStatus.PENDING);
            return ResponseEntity.ok(Map.of("count", pendingAppointments.size()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PostMapping("/api/appointments/{id}/delete")
    @ResponseBody
    public ResponseEntity<?> deleteAppointment(@PathVariable Long id, HttpSession session) {
        try {
            User loggedInUser = (User) session.getAttribute("user");
            if (loggedInUser == null) {
                return ResponseEntity.status(401).body("User not logged in");
            }

            Appointment appointment = null;
            boolean canDelete = false;

            // Check if user is AGENT
            if (loggedInUser.getUr() != null && loggedInUser.getUr().name().equals("AGENT")) {
                // Get all appointments for agent's properties
                List<Appointment> agentAppointments = appointmentService.getAppointmentsByAgent(loggedInUser);
                appointment = agentAppointments.stream()
                        .filter(a -> a.getId().equals(id))
                        .findFirst()
                        .orElse(null);
                if (appointment != null) {
                    canDelete = true;
                }
            } else {
                // Default: user can delete their own appointment
                List<Appointment> userAppointments = appointmentService.getAppointmentsByUser(loggedInUser);
                appointment = userAppointments.stream()
                        .filter(a -> a.getId().equals(id))
                        .findFirst()
                        .orElse(null);
                if (appointment != null) {
                    canDelete = true;
                }
            }

            if (!canDelete || appointment == null) {
                return ResponseEntity.status(404).body("Appointment not found or access denied");
            }

            appointmentService.deleteAppointment(id, loggedInUser);
            return ResponseEntity.ok("{\"message\": \"Appointment deleted successfully\"}");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    @GetMapping("/api/appointments/test")
    public ResponseEntity<?> testEndpoint() {
        return ResponseEntity.ok(Map.of("message", "Test endpoint working"));
    }

    @PatchMapping("/api/notifications/{id}/dismiss")
    public ResponseEntity<?> dismissNotification(@PathVariable Long id, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            return ResponseEntity.status(401).body("User not logged in");
        }
        try {
            appointmentService.dismissNotification(id, loggedInUser);
            return ResponseEntity.ok(Map.of("message", "Notification dismissed"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", e.getMessage()));
        }
    }
} 