package com.example.Real_Estate.repository;

import com.example.Real_Estate.entity.Appointment;
import com.example.Real_Estate.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentRepository extends JpaRepository<Appointment, Long> {
    List<Appointment> findByUser(User user);
    
    List<Appointment> findByUserAndAppointmentDateBetween(User user, LocalDateTime startDate, LocalDateTime endDate);
    
    @Query("SELECT a FROM Appointment a JOIN a.property p WHERE p.user_id = :agent")
    List<Appointment> findByPropertyUser(@Param("agent") User agent);

    List<Appointment> findByUserAndNotificationDismissedFalse(User user);
} 