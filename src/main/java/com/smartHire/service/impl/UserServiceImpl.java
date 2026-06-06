package com.smartHire.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import com.smartHire.dao.EmailVerificationTokenDAO;
import com.smartHire.dao.UserDao;
import com.smartHire.dao.impl.EmailVerificationTokenDAOImpl;
import com.smartHire.dao.impl.UserDAOImpl;
import com.smartHire.exception.AppException;
import com.smartHire.exception.DuplicateEmailException;
import com.smartHire.exception.InvalidCredentialsException;
import com.smartHire.exception.UserNotFoundException;
import com.smartHire.exception.ValidationException;
import com.smartHire.model.EmailVerificationToken;
import com.smartHire.model.User;
import com.smartHire.model.User.Role;
import com.smartHire.service.UserService;
import com.smartHire.util.EmailService;
import com.smartHire.util.PasswordUtil;

public class UserServiceImpl implements UserService {
	
    UserDao userdao=new UserDAOImpl();
    EmailVerificationTokenDAO tokendao=new EmailVerificationTokenDAOImpl();
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
		            "Account is not register yet", 403
		        );
		}
		return user;
	}
	 
	 
	@Override
	public User register(String name,String email, String password, Role role) {
		
		if(email == null || email.trim().isEmpty()) {
		    throw new ValidationException("Email is required");
		}

		if(password == null || password.trim().isEmpty()) {
		    throw new ValidationException("Password is required");
		}
		
		if(role == null || role.toString().trim().isEmpty()) {
		    throw new ValidationException("Role is required.");
		}
		
		
	    if(userdao.existsByEmail(email)) {
	    	 // Get the existing user
	        Optional<User> existingUser = userdao.findByEmail(email);
	        User user = existingUser.get();

	        // If account is PENDING — resend verification email
	        if (user.getStatus() == User.Status.PENDING_VERIFICATION) {

	            // generate new token
	            String tokenValue = UUID.randomUUID().toString();
	            LocalDateTime expiresAt = LocalDateTime.now().plusHours(24);

	            EmailVerificationToken token = new EmailVerificationToken(
	                user.getId(),
	                tokenValue,
	                expiresAt
	            );
	            tokendao.save(token);

	            // resend email
	            EmailService.sendVerificationEmail(email, tokenValue);

	            // throw special exception so servlet shows correct message
	            throw new AppException(
	                "Account already exists but not verified. " +
	                "A new verification email has been sent to " + email, 409
	            );
	        }

	        // Account is ACTIVE or SUSPENDED — normal duplicate error
	        throw new DuplicateEmailException(
	            "Email already exists: " + email
	        );
	    }
	    String hashedPassword = PasswordUtil.hash(password);
	    User user = new User(name,email, hashedPassword, role);
	    User savedUser= userdao.save(user);
	    // Step 2 — create token OBJECT
		 EmailVerificationToken token =
		    new EmailVerificationToken(
		        savedUser.getId(),               
		        UUID.randomUUID().toString(),   
		        LocalDateTime.now().plusHours(24) 
		    );
		 tokendao.save(token);

		 EmailService.sendVerificationEmail(email, token.getToken());

	    return savedUser;
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
	public User getUserbyemail(String email) {
		Optional<User> optionalUser=userdao.findByEmail(email);
		if(optionalUser.isEmpty()) {
			throw new UserNotFoundException("user not found by  id: "+email);
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
