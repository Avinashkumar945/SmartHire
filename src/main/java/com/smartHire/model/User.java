package com.smartHire.model;

import java.time.LocalDateTime;

public class User {
	private Long id;          
    private String email;
    private String password   ;
    public enum Role{
    	JOB_SEEKER,RECRUITER,ADMIN
    }
    
    public enum Status {
        ACTIVE, SUSPENDED, PENDING_VERIFICATION
    }
    private Role role;      
	private Status status;
    private LocalDateTime createdAt ;
    private LocalDateTime updatedAt ;
    
    public User() {
		super();
		// TODO Auto-generated constructor stub
	}
    
    public User(String email, String password, Role role) {
        this.email    = email;
        this.password = password;
        this.role     = role;
        this.status   = Status.PENDING_VERIFICATION;
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) { 
		this.createdAt = createdAt; 
		}
	
	public void setUpdatedAt(LocalDateTime updatedAt) { 
		this.updatedAt = updatedAt; 
		}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	@Override
	public String toString() {
		return "Users [id=" + id + ", email=" + email + ", password=" + password + ", role=" + role + ", status="
				+ status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + "]";
	}

	
    
    
    
}
