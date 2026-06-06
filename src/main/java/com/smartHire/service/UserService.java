package com.smartHire.service;

import java.util.List;

import com.smartHire.model.User;
import com.smartHire.model.User.Role;

public interface UserService {
     // login
	// register 
	// get  user by id
	// get all user 
	// activate user
	// suspend user
	
	User login(String email, String password);
	User getUserbyId(Integer id);
	List<User> getAllUser();
	User userActivate(Integer userId);
	User userSuspend(Integer userId);
	User getUserbyemail(String email);
	User register(String name, String email, String password, Role role);
	
	
	
}
