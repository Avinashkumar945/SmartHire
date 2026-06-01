package com.smartHire.service.impl;

import java.util.List;
import java.util.Optional;

import com.smartHire.dao.UserDao;
import com.smartHire.exception.AppException;
import com.smartHire.exception.DuplicateApplicationException;
import com.smartHire.exception.InvalidCredentialsException;
import com.smartHire.exception.UserNotFoundException;
import com.smartHire.model.User;
import com.smartHire.model.User.Role;
import com.smartHire.service.UserService;
import com.smartHire.util.PasswordUtil;

public class UserServiceImpl implements UserService {
	
   private UserDao userdao;
	@Override
	public User login(String email, String password) {
		 Optional<User> optionalUser = userdao.findByEmail(email);
		 if(optionalUser.isEmpty()) {
			 throw new InvalidCredentialsException("invalid email or password");
		 }
		User user=optionalUser.get();
		if(!PasswordUtil.verify(password, user.getPassword())) {
			 throw new InvalidCredentialsException("invalid email or password");
		}
		
		if(user.getStatus()!=User.Status.ACTIVE) {
			throw new AppException(
		            "Account is not active. Status: " + user.getStatus(), 403
		        );
		}
		return user;
	}

	@Override
	public User register(String email, String password, Role role) {
		
	    if(userdao.existsByEmail(email)) {
	    	throw new DuplicateApplicationException("user already exist with this email"+email);
	    }
	    String hashedPassword = PasswordUtil.hash(password);
	    User user = new User(email, hashedPassword, role);
	    	
	     return userdao.save(user);
	}

	@Override
	public User getUserbyId(Integer id) {
		Optional<User> optionalUser=userdao.findById(id);
		if(optionalUser.isEmpty()) {
			throw new UserNotFoundException("user not found by  id: "+id);
		}
		
		return optionalUser.get();
	}

	@Override
	public List<User> getAllUser() {
	   return userdao.findAll();
	}

	@Override
	public User userActivate(Integer userId) {
		User user =getUserbyId(userId);
		 if (user.getStatus() == User.Status.ACTIVE) {
		        throw new AppException(
		            "User is already active.", 400
		        );
		    }
		userdao.updateStatus(userId, User.Status.ACTIVE);
		 user.setStatus(User.Status.ACTIVE);
		return user;
	}

	@Override
	public User userSuspend(Integer userId) {
		User user =getUserbyId(userId);
		if (user.getStatus() == User.Status.SUSPENDED) {
	        throw new AppException(
	            "User is already suspended.", 400
	        );
	    }
		userdao.updateStatus(userId, User.Status.SUSPENDED);
		 user.setStatus(User.Status.SUSPENDED);
		return user;
	}

}
