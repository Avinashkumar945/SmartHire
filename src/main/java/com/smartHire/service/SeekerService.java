package com.smartHire.service;

import com.smartHire.model.SeekerProfile;

public interface SeekerService {
	SeekerProfile updateSeekerProfile(SeekerProfile seeker);
	SeekerProfile saveSeekerProfile(SeekerProfile seeker);
	SeekerProfile findAlreadySavedSeekerProfile(SeekerProfile seeker);
}
