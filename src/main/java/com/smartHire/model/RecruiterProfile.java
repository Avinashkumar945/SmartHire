package com.smartHire.model;

public class RecruiterProfile {

    private Long id;
    private Long userId;
    private Long companyId;
    private String designation;

    // Default Constructor
    public RecruiterProfile() {
    }

    // Constructor for creating a new recruiter profile
    public RecruiterProfile(Long userId, Long companyId, String designation) {
        this.userId = userId;
        this.companyId = companyId;
        this.designation = designation;
    }

    // Full Constructor
    public RecruiterProfile(Long id, Long userId, Long companyId, String designation) {
        this.id = id;
        this.userId = userId;
        this.companyId = companyId;
        this.designation = designation;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getCompanyId() {
        return companyId;
    }

    public void setCompanyId(Long companyId) {
        this.companyId = companyId;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    @Override
    public String toString() {
        return "RecruiterProfile [id=" + id +
                ", userId=" + userId +
                ", companyId=" + companyId +
                ", designation=" + designation + "]";
    }
}