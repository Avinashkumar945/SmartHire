package com.smartHire.service.impl;

import java.util.Optional;

import com.smartHire.dao.SeekerDao;
import com.smartHire.dao.impl.SeekerDaoImpl;
import com.smartHire.exception.AppException;
import com.smartHire.model.SeekerProfile;
import com.smartHire.service.SeekerService;

public class SeekerServiceimpl implements SeekerService {
	
	SeekerDao dao=new SeekerDaoImpl();
    public SeekerProfile updateSeekerProfile(SeekerProfile seeker) {
    	System.out.println("update come to service layer");
    	

        Optional<SeekerProfile> existing =
            dao.findByUserId(seeker.getUserId());

        if (existing.isPresent()) {

            SeekerProfile old = existing.get();
           
            if (seeker.getFullName() != null)
                old.setFullName(seeker.getFullName());

            if (seeker.getPhone() != null)
                old.setPhone(seeker.getPhone());

            if (seeker.getLocation() != null)
                old.setLocation(seeker.getLocation());

            if (seeker.getBio() != null)
                old.setBio(seeker.getBio());

            if (seeker.getLinkedinUrl() != null)
                old.setLinkedinUrl(seeker.getLinkedinUrl());

            if (seeker.getGithubUrl() != null)
                old.setGithubUrl(seeker.getGithubUrl());

            
            old.setExperienceYears(seeker.getExperienceYears());

            return dao.update(old);
        }
    	  return  dao.update(seeker);
    }
	@Override
	public SeekerProfile saveSeekerProfile(SeekerProfile seeker) {

	    // Step 1 — check if profile already exists
	    // one user can only have one seeker profile
	    if (dao.existsByUserId(seeker.getUserId())) {
	        throw new AppException(
	            "Profile already exists for this user.", 409);
	    }

	    // Step 2 — validate full name
	    if (seeker.getFullName() == null ||
	        seeker.getFullName().isBlank()) {
	        throw new AppException(
	            "Full name is required.", 400);
	    }

	    // Step 3 — save to database via DAO
	    return dao.save(seeker);
	}
}
