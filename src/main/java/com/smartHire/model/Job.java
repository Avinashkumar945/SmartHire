package com.smartHire.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Job {
	
	public enum JobType{
		FULL_TIME,PART_TIME,INTERNSHIP,CONTRACT
	}
	public enum JobStatus{
		DRAFT,ACTIVE,CLOSED,FLAGGED;
	}

    private Long id;
    private Long companyId;
    private Long postedBy;

    private String title;
    private String description;
    private String location;
    

    private JobType jobType;

    private BigDecimal salaryMin;
    private BigDecimal salaryMax;

    private Integer experienceRequired;

    private LocalDate deadline;

    private JobStatus status;

    private LocalDateTime createdAt;

    // Default Constructor
    public Job() {
    }

    // Constructor for creating a new Job
    public Job(Long companyId, Long postedBy, String title,
               String description, String location,
               JobType jobType, BigDecimal salaryMin,
               BigDecimal salaryMax, Integer experienceRequired,
               LocalDate deadline) {

        this.companyId = companyId;
        this.postedBy = postedBy;
        this.title = title;
        this.description = description;
        this.location = location;
        this.jobType = jobType;
        this.salaryMin = salaryMin;
        this.salaryMax = salaryMax;
        this.experienceRequired = experienceRequired;
        this.deadline = deadline;
    }

    // Getters and Setters
}