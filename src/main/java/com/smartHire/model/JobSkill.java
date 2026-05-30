package com.smartHire.model;

public class JobSkill {

    private Long jobId;
    private Long skillId;

    // Default Constructor
    public JobSkill() {
    }

    // Constructor
    public JobSkill(Long jobId, Long skillId) {
        this.jobId = jobId;
        this.skillId = skillId;
    }

    public Long getJobId() {
        return jobId;
    }

    public void setJobId(Long jobId) {
        this.jobId = jobId;
    }

    public Long getSkillId() {
        return skillId;
    }

    public void setSkillId(Long skillId) {
        this.skillId = skillId;
    }

    @Override
    public String toString() {
        return "JobSkill [jobId=" + jobId +
               ", skillId=" + skillId + "]";
    }
}