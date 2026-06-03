package com.smartHire.servlet.auth;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smartHire.dao.EmailVerificationTokenDAO;
import com.smartHire.dao.impl.EmailVerificationTokenDAOImpl;
import com.smartHire.dao.impl.UserDAOImpl;
import com.smartHire.model.EmailVerificationToken;
import com.smartHire.model.User;

@WebServlet("/verify")
public class VerifyEmailServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private EmailVerificationTokenDAO tokenDao;
    private UserDAOImpl userDao;

    @Override
    public void init() throws ServletException {
        tokenDao = new EmailVerificationTokenDAOImpl();
        userDao  = new UserDAOImpl();
    }
    
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // read token from URL ? /verify?token=abc123
        String tokenValue = request.getParameter("token");

        // Check 1 — token missing from URL
        if (tokenValue == null || tokenValue.isBlank()) {
            request.setAttribute("errorMessage",
                "Invalid verification link.");
            forward(request, response);
            return;
        }

        // Check 2 — token not found in database
        Optional<EmailVerificationToken> optToken =
            tokenDao.findByToken(tokenValue);

        if (optToken.isEmpty()) {
            request.setAttribute("errorMessage",
                "Invalid verification link.");
            forward(request, response);
            return;
        }

        EmailVerificationToken token = optToken.get();

        // Check 3 — token already used
        if (token.isUsed()) {
            request.setAttribute("errorMessage",
                "This link has already been used. Please login.");
            forward(request, response);
            return;
        }

        // Check 4 — token expired
        if (token.getExpiresAt().isBefore(LocalDateTime.now())) {
            request.setAttribute("errorMessage",
                "This link has expired. Please register again.");
            forward(request, response);
            return;
        }

        // All checks passed — activate user
        userDao.updateStatus(
            token.getUserId().intValue(),
            User.Status.ACTIVE
        );

        // Mark token as used — cannot be clicked again
        tokenDao.markAsUsed(token.getId());

        // Redirect to login with success message
        response.sendRedirect(
            request.getContextPath() + "/login?verified=true"
        );
    }

    // helper method — avoids repeating forward code
    private void forward(HttpServletRequest req,
                         HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher(
            "/WEB-INF/Views/auth/verify-result.jsp"
        ).forward(req, res);
    }
}