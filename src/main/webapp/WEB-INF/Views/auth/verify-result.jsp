<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SmartHire — Email Verification</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card border-0 shadow-sm p-5 text-center"
                 style="border-radius:16px;">

                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div style="font-size:56px;">❌</div>
                    <h4 class="text-danger mt-3">Verification Failed</h4>
                    <p class="text-muted mt-2">
                        <%= request.getAttribute("errorMessage") %>
                    </p>
                    <a href="${pageContext.request.contextPath}/register"
                       class="btn btn-primary mt-3">
                        Register Again
                    </a>
                <% } %>

            </div>
        </div>
    </div>
</div>
</body>
</html>