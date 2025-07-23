package com.example.Real_Estate.ServiceImpl;

import com.example.Real_Estate.Services.AppointmentService;
import com.example.Real_Estate.entity.Appointment;
import com.example.Real_Estate.entity.AppointmentStatus;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.repository.AppointmentRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class AppointmentServiceImpl implements AppointmentService {

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Override
    @Transactional
    public Appointment createAppointment(Appointment appointment) {
        appointment.setStatus(AppointmentStatus.PENDING);
        return appointmentRepository.save(appointment);
    }

    @Override
    public List<Appointment> getAppointmentsByUser(User user) {
        return appointmentRepository.findByUser(user);
    }

    @Override
    public List<Appointment> getAppointmentsByAgent(User agent) {
        return appointmentRepository.findByPropertyUser(agent);
    }

    @Override
    @Transactional
    public Appointment cancelAppointment(Long id) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        appointment.setStatus(AppointmentStatus.REJECTED);
        return appointmentRepository.save(appointment);
    }

    @Override
    @Transactional
    public Appointment approveAppointment(Long id) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        appointment.setStatus(AppointmentStatus.CONFIRMED);
        return appointmentRepository.save(appointment);
    }

    @Override
    @Transactional
    public Appointment rejectAppointment(Long id) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        appointment.setStatus(AppointmentStatus.REJECTED);
        return appointmentRepository.save(appointment);
    }

    @Override
    @Transactional
    public Appointment updateAppointmentStatus(Long id, AppointmentStatus status) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        appointment.setStatus(status);
        return appointmentRepository.save(appointment);
    }

    @Override
    public List<Appointment> getAppointmentsByUserAndDateRange(User user, LocalDateTime startDate, LocalDateTime endDate) {
        return appointmentRepository.findByUserAndAppointmentDateBetween(user, startDate, endDate);
    }

    @Override
    @Transactional
    public void deleteAppointment(Long id, User user) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        if (appointment.getStatus() == AppointmentStatus.PENDING) {
            throw new RuntimeException("Cannot delete a pending appointment");
        }
        // Allow if user is the appointment user
        boolean isUser = appointment.getUser().getId().equals(user.getId());
        // Allow if user is agent and owns the property
        boolean isAgent = user.getUr() != null && user.getUr().name().equals("AGENT");
        boolean isAgentOwner = isAgent && appointment.getProperty().getUser_id().getId().equals(user.getId());
        if (!isUser && !isAgentOwner) {
            throw new RuntimeException("Access denied: You do not have permission to delete this appointment");
        }
        appointmentRepository.delete(appointment);
    }

    // Keep old method for compatibility
    @Override
    @Transactional
    public void deleteAppointment(Long id) {
        throw new UnsupportedOperationException("Use deleteAppointment(Long id, User user) instead");
    }

    @Override
    public List<Appointment> getActiveNotificationsByUser(User user) {
        return appointmentRepository.findByUserAndNotificationDismissedFalse(user);
    }

    @Transactional
    public Appointment dismissNotification(Long id, User user) {
        Appointment appointment = appointmentRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Appointment not found"));
        System.out.println("DEBUG: appointment.user.id=" + appointment.getUser().getId() + ", session user.id=" + user.getId());
        if (!appointment.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Access denied");
        }
        appointment.setNotificationDismissed(true);
        Appointment saved = appointmentRepository.save(appointment);
        appointmentRepository.flush();
        return saved;
    }
} 