<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartHire — Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" 
          rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-card {
            max-width: 420px;
            margin: 100px auto;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .brand-title {
            color: #0d6efd;
            font-weight: 700;
            font-size: 28px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card login-card p-4">
    
    
     <% if ("true".equals(request.getParameter("verified"))) { %>
    <div class="alert alert-success">
        ✅ Email verified! You can now sign in.
    </div>
    <% } %>

    <% if ("true".equals(request.getParameter("registered"))) { %>
      <div class="alert alert-info">
        📧 Check your email to verify your account before signing in.
      </div>
    <% } %>
        
        <%-- Show success message after registration --%>
    <% if ("true".equals(request.getParameter("registered"))) { %>
      <div class="alert alert-success">
        Account created successfully! Please sign in.
      </div>
    <% } %>

        <!-- Brand -->
        <div class="text-center mb-4">
            <h1 class="brand-title">SmartHire</h1>
            <p class="text-muted">Sign in to your account</p>
        </div>

        <!-- Error Message -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <!-- Success Message -->
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("successMessage") %>
            </div>
        <% } %>

        <!-- Login Form -->
        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="mb-3">
                <label class="form-label fw-semibold">Email address</label>
                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter your email"
                       required/>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Password</label>
                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="Enter your password"
                       required/>
            </div>

            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-primary btn-lg">
                    Sign In
                </button>
            </div>

        </form>

        <!-- Register Link -->
        <div class="text-center mt-3">
            <p class="text-muted">
                Don't have an account?
                <a href="${pageContext.request.contextPath}/register">
                    Register here
                </a>
            </p>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>