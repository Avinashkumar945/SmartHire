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
import com.smartHire.dao.SeekerDao;
import com.smartHire.exception.AppException;
import com.smartHire.model.SeekerProfile;

public class SeekerDaoImpl implements SeekerDao {
  
	@Override
	public SeekerProfile save(SeekerProfile seeker) {

	    String query =
	            "INSERT INTO seeker_profiles (user_id, full_name) " +
	            "VALUES (?, ?)";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(
	                    query,
	                    Statement.RETURN_GENERATED_KEYS)
	    ) {

	        ps.setLong(1, seeker.getUserId());
	        ps.setString(2, seeker.getFullName());
	        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                seeker.setId(generatedKeys.getLong(1)); 
	            }
	        }
	        int rowsAffected = ps.executeUpdate();

	        if (rowsAffected == 0) {
	            throw new AppException("Failed to create seeker profile.", 500);
	        }

	        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
	            if (generatedKeys.next()) {
	                seeker.setId(generatedKeys.getLong(1));
	            }
	        }

	        return seeker;

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}
	
	@Override
	public Optional<SeekerProfile> findById(Integer id) {

	    String query = "SELECT * FROM seeker_profiles WHERE id = ?";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query)
	    ) {

	        ps.setInt(1, id);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {
	                return Optional.of(mapRowToSeeker(rs));
	            }

	            return Optional.empty();
	        }

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}

	@Override
	public List<SeekerProfile> findAll() {

	    String query = "SELECT * FROM seeker_profiles";

	    List<SeekerProfile> seekers = new ArrayList<>();

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query);
	            ResultSet rs = ps.executeQuery()
	    ) {

	        while (rs.next()) {
               seekers.add(mapRowToSeeker(rs));
	        }

	        return seekers;

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}

	@Override
	public Optional<SeekerProfile> findByExperienceYear(Integer year) {

	    String query =
	            "SELECT * FROM seeker_profiles WHERE experience_years = ?";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query)
	    ) {

	        ps.setInt(1, year);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {
	                return Optional.of(mapRowToSeeker(rs));
	            }

	            return Optional.empty();
	        }

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}
	
	@Override
	public SeekerProfile update(SeekerProfile seeker) {
	    String query =
	            "UPDATE seeker_profiles SET " +
	            "full_name = ?, " +
	            "phone = ?, " +
	            "location = ?, " +
	            "bio = ?, " +
	            "resume_path = ?, " +
	            "linkedin_url = ?, " +
	            "github_url = ?, " +
	            "experience_years = ? " +
	            "WHERE id = ?";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query)
	    ) {
	    	 System.out.println("update come to dao layer of try con");
	        ps.setString(1, seeker.getFullName());
	        ps.setString(2, seeker.getPhone());
	        System.out.println(seeker.getPhone());
	        ps.setString(3, seeker.getLocation());
	        ps.setString(4, seeker.getBio());
	        ps.setString(5, seeker.getResumePath());
	        ps.setString(6, seeker.getLinkedinUrl());
	        ps.setString(7, seeker.getGithubUrl());
	        ps.setInt(8, seeker.getExperienceYears());
	        Optional<SeekerProfile> optionalSeeker= findByUserId(seeker.getUserId());
            ps.setLong(9, optionalSeeker.get().getId());

	        int rowsAffected = ps.executeUpdate();

	        if (rowsAffected == 0) {
	        	System.out.println("update error not found");
	            throw new AppException("Seeker profile not found.", 404);
	        }

	        return seeker;

	    } catch (SQLException e) {
	    	System.out.println("update come to dao layer db error");
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}
	
	@Override
	public Optional<SeekerProfile> findByUserId(Long userId) {

	    String query =
	            "SELECT * FROM seeker_profiles WHERE user_id = ?";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query)
	    ) {

	        ps.setLong(1, userId);

	        try (ResultSet rs = ps.executeQuery()) {

	            if (rs.next()) {
	                return Optional.of(mapRowToSeeker(rs));
	            }

	            return Optional.empty();
	        }

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}
	
	@Override
	public boolean delete(Long id) {

	    String query =
	            "DELETE FROM seeker_profiles WHERE id = ?";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query)
	    ) {

	        ps.setLong(1, id);

	        return ps.executeUpdate() > 0;

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}
	
	
	@Override
	public boolean existsByUserId(Long userId) {

	    String query =
	            "SELECT 1 FROM seeker_profiles WHERE user_id = ?";

	    try (
	            Connection cn = DBConnectionPool.getConnection();
	            PreparedStatement ps = cn.prepareStatement(query)
	    ) {

	        ps.setLong(1, userId);

	        try (ResultSet rs = ps.executeQuery()) {
	            return rs.next();
	        }

	    } catch (SQLException e) {
	        throw new AppException("Database error: " + e.getMessage(), 500);
	    }
	}
	
	// helper method 
	private SeekerProfile mapRowToSeeker(ResultSet rs) throws SQLException {

	    SeekerProfile seeker = new SeekerProfile();

	    seeker.setId(rs.getLong("id"));
	    seeker.setUserId(rs.getLong("user_id"));
	    seeker.setFullName(rs.getString("full_name"));
	    seeker.setPhone(rs.getString("phone"));
	    seeker.setLocation(rs.getString("location"));
	    seeker.setBio(rs.getString("bio"));
	    seeker.setResumePath(rs.getString("resume_path"));
	    seeker.setLinkedinUrl(rs.getString("linkedin_url"));
	    seeker.setGithubUrl(rs.getString("github_url"));
	    seeker.setExperienceYears(rs.getInt("experience_years"));

	    return seeker;
	}
}
