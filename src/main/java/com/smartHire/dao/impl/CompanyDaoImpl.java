package com.smartHire.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import java.util.Optional;

import com.smartHire.config.DBConnectionPool;
import com.smartHire.dao.CompanyDao;
import com.smartHire.exception.AppException;
import com.smartHire.model.Company;

public class CompanyDaoImpl implements CompanyDao {

	@Override
	public Company save(Company comp) {
		 String query =
		            "INSERT INTO companies (name,website,industry,size_range,description,logo_path) " +
		            "VALUES (?, ?,?,?,?,?)";

		    try (
		            Connection cn = DBConnectionPool.getConnection();
		            PreparedStatement ps = cn.prepareStatement(
		                    query,
		                    Statement.RETURN_GENERATED_KEYS)
		    ) {
		    	ps.setString(1,comp.getName() );
		    	ps.setString(2,comp.getWebsite());
		    	ps.setString(3,comp.getIndustry());
		    	ps.setString(4,comp.getSizeRange() );
		    	ps.setString(5,comp.getDescription() );
		    	ps.setString(6,comp.getLogoPath() );

		          int rowsAffected = ps.executeUpdate();

		        if (rowsAffected == 0) {
		            throw new AppException("Failed to create seeker profile.", 500);
		        }
		        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
		            if (generatedKeys.next()) {
		                comp.setId(generatedKeys.getLong(1)); 
		            }
		        }

		        return comp;

		    } catch (SQLException e) {
		        throw new AppException("Database error: " + e.getMessage(), 500);
		    }
		
	}

	@Override
	public Company update(Company comp) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Optional<Company> findByid(Long id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Optional<Company> findByUserId(Long userId) {
		// TODO Auto-generated method stub
		String query="SELECT co.* FROM companies as co "
				+ "JOIN recruiter_profiles as rp "
				+ "ON  co.id=rp.company_id "
				+ "WHERE rp.user_id = ?";
		try( Connection con =DBConnectionPool.getConnection();
				PreparedStatement ps=con.prepareStatement(query)){
			     ps.setLong(1, userId);
			     try(ResultSet rs=ps.executeQuery()){
			    	 if(rs.next()) {
			    		return  Optional.of(mapRowToCompany(rs));
			    	 }
			    	return Optional.empty();
			     }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
		      throw new AppException("database error in finding company by userId"+e.getMessage(),500);
		}
		
	}

	@Override
	public List<Company> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Company> findUnverified() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void verify(Long companyId) {
		// TODO Auto-generated method stub

	}

	@Override
	public boolean existsByName(String name) {
		String query =
		        "SELECT COUNT(*) FROM companies " +
		        "WHERE name = ?";
		try( Connection con =DBConnectionPool.getConnection();
				PreparedStatement ps=con.prepareStatement(query)){
			  ps.setString(1, name);
			   try(ResultSet rs=ps.executeQuery()){
				   if(rs.next()) {
					   return rs.getInt(1) > 0;
				   }
				   return false;
			   }
		} catch (SQLException e) {
			throw new AppException("database error in checking company exist by anme"+e.getMessage(), 500);
		}
		
	}
	
	private Company mapRowToCompany(ResultSet rs) throws SQLException {

		Company comp = new Company();

		comp.setId(rs.getLong("id"));
	    comp.setIndustry(rs.getString("industry"));
	    comp.setName(rs.getString("name"));
	    comp.setSizeRange(rs.getString("size_range"));
	    comp.setVerified(rs.getBoolean("verified"));
	    comp.setWebsite(rs.getString("website"));
	    comp.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
	    comp.setDescription(rs.getString("description"));

	    return comp;
	}

}
