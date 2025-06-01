package com.example.Real_Estate.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.Real_Estate.entity.User;

@Repository
public interface UserRepo extends JpaRepository<User,Integer>{
	public User findByEmail(String email);
}
