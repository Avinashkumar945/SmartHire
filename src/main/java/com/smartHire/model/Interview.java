package com.smartHire.model;

import java.time.LocalDateTime;

public class Interview {
	
	public enum InterviewMode {
	    IN_PERSON,
	    VIDEO,
	    PHONE
	}

    private Long id;
    private Long applicationId;

    private LocalDateTime scheduledAt;

    private InterviewMode mode;

    private String locationLink;

    private String notes;

    // Default Constructor
    public Interview() {
    }

    // Constructor for creating a new interview
    public Interview(Long applicationId,
                     LocalDateTime scheduledAt,
                     InterviewMode mode,
                     String locationLink,
                     String notes) {

        this.applicationId = applicationId;
        this.scheduledAt = scheduledAt;
        this.mode = mode;
        this.locationLink = locationLink;
        this.notes = notes;
    }

    // Full Constructor
    public Interview(Long id,
                     Long applicationId,
                     LocalDateTime scheduledAt,
                     InterviewMode mode,
                     String locationLink,
                     String notes) {

        this.id = id;
        this.applicationId = applicationId;
        this.scheduledAt = scheduledAt;
        this.mode = mode;
        this.locationLink = locationLink;
        this.notes = notes;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(Long applicationId) {
        this.applicationId = applicationId;
    }

    public LocalDateTime getScheduledAt() {
        return scheduledAt;
    }

    public void setScheduledAt(LocalDateTime scheduledAt) {
        this.scheduledAt = scheduledAt;
    }

    public InterviewMode getMode() {
        return mode;
    }

    public void setMode(InterviewMode mode) {
        this.mode = mode;
    }

    public String getLocationLink() {
        return locationLink;
    }

    public void setLocationLink(String locationLink) {
        this.locationLink = locationLink;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Interview [id=" + id +
                ", applicationId=" + applicationId +
                ", scheduledAt=" + scheduledAt +
                ", mode=" + mode +
                ", locationLink=" + locationLink +
                ", notes=" + notes + "]";
    }
}