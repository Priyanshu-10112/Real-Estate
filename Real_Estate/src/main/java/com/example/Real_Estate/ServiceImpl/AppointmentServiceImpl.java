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
    public List<Appointment> getAppointmentsByUserAndStatus(User user, AppointmentStatus status) {
        return appointmentRepository.findByUserAndStatus(user, status);
    }

    @Override
    public List<Appointment> getAppointmentsByUserAndDateRange(User user, LocalDateTime startDate, LocalDateTime endDate) {
        return appointmentRepository.findByUserAndAppointmentDateBetween(user, startDate, endDate);
    }

    @Override
    @Transactional
    public void deleteAppointment(Long id) {
        Appointment appointment = appointmentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Appointment not found"));
        if (appointment.getStatus() == AppointmentStatus.PENDING) {
            throw new RuntimeException("Cannot delete a pending appointment");
        }
        appointmentRepository.delete(appointment);
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