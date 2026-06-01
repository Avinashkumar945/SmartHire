package com.smartHire.service;

import java.util.List;

import com.smartHire.model.User;

public interface UserService {
     // login
	// register 
	// get  user by id
	// get all user 
	// activate user
	// suspend user
	
	User login(String email, String password);
	User register(String email, String password,User.Role role);
	User getUserbyId(Integer id);
	List<User> getAllUser();
	User userActivate(Integer userId);
	User userSuspend(Integer userId);
	
	
}
