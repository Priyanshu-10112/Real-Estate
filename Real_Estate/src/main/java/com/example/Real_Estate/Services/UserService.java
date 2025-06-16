package com.example.Real_Estate.Services;

import java.util.List;

import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.UserRole;

public interface UserService {

	User save(User user);

	List<User> getAllUsers();

	List<Integer> countUsers();

	List<User> searchUsers(String query, UserRole role);

}
