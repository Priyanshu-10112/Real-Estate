package com.example.Real_Estate.Services;

import java.util.List;

import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.UserRole;

public interface UserService {
	public User save(User user);
	public User login(String email, String pass);
	public List<User> getAllUsers();
	public List<User> searchUsers(String query, UserRole role);
	List<Integer> countUsers();
}
