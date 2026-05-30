package com.smartHire.model;

import java.time.LocalDateTime;

public class SavedJob {

    private Long seekerId;
    private Long jobId;
    private LocalDateTime savedAt;

    // Default Constructor
    public SavedJob() {
    }

    // Constructor for creating a saved job
    public SavedJob(Long seekerId, Long jobId) {
        this.seekerId = seekerId;
        this.jobId = jobId;
    }

    // Full Constructor
    public SavedJob(Long seekerId, Long jobId, LocalDateTime savedAt) {
        this.seekerId = seekerId;
        this.jobId = jobId;
        this.savedAt = savedAt;
    }

    public Long getSeekerId() {
        return seekerId;
    }

    public void setSeekerId(Long seekerId) {
        this.seekerId = seekerId;
    }

    public Long getJobId() {
        return jobId;
    }

    public void setJobId(Long jobId) {
        this.jobId = jobId;
    }

    public LocalDateTime getSavedAt() {
        return savedAt;
    }

    public void setSavedAt(LocalDateTime savedAt) {
        this.savedAt = savedAt;
    }

    @Override
    public String toString() {
        return "SavedJob [seekerId=" + seekerId +
                ", jobId=" + jobId +
                ", savedAt=" + savedAt + "]";
    }
}