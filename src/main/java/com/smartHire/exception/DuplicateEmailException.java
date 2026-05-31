// DuplicateEmailException.java
package com.smartHire.exception;

public class DuplicateEmailException extends AppException {
    public DuplicateEmailException(String message) {
        super(message, 409);
    }
}