// DuplicateApplicationException.java
package com.smartHire.exception;

public class DuplicateApplicationException extends AppException {
    public DuplicateApplicationException(String message) {
        super(message, 409);
    }
}