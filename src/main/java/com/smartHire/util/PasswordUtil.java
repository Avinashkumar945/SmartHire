package com.smartHire.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

    // Hash password before saving to database
    public static String hash(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    // Verify password during login
    public static boolean verify(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    // Private constructor — utility class
    private PasswordUtil() {}
}