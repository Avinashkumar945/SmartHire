package com.smartHire.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import com.smartHire.config.DBConnectionPool;
import com.smartHire.dao.UserDao;
import com.smartHire.exception.AppException;
import com.smartHire.exception.DuplicateEmailException;
import com.smartHire.model.User;
import com.smartHire.model.User.Status;

public class UserDAOImpl implements UserDao{
	
	@Override
	public User save(User user) {
		// TODO Auto-generated method stub
		

	    String query = "INSERT INTO users (email, password, role, status) " +
	                   "VALUES (?, ?, ?, ?)";

	    // try-with-resources → auto closes connection and statement
	    try (
	        Connection cn = DBConnectionPool.getConnection();
	        PreparedStatement ps = cn.prepareStatement(
	            query,
	            Statement.RETURN_GENERATED_KEYS  // ← get auto generated id
	        )
	      ){
		     ps.setString(1, user.getEmail());
	         ps.setString(2, user.getPassword());
	         ps.setString(3, user.getRole().name());
	         ps.setString(4, user.getStatus().name());
	         // Execute the INSERT
	        int rowsAffected = ps.executeUpdate();

	        if (rowsAffected == 0) {
	            throw new AppException("Saving user failed.", 500);
	        }
	        
	        // Get the auto generated id from database
	        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                user.setId(generatedKeys.getInt(1)); // set id on user
	            }
	        }
	        return user; 
		} catch (SQLException e) {
			 // error code 1062 = duplicate email in MySQL
	        if (e.getErrorCode() == 1062) {
	            throw new DuplicateEmailException(
	                "Email already exists: " + user.getEmail()
	            );
	        }
	        throw new AppException("Database error: " + e.getMessage(), 500);
		}
	}

	@Override
	public Optional<User> findByEmail(String email) {
		String query="SELECT * FROM users WHERE email=?";
		 try (
			        Connection cn = DBConnectionPool.getConnection();
			        PreparedStatement ps = cn.prepareStatement(query)
			      ){
			
			  ps.setString(1, email);
			  try( ResultSet res= ps.executeQuery()){
				  // check if any row was found
				  if(res.next()) {
					 
					  // build User object from ResultSet
		                User user = new User();
		                user.setId(res.getInt("id"));
		                user.setEmail(res.getString("email"));
		                user.setPassword(res.getString("password"));

		                // Enum conversion
		                user.setRole(User.Role.valueOf(res.getString("role")));
		                user.setStatus(User.Status.valueOf(res.getString("status")));
		                
		                if (res.getTimestamp("created_at") != null) {
		                    user.setCreatedAt(
		                        res.getTimestamp("created_at").toLocalDateTime()
		                    );
		                }

		                if (res.getTimestamp("updated_at") != null) {
		                    user.setUpdatedAt(
		                        res.getTimestamp("updated_at").toLocalDateTime()
		                    );
		                }
		                return Optional.of(user);
				  }
				  // if no row found
				  return Optional.empty();
				  
				  
			  }
			 
			 
			 
		 } catch (SQLException e) {
			 System.out.println("error sqlexception");
			 System.out.println("error sqlexception");
			    System.out.println("Error message: " + e.getMessage());  // ← add this
			    System.out.println("Error code: " + e.getErrorCode());   // ← add this
			    System.out.println("SQL State: " + e.getSQLState());     // ← add this
			 throw new AppException(
			            "Database error finding user by email: " + e.getMessage(), 500
			        );
		}
	
	}

	@Override
	public Optional<User> findById(Integer id) {
		String query="SELECT * FROM users WHERE id = ?";
		 try (
			        Connection cn = DBConnectionPool.getConnection();
			        PreparedStatement ps = cn.prepareStatement(query)
			  ){
			  ps.setInt(1, id);
			  try( ResultSet res= ps.executeQuery()){
				  // check if any row was found
				  if(res.next()) {
					  // build User object from ResultSet
		                User user = new User();
		                user.setId(res.getInt("id"));
		                user.setEmail(res.getString("email"));
		                user.setPassword(res.getString("password"));

		                // Enum conversion
		                user.setRole(User.Role.valueOf(res.getString("role")));
		                user.setStatus(User.Status.valueOf(res.getString("status")));
		                
		                if (res.getTimestamp("created_at") != null) {
		                    user.setCreatedAt(
		                        res.getTimestamp("created_at").toLocalDateTime()
		                    );
		                }

		                if (res.getTimestamp("updated_at") != null) {
		                    user.setUpdatedAt(
		                        res.getTimestamp("updated_at").toLocalDateTime()
		                    );
		                }
		                return Optional.of(user);
				  }
				  // if no row found
				  return Optional.empty();
				  
				  
			  }
			 
			 
			 
		 } catch (SQLException e) {
			 throw new AppException(
			            "Database error finding user by id: " + e.getMessage(), 500
			        );
		}
		
	}

	@Override
	public List<User> findAll() {
		String query="SELECT * FROM users";
		 try (
			        Connection cn = DBConnectionPool.getConnection();
			        PreparedStatement ps = cn.prepareStatement(query)
			  ){
			 
			 try( ResultSet res= ps.executeQuery()){
			       List<User> ls=new ArrayList<User>();
			       while(res.next()) {
			    	   User user=new User();
			    	   user.setId(res.getInt("id"));
		                user.setEmail(res.getString("email"));
		                user.setPassword(res.getString("password"));

		                // Enum conversion
		                user.setRole(User.Role.valueOf(res.getString("role")));
		                user.setStatus(User.Status.valueOf(res.getString("status")));
		                
		                if (res.getTimestamp("created_at") != null) {
		                    user.setCreatedAt(
		                        res.getTimestamp("created_at").toLocalDateTime()
		                    );
		                }

		                if (res.getTimestamp("updated_at") != null) {
		                    user.setUpdatedAt(
		                        res.getTimestamp("updated_at").toLocalDateTime()
		                    );
		                }
		                ls.add(user);
			       }
			       return ls;
			 }
			 
			 
		 } catch (SQLException e) {
			// TODO Auto-generated catch block
			 throw new AppException(
			            "Database error by finding user: " + e.getMessage(), 500
			     );
		}
	
	}

	@Override
	public void updateStatus(Integer userId, Status status) {
		String query="UPDATE users SET status = ? WHERE id = ?";
		 try (
			        Connection cn = DBConnectionPool.getConnection();
			        PreparedStatement ps = cn.prepareStatement(query)
			  ){
			
		        ps.setString(1, status.name()); // enum → String

		      
		        ps.setInt(2, userId);

		        
		        int rowsAffected = ps.executeUpdate();

		        if (rowsAffected == 0) {
		            throw new AppException(
		                "No user found with id: " + userId, 404
		            );
		        }
			     
		 } catch (SQLException e) {
			 throw new AppException(
			            "Database error updating status: " + e.getMessage(), 500
			        );
		}
	}

	@Override
	public boolean existsByEmail(String email) {

	    String query = "SELECT COUNT(*) FROM users WHERE email = ?";

	    try (
	        Connection cn = DBConnectionPool.getConnection();
	        PreparedStatement ps = cn.prepareStatement(query)
	    ) {
	        ps.setString(1, email);

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                return rs.getInt(1) > 0;
	            }
	            return false;
	        }

	    } catch (SQLException e) {
	        throw new AppException(
	            "Database error checking email existence: " + e.getMessage(), 500
	        );
	    }
	}
 
}
