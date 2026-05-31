// InvalidWorkflowTransitionException.java
package com.smartHire.exception;

public class InvalidWorkflowTransitionException extends AppException {
    public InvalidWorkflowTransitionException(String message) {
        super(message, 400);
    }
}