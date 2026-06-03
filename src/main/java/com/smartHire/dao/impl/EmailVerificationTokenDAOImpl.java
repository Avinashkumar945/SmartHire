package com.smartHire.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Optional;

import com.smartHire.config.DBConnectionPool;
import com.smartHire.dao.EmailVerificationTokenDAO;
import com.smartHire.exception.AppException;
import com.smartHire.model.EmailVerificationToken;

public class EmailVerificationTokenDAOImpl implements EmailVerificationTokenDAO {

	@Override
	public EmailVerificationToken save(EmailVerificationToken token) {
			// TODO Auto-generated method stub
			

		    String query = "INSERT INTO  email_verification_tokens (user_id, token, expires_at, used) " +
		                   "VALUES (?, ?, ?, ?)";

		    try (
		        Connection cn = DBConnectionPool.getConnection();
		        PreparedStatement ps = cn.prepareStatement(
		            query,
		            Statement.RETURN_GENERATED_KEYS  // ← get auto generated id
		        )
		      ){
			     ps.setLong(1, token.getUserId());
		         ps.setString(2, token.getToken());
		         ps.setTimestamp(3,Timestamp.valueOf(token.getExpiresAt()));

		         ps.setBoolean(4, token.isUsed());
		         
		        int rowsAffected = ps.executeUpdate();

		        if (rowsAffected == 0) {
		            throw new AppException("Saving user failed.", 500);
		        }
		        
		        // Get the auto generated id from database
		        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
		            if (generatedKeys.next()) {
		                token.setId(generatedKeys.getLong(1)); // set id on user
		            }
		        }
		        return token; 
			} catch (SQLException e) {
				throw new AppException(
		                "Database error saving token: "
		                + e.getMessage(), 500);
		        }
		
	}

	@Override
	public Optional<EmailVerificationToken> findByToken(String token) {
		  String query="SELECT * FROM email_verification_tokens WHERE token = ?";
		  
		  try(Connection cn=DBConnectionPool.getConnection();
				PreparedStatement ps=cn.prepareStatement(query)){
			  ps.setString(1, token);
			  
			  try(ResultSet rs=ps.executeQuery()){
				  if(rs.next()) {
					  EmailVerificationToken emailVerification=new EmailVerificationToken();
					  emailVerification.setExpiresAt(rs.getTimestamp("expires_at").toLocalDateTime());
					  
					  emailVerification.setId(rs.getLong("id"));
					  emailVerification.setToken(rs.getString("token"));
					  emailVerification.setUserId(rs.getLong("user_id"));
					  emailVerification.setUsed(rs.getBoolean("used"));
					  
					  return Optional.of(emailVerification);
				  }
				  return Optional.empty();
			  }
		  } catch (SQLException e) {
			  throw new AppException(
		                "Database error finding token: "
		                + e.getMessage(), 500);
		        }
		
		
	}

	@Override
	public void markAsUsed(Long tokenId) {
		  String query =
		            "UPDATE email_verification_tokens " +
		            "SET used = TRUE " +
		            "WHERE id = ?";

		        try (
		            Connection cn = DBConnectionPool.getConnection();
		            PreparedStatement ps = cn.prepareStatement(query)
		        ) {
		            ps.setLong(1, tokenId);

		            int rowsAffected = ps.executeUpdate();

		            if (rowsAffected == 0) {
		                throw new AppException(
		                    "No token found with id: "
		                    + tokenId, 404);
		            }

		        } catch (SQLException e) {
		            throw new AppException(
		                "Database error marking token used: "
		                + e.getMessage(), 500);
		        }
		    }

}
