package com.example.Real_Estate.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.Real_Estate.entity.Properties;

public interface PropertiesRepository extends JpaRepository<Properties, Long> {
} 