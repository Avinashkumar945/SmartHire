package com.smartHire.model;

public class SeekerSkill {

    private Long seekerId;
    private Long skillId;

    // Default Constructor
    public SeekerSkill() {
    }

    // Constructor
    public SeekerSkill(Long seekerId, Long skillId) {
        this.seekerId = seekerId;
        this.skillId = skillId;
    }

    public Long getSeekerId() {
        return seekerId;
    }

    public void setSeekerId(Long seekerId) {
        this.seekerId = seekerId;
    }

    public Long getSkillId() {
        return skillId;
    }

    public void setSkillId(Long skillId) {
        this.skillId = skillId;
    }

    @Override
    public String toString() {
        return "SeekerSkill [seekerId=" + seekerId +
               ", skillId=" + skillId + "]";
    }
}