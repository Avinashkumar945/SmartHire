package com.smartHire.model;

import java.time.LocalDateTime;

public class Application {
	
	public enum ApplicationStatus{
		APPLIED,SHORTLISTED,INTERVIEW_SCHEDULED,OFFERED,REJECTED,WITHDRAWN
	}

    private Long id;
    private Long jobId;
    private Long seekerId;

    private String coverLetter;

    private ApplicationStatus status;

    private LocalDateTime appliedAt;
    private LocalDateTime updatedAt;

    // Default Constructor
    public Application() {
    }

    // Constructor for new application
    public Application(Long jobId, Long seekerId, String coverLetter) {
        this.jobId = jobId;
        this.seekerId = seekerId;
        this.coverLetter = coverLetter;
    }

    // Full Constructor
    public Application(Long id, Long jobId, Long seekerId,
                       String coverLetter, ApplicationStatus status,
                       LocalDateTime appliedAt, LocalDateTime updatedAt) {

        this.id = id;
        this.jobId = jobId;
        this.seekerId = seekerId;
        this.coverLetter = coverLetter;
        this.status = status;
        this.appliedAt = appliedAt;
        this.updatedAt = updatedAt;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getJobId() {
        return jobId;
    }

    public void setJobId(Long jobId) {
        this.jobId = jobId;
    }

    public Long getSeekerId() {
        return seekerId;
    }

    public void setSeekerId(Long seekerId) {
        this.seekerId = seekerId;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public ApplicationStatus getStatus() {
        return status;
    }

    public void setStatus(ApplicationStatus status) {
        this.status = status;
    }

    public LocalDateTime getAppliedAt() {
        return appliedAt;
    }

    public void setAppliedAt(LocalDateTime appliedAt) {
        this.appliedAt = appliedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Application [id=" + id +
                ", jobId=" + jobId +
                ", seekerId=" + seekerId +
                ", coverLetter=" + coverLetter +
                ", status=" + status +
                ", appliedAt=" + appliedAt +
                ", updatedAt=" + updatedAt + "]";
    }
}