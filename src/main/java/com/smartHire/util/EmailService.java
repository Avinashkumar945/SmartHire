package com.smartHire.util;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import com.smartHire.exception.AppException;

public class EmailService {

    private static final String FROM_EMAIL   = "avinash732004kumar@gmail.com";
    private static final String APP_PASSWORD = "obqrromonordqimc";

    public static void sendVerificationEmail(String toEmail,
                                              String token) {

        String verifyLink =
            "http://localhost:8080/SmartHire2/verify?token=" + token;

        String subject = "Verify your SmartHire account";

        String body =
            "<div style='font-family:Arial,sans-serif; max-width:600px; margin:auto;'>" +
            "<h2 style='color:#0d6efd;'>Welcome to SmartHire!</h2>" +
            "<p>Thank you for registering. Click the button below " +
            "to verify your email address:</p>" +
            "<div style='text-align:center; margin:30px 0;'>" +
            "<a href='" + verifyLink + "' style='background:#0d6efd; " +
            "color:white; padding:12px 30px; border-radius:8px; " +
            "text-decoration:none; font-weight:bold;'>" +
            "Verify Email Address</a></div>" +
            "<p style='color:#6c757d; font-size:13px;'>" +
            "This link expires in 24 hours.<br>" +
            "If you did not register on SmartHire, " +
            "ignore this email.</p></div>";

        Properties props = new Properties();
        props.put("mail.smtp.auth",            "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host",            "smtp.gmail.com");
        props.put("mail.smtp.port",            "587");

        Session session = Session.getInstance(props,
            new Authenticator() {
                @Override
                protected PasswordAuthentication
                        getPasswordAuthentication() {
                    return new PasswordAuthentication(
                        FROM_EMAIL, APP_PASSWORD
                    );
                }
            });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );
            message.setSubject(subject);
            message.setContent(body, "text/html; charset=utf-8");

            Transport.send(message);

            System.out.println(
                "[SmartHire] Verification email sent to: " + toEmail
            );

        } catch (MessagingException e) {
            throw new AppException(
                "Failed to send email: " + e.getMessage(), 500
            );
        }
    }

    // private constructor — utility class
    private EmailService() {}
}