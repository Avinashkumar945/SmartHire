package com.smartHire.model;

public class SeekerProfile {

    private Long id;
    private Long userId;

    private String fullName;
    private String phone;
    private String location;
    private String bio;

    private String resumePath;
    private String linkedinUrl;
    private String githubUrl;

    private Integer experienceYears;

    // Default Constructor
    public SeekerProfile() {
    }

    // Constructor for creating a profile
    public SeekerProfile(Long userId, String fullName,
                         String phone, String location,
                         String bio, String resumePath,
                         String linkedinUrl, String githubUrl,
                         Integer experienceYears) {

        this.userId = userId;
        this.fullName = fullName;
        this.phone = phone;
        this.location = location;
        this.bio = bio;
        this.resumePath = resumePath;
        this.linkedinUrl = linkedinUrl;
        this.githubUrl = githubUrl;
        this.experienceYears = experienceYears;
    }

    // Full Constructor
    public SeekerProfile(Long id, Long userId, String fullName,
                         String phone, String location,
                         String bio, String resumePath,
                         String linkedinUrl, String githubUrl,
                         Integer experienceYears) {

        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.phone = phone;
        this.location = location;
        this.bio = bio;
        this.resumePath = resumePath;
        this.linkedinUrl = linkedinUrl;
        this.githubUrl = githubUrl;
        this.experienceYears = experienceYears;
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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }

    public String getLinkedinUrl() {
        return linkedinUrl;
    }

    public void setLinkedinUrl(String linkedinUrl) {
        this.linkedinUrl = linkedinUrl;
    }

    public String getGithubUrl() {
        return githubUrl;
    }

    public void setGithubUrl(String githubUrl) {
        this.githubUrl = githubUrl;
    }

    public Integer getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(Integer experienceYears) {
        this.experienceYears = experienceYears;
    }

    @Override
    public String toString() {
        return "SeekerProfile [id=" + id +
                ", userId=" + userId +
                ", fullName=" + fullName +
                ", phone=" + phone +
                ", location=" + location +
                ", bio=" + bio +
                ", resumePath=" + resumePath +
                ", linkedinUrl=" + linkedinUrl +
                ", githubUrl=" + githubUrl +
                ", experienceYears=" + experienceYears + "]";
    }
}