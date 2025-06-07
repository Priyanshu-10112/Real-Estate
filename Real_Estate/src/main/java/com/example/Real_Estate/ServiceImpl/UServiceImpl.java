package com.example.Real_Estate.ServiceImpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Real_Estate.Services.UserService;
import com.example.Real_Estate.entity.User;
import com.example.Real_Estate.entity.UserRole;
import com.example.Real_Estate.repository.UserRepo;

@Service
public class UServiceImpl implements UserService{
	
	@Autowired 
	private UserRepo u1;
	@Override
	public User save(User user) {
		return u1.save(user);
	}
	public User login(String email, String pass) {
		User u=u1.findByEmail(email);
		if(u!=null && u.getPassword().equals(pass)) return u;
		return null;
	}
	@Override
	public List<User> getAllUsers() {
		return u1.findAll();
	}
	@Override
	public List<Integer> countUsers() {
		int Total_user=0;
		int Total_agent=0;
		List<User> u2=u1.findAll();
		for(User u:u2) {
			if(u.getUr()==UserRole.USER) Total_user++;
			if(u.getUr()==UserRole.AGENT) Total_agent++;
		}
		List<Integer> a = new ArrayList<>();
		a.add(Total_user);
		a.add(Total_agent);
		return a;
	}
	@Override
	public List<User> searchUsers(String query, UserRole role) {
		// TODO Auto-generated method stub
		return null;
	}
	public List<User> findAllUsers() {
		return u1.findAll();
	}

	public User findByEmail(String email) {
		return u1.findByEmail(email);
	}
	
}
