// UserNotFoundException.java
package com.smartHire.exception;

public class UserNotFoundException extends AppException {
    public UserNotFoundException(String message) {
        super(message, 404);
    }
}