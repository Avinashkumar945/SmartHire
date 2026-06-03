<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartHire — Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f0f2f5;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .register-wrapper {
            width: 100%;
            max-width: 480px;
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }
        .brand-title {
            font-size: 32px;
            font-weight: 800;
            color: #0d6efd;
            letter-spacing: -1px;
        }
        .brand-subtitle {
            color: #6c757d;
            font-size: 15px;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 16px;
            border: 1.5px solid #dee2e6;
            font-size: 15px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13,110,253,0.1);
        }
        .btn-register {
            border-radius: 10px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
            background: #0d6efd;
            border: none;
            transition: background 0.2s;
        }
        .btn-register:hover {
            background: #0b5ed7;
        }
        .role-card {
            border: 2px solid #dee2e6;
            border-radius: 12px;
            padding: 16px;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
        }
        .role-card:hover {
            border-color: #0d6efd;
            background: #f0f6ff;
        }
        .role-card input[type="radio"] {
            display: none;
        }
        .role-card.selected {
            border-color: #0d6efd;
            background: #e8f0fe;
        }
        .role-icon {
            font-size: 32px;
            margin-bottom: 8px;
        }
        .role-label {
            font-weight: 600;
            font-size: 14px;
            color: #212529;
        }
        .role-desc {
            font-size: 12px;
            color: #6c757d;
            margin-top: 4px;
        }
        .divider {
            display: flex;
            align-items: center;
            gap: 12px;
            color: #adb5bd;
            font-size: 13px;
            margin: 8px 0;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #dee2e6;
        }
        .password-toggle {
            position: relative;
        }
        .password-toggle .toggle-btn {
            position: absolute;
            right: 14px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            font-size: 18px;
            padding: 0;
        }
    </style>
</head>
<body>

<div class="register-wrapper">
    <div class="card p-4 p-md-5">

        <!-- Brand -->
        <div class="text-center mb-4">
            <div class="brand-title">SmartHire</div>
            <div class="brand-subtitle">Create your account and get started</div>
        </div>

        <!-- Error Message -->
        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <strong>Error:</strong> <%= request.getAttribute("errorMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Success Message -->
        <% if (request.getAttribute("successMessage") != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <%= request.getAttribute("successMessage") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <!-- Register Form -->
        <form action="${pageContext.request.contextPath}/register"
              method="post"
              id="registerForm">

        <!-- Role Selection -->
            <div class="mb-4">
                <label class="form-label fw-semibold mb-3">I am registering as</label>
                <div class="row g-3">

                    <div class="col-6">
                        <label class="role-card w-100" id="seekerCard">
                            <input type="radio"
                                   name="role"
                                   value="JOB_SEEKER"
                                   />
                            <div class="role-icon">👤</div>
                            <div class="role-label">Job Seeker</div>
                            <div class="role-desc">Looking for opportunities</div>
                        </label>
                    </div>

                    <div class="col-6">
                        <label class="role-card w-100" id="recruiterCard">
                            <input type="radio"
                                   name="role"
                                   value="RECRUITER"/>
                            <div class="role-icon">🏢</div>
                            <div class="role-label">Recruiter</div>
                            <div class="role-desc">Hiring for my company</div>
                        </label>
                    </div>
                    
                    <div id="roleError"
                       class="text-danger mt-2"
                        style="display:none;">
                      Please select a role.
                    </div>

                </div>
            </div>

            <div class="divider">your details</div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label fw-semibold">
                    Email address
                </label>
                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="you@example.com"
                       value="<%= request.getAttribute("email") != null
                                  ? request.getAttribute("email") : "" %>"
                       required/>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label class="form-label fw-semibold">Password</label>
                <div class="password-toggle">
                    <input type="password"
                           name="password"
                           id="password"
                           class="form-control pe-5"
                           placeholder="Min. 8 characters"
                           required/>
                    <button type="button"
                            class="toggle-btn"
                            onclick="togglePassword('password', this)">
                        👁
                    </button>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="mb-4">
                <label class="form-label fw-semibold">
                    Confirm Password
                </label>
                <div class="password-toggle">
                    <input type="password"
                           name="confirmPassword"
                           id="confirmPassword"
                           class="form-control pe-5"
                           placeholder="Repeat your password"
                           required/>
                    <button type="button"
                            class="toggle-btn"
                            onclick="togglePassword('confirmPassword', this)">
                        👁
                    </button>
                </div>
                <div id="passwordError"
                     class="text-danger mt-1"
                     style="font-size:13px; display:none;">
                    Passwords do not match.
                </div>
            </div>

            <!-- Submit -->
            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-register">
                    Create Account
                </button>
            </div>

        </form>

        <!-- Login Link -->
        <div class="text-center mt-4">
            <span class="text-muted" style="font-size:14px;">
                Already have an account?
            </span>
            <a href="${pageContext.request.contextPath}/login"
               class="fw-semibold text-decoration-none ms-1">
                Sign in
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
   const role =
        document.querySelector('input[name="role"]:checked');

  if (!role) {
    document.getElementById('roleError').style.display = 'block';
    valid = false;
    } else {
      document.getElementById('roleError').style.display = 'none';
    }
  
  document.querySelectorAll('input[name="role"]')
  .forEach(radio => {
      radio.addEventListener('change', function () {
          document.getElementById('roleError').style.display = 'none';
      });
  });



    // Role card selection highlight
    document.querySelectorAll('.role-card input[type="radio"]')
        .forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.role-card')
                    .forEach(card => card.classList.remove('selected'));
                this.closest('.role-card').classList.add('selected');
            });
        });

    // Password show/hide toggle
    function togglePassword(fieldId, btn) {
        const field = document.getElementById(fieldId);
        if (field.type === 'password') {
            field.type = 'text';
            btn.textContent = '🙈';
        } else {
            field.type = 'password';
            btn.textContent = '👁';
        }
    }

    // Client side password match validation
    document.getElementById('registerForm')
        .addEventListener('submit', function(e) {
            const password        = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const errorDiv        = document.getElementById('passwordError');

            if (password !== confirmPassword) {
                e.preventDefault();
                errorDiv.style.display = 'block';
            } else {
                errorDiv.style.display = 'none';
            }
        });

</script>
</body>
</html>