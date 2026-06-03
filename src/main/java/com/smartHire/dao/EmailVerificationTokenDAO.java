package com.smartHire.dao;

import com.smartHire.model.EmailVerificationToken;
import java.util.Optional;

public interface EmailVerificationTokenDAO {

    // called after registration
    // saves token to database
    EmailVerificationToken save(EmailVerificationToken token);

    // called when user clicks link in email
    // finds token by its value
    Optional<EmailVerificationToken> findByToken(String token);

    // called after successful verification
    // marks token as used so it cannot be used again
    void markAsUsed(Long long1);
}