package com.example.Real_Estate.controller;

import com.example.Real_Estate.Services.AppointmentService;
import com.example.Real_Estate.entity.Appointment;
import com.example.Real_Estate.entity.AppointmentStatus;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.repository.PropertiesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
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

    // Removed /api/appointments/filter endpoint and related filter logic

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

    @PostMapping("/api/appointments/{id}/sold")
    public ResponseEntity<?> markPropertyAsSold(@PathVariable Long id) {
        try {
            Appointment appointment = appointmentService.findById(id); // Implement this if not present
            if (appointment == null) {
                return ResponseEntity.status(404).body("Appointment not found");
            }
            Properties property = appointment.getProperty();
            property.setUser_id(appointment.getUser()); // Transfer ownership
            property.setStatus(com.example.Real_Estate.entity.PropertyStatus.SOLD); // Set status to SOLD (adjust import if needed)
            propertiesRepository.save(property);
            return ResponseEntity.ok("Property marked as sold and ownership transferred.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Error: " + e.getMessage());
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