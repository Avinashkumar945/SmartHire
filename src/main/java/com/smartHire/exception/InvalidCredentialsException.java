// InvalidCredentialsException.java
package com.smartHire.exception;

public class InvalidCredentialsException extends AppException {
    public InvalidCredentialsException(String message) {
        super(message, 401);
    }
}