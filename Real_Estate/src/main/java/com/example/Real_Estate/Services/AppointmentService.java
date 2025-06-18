package com.example.Real_Estate.Services;

import com.example.Real_Estate.entity.Appointment;
import com.example.Real_Estate.entity.AppointmentStatus;
import com.example.Real_Estate.entity.User;
import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentService {
    Appointment createAppointment(Appointment appointment);
    List<Appointment> getAppointmentsByUser(User user);
    List<Appointment> getAppointmentsByAgent(User agent);
    Appointment cancelAppointment(Long id);
    Appointment approveAppointment(Long id);
    Appointment rejectAppointment(Long id);
    Appointment updateAppointmentStatus(Long id, AppointmentStatus status);
    List<Appointment> getAppointmentsByUserAndStatus(User user, AppointmentStatus status);
    List<Appointment> getAppointmentsByUserAndDateRange(User user, LocalDateTime startDate, LocalDateTime endDate);
    void deleteAppointment(Long id);
} 