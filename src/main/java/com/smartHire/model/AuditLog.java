package com.smartHire.model;

import java.time.LocalDateTime;

public class AuditLog {

    private Long id;
    private Long userId;

    private String action;
    private String entityType;
    private Long entityId;

    private String details;
    private String ipAddress;

    private LocalDateTime timestamp;

    // Default Constructor
    public AuditLog() {
    }

    // Constructor for creating a new audit log
    public AuditLog(Long userId, String action,
                    String entityType, Long entityId,
                    String details, String ipAddress) {

        this.userId = userId;
        this.action = action;
        this.entityType = entityType;
        this.entityId = entityId;
        this.details = details;
        this.ipAddress = ipAddress;
    }

    // Full Constructor
    public AuditLog(Long id, Long userId,
                    String action, String entityType,
                    Long entityId, String details,
                    String ipAddress, LocalDateTime timestamp) {

        this.id = id;
        this.userId = userId;
        this.action = action;
        this.entityType = entityType;
        this.entityId = entityId;
        this.details = details;
        this.ipAddress = ipAddress;
        this.timestamp = timestamp;
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

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getEntityType() {
        return entityType;
    }

    public void setEntityType(String entityType) {
        this.entityType = entityType;
    }

    public Long getEntityId() {
        return entityId;
    }

    public void setEntityId(Long entityId) {
        this.entityId = entityId;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "AuditLog [id=" + id +
                ", userId=" + userId +
                ", action=" + action +
                ", entityType=" + entityType +
                ", entityId=" + entityId +
                ", details=" + details +
                ", ipAddress=" + ipAddress +
                ", timestamp=" + timestamp + "]";
    }
}