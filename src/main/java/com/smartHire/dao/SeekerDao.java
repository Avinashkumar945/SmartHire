package com.smartHire.dao;

import java.util.List;
import java.util.Optional;

import com.smartHire.model.SeekerProfile;
import com.smartHire.model.User;

public interface SeekerDao {
	SeekerProfile save(SeekerProfile seeker);
  
  Optional<SeekerProfile> findById(Integer id);
  
  List<SeekerProfile> findAll();
  
  Optional<SeekerProfile> findByExperienceYear(Integer year);
  Optional<SeekerProfile> findByUserId(Long userId);
  boolean delete(Long id);
  
  boolean existsByUserId(Long userId);
  
  SeekerProfile update(SeekerProfile seeker);
}
