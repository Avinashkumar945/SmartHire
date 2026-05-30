package com.smartHire.model;

import java.time.LocalDateTime;

public class Company {

    private Long id;
    private String name;
    private String website;
    private String industry;
    private String sizeRange;
    private String description;
    private String logoPath;
    private boolean verified;
    private LocalDateTime createdAt;
    
    
	public Company(String name, String website, String industry, String sizeRange, String description,
			String logoPath) {
		super();
		this.name = name;
		this.website = website;
		this.industry = industry;
		this.sizeRange = sizeRange;
		this.description = description;
		this.logoPath = logoPath;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getSizeRange() {
		return sizeRange;
	}
	public void setSizeRange(String sizeRange) {
		this.sizeRange = sizeRange;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getLogoPath() {
		return logoPath;
	}
	public void setLogoPath(String logoPath) {
		this.logoPath = logoPath;
	}
	public boolean isVerified() {
		return verified;
	}
	public void setVerified(boolean verified) {
		this.verified = verified;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	@Override
	public String toString() {
		return "Company [id=" + id + ", name=" + name + ", website=" + website + ", industry=" + industry
				+ ", sizeRange=" + sizeRange + ", description=" + description + ", logoPath=" + logoPath + ", verified="
				+ verified + ", createdAt=" + createdAt + "]";
	}
    
	
}