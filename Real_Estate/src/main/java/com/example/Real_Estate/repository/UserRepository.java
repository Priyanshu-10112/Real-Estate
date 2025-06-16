package com.example.Real_Estate.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.Real_Estate.entity.User;

public interface UserRepository extends JpaRepository<User, Long> {
} 