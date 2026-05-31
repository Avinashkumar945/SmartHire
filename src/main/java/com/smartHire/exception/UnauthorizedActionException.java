// UnauthorizedActionException.java
package com.smartHire.exception;

public class UnauthorizedActionException extends AppException {
    public UnauthorizedActionException(String message) {
        super(message, 403);
    }
}