package com.smartHire.model;

import java.time.LocalDateTime;

public class EmailVerificationToken {

    private Long id;
    private Long userId;
    private String token;
    private LocalDateTime expiresAt;
    private boolean used;

    // Default Constructor
    public EmailVerificationToken() {
    }

    // Constructor for creating a new token
    public EmailVerificationToken(Long userId,
                                  String token,
                                  LocalDateTime expiresAt) {
        this.userId = userId;
        this.token = token;
        this.expiresAt = expiresAt;
    }

    // Full Constructor
    public EmailVerificationToken(Long id,
                                  Long userId,
                                  String token,
                                  LocalDateTime expiresAt,
                                  boolean used) {
        this.id = id;
        this.userId = userId;
        this.token = token;
        this.expiresAt = expiresAt;
        this.used = used;
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

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public LocalDateTime getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(LocalDateTime expiresAt) {
        this.expiresAt = expiresAt;
    }

    public boolean isUsed() {
        return used;
    }

    public void setUsed(boolean used) {
        this.used = used;
    }

    @Override
    public String toString() {
        return "EmailVerificationToken [id=" + id +
                ", userId=" + userId +
                ", token=" + token +
                ", expiresAt=" + expiresAt +
                ", used=" + used + "]";
    }
}