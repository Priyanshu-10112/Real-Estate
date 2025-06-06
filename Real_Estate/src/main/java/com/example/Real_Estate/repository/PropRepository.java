package com.example.Real_Estate.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.Real_Estate.entity.Properties;
import com.example.Real_Estate.entity.User;

@Repository
public interface PropRepository extends JpaRepository<Properties, Long> {
    @Query("SELECT p FROM Properties p WHERE p.user_id = :user")
    List<Properties> findByUser_id(@Param("user") User user);
} 