<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.smartHire.model.User" %>
<%@ page import="com.smartHire.model.SeekerProfile" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartHire — My Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f0f2f5; }

        .navbar-brand {
            font-weight: 800;
            font-size: 22px;
            color: #0d6efd !important;
        }

        .profile-card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.07);
        }

        .avatar {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: #0d6efd;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 36px;
            color: white;
            font-weight: 700;
            flex-shrink: 0;
        }

        .section-title {
            font-size: 13px;
            font-weight: 700;
            color: #6c757d;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid #f0f2f5;
            padding-bottom: 8px;
            margin-bottom: 20px;
        }

        .info-row {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid #f0f2f5;
        }

        .info-row:last-child { border-bottom: none; }

        .info-label {
            font-size: 13px;
            color: #6c757d;
            min-width: 140px;
            font-weight: 500;
        }

        .info-value {
            font-size: 14px;
            color: #212529;
            font-weight: 500;
        }

        .incomplete-banner {
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            border: none;
            border-radius: 14px;
            padding: 24px;
        }

        .progress {
            height: 10px;
            border-radius: 10px;
        }

        .form-control, .form-select {
            border-radius: 10px;
            border: 1.5px solid #dee2e6;
            padding: 10px 14px;
        }

        .form-control:focus, .form-select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 0 3px rgba(13,110,253,0.1);
        }

        .resume-box {
            border: 2px dashed #dee2e6;
            border-radius: 12px;
            padding: 24px;
            text-align: center;
            background: #fafafa;
            cursor: pointer;
            transition: all 0.2s;
        }

        .resume-box:hover {
            border-color: #0d6efd;
            background: #f0f6ff;
        }

        /* smooth form slide */
        #profileForm {
            display: none;
        }
    </style>
</head>
<body>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    SeekerProfile profile = (SeekerProfile) request.getAttribute("seeker");
    boolean hasProfile = (profile != null);

    // calculate completion percentage
    int totalFields = 7;
    int filledFields = 0;

    if (hasProfile) {
        if (profile.getPhone()       != null && !profile.getPhone().isBlank())       filledFields++;
        if (profile.getLocation()    != null && !profile.getLocation().isBlank())    filledFields++;
        if (profile.getBio()         != null && !profile.getBio().isBlank())         filledFields++;
        if (profile.getResumePath()  != null && !profile.getResumePath().isBlank())  filledFields++;
        if (profile.getLinkedinUrl() != null && !profile.getLinkedinUrl().isBlank()) filledFields++;
        if (profile.getGithubUrl()   != null && !profile.getGithubUrl().isBlank())   filledFields++;
    }

    int completionPercent = hasProfile
        ? (filledFields * 100) / totalFields
        : 0;

    String progressColor = completionPercent < 40 ? "bg-danger"
                         : completionPercent < 75 ? "bg-warning"
                         : "bg-success";

    // show form if redirected after error OR if user clicked edit
    boolean showForm = request.getAttribute("errorMessage") != null
                    || "true".equals(request.getParameter("edit"));
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="#">SmartHire</a>
        <div class="d-flex align-items-center gap-3">
            <a href="${pageContext.request.contextPath}/seeker/dashboard"
               class="btn btn-outline-primary btn-sm"
               style="border-radius:8px;">
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-outline-danger btn-sm"
               style="border-radius:8px;">
                Logout
            </a>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <!-- Success Message -->
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success alert-dismissible fade show"
                     style="border-radius:12px;">
                    ✅ <%= request.getAttribute("successMessage") %>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- Error Message -->
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show"
                     style="border-radius:12px;">
                    ❌ <%= request.getAttribute("errorMessage") %>
                    <button type="button" class="btn-close"
                            data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <!-- ===================== -->
            <!-- PROFILE HEADER CARD  -->
            <!-- ===================== -->
            <div class="card profile-card p-4 mb-4">
                <div class="d-flex align-items-center gap-4 mb-3">

                    <div class="avatar">
                        <%= currentUser.getEmail()
                                       .substring(0,1)
                                       .toUpperCase() %>
                    </div>

                    <div class="flex-grow-1">
                        <h4 class="fw-bold mb-1">
                            <% if (hasProfile &&
                                   profile.getFullName() != null &&
                                   !profile.getFullName().isBlank()) { %>
                                <%= profile.getFullName() %>
                            <% } else { %>
                                <%= currentUser.getName() %>
                            <% } %>
                        </h4>
                        <p class="text-muted mb-2" style="font-size:14px;">
                            <%= currentUser.getName() %>
                        </p>
                        <span class="badge bg-primary">Job Seeker</span>

                        <% if (completionPercent == 100) { %>
                            <span class="badge bg-success ms-1">
                                Profile Complete ✅
                            </span>
                        <% } else { %>
                            <span class="badge bg-warning text-dark ms-1">
                                <%= completionPercent %>% Complete
                            </span>
                        <% } %>
                    </div>

                    <!-- Edit Button -->
                    <button class="btn btn-outline-primary btn-sm"
                            style="border-radius:8px; height:fit-content;"
                            onclick="toggleForm()">
                        ✏️ Edit Profile
                    </button>

                </div>

                <!-- Progress Bar -->
                <div class="mb-1 d-flex justify-content-between">
                    <span style="font-size:12px; color:#6c757d;">
                        Profile completion
                    </span>
                    <span style="font-size:12px; font-weight:600;
                                 color:#0d6efd;">
                        <%= completionPercent %>%
                    </span>
                </div>
                <div class="progress">
                    <div class="progress-bar <%= progressColor %>"
                         style="width:<%= completionPercent %>%">
                    </div>
                </div>
            </div>

            <!-- ======================== -->
            <!-- NO PROFILE YET BANNER   -->
            <!-- ======================== -->
            <% if (!hasProfile) { %>
                <div class="incomplete-banner mb-4">
                    <div class="d-flex align-items-center gap-3">
                        <div style="font-size:40px;">👋</div>
                        <div>
                            <h5 class="fw-bold mb-1">
                                Complete your profile
                            </h5>
                            <p class="text-muted mb-2"
                               style="font-size:14px;">
                                Add your details so recruiters
                                can find you. It only takes
                                2 minutes.
                            </p>
                            <button class="btn btn-warning fw-semibold"
                                    style="border-radius:8px;"
                                    onclick="toggleForm()">
                                Complete Profile Now →
                            </button>
                        </div>
                    </div>
                </div>
            <% } %>

            <!-- ===================== -->
            <!-- PROFILE VIEW SECTION -->
            <!-- ===================== -->
            <% if (hasProfile) { %>
                <div class="card profile-card p-4 mb-4"
                     id="profileView">

                    <!-- Personal Info -->
                    <div class="section-title">Personal Information</div>

                    

                    <% if (profile.getPhone() != null &&
                           !profile.getPhone().isBlank()) { %>
                        <div class="info-row">
                            <span class="info-label">Phone</span>
                            <span class="info-value">
                                <%= profile.getPhone() %>
                            </span>
                        </div>
                    <% } %>

                    <% if (profile.getLocation() != null &&
                           !profile.getLocation().isBlank()) { %>
                        <div class="info-row">
                            <span class="info-label">Location</span>
                            <span class="info-value">
                                <%= profile.getLocation() %>
                            </span>
                        </div>
                    <% } %>

                    <div class="info-row">
                        <span class="info-label">Experience</span>
                        <span class="info-value">
                            <% if (profile.getExperienceYears() == 0) { %>
                                Fresher
                            <% } else { %>
                                <%= profile.getExperienceYears() %> year(s)
                            <% } %>
                        </span>
                    </div>

                    <% if (profile.getBio() != null &&
                           !profile.getBio().isBlank()) { %>
                        <div class="info-row">
                            <span class="info-label">Bio</span>
                            <span class="info-value">
                                <%= profile.getBio() %>
                            </span>
                        </div>
                    <% } %>

                    <!-- Social Links -->
                    <% if ((profile.getLinkedinUrl() != null &&
                            !profile.getLinkedinUrl().isBlank()) ||
                           (profile.getGithubUrl() != null &&
                            !profile.getGithubUrl().isBlank())) { %>

                        <div class="section-title mt-4">
                            Social Links
                        </div>

                        <% if (profile.getLinkedinUrl() != null &&
                               !profile.getLinkedinUrl().isBlank()) { %>
                            <div class="info-row">
                                <span class="info-label">LinkedIn</span>
                                <a href="<%= profile.getLinkedinUrl() %>"
                                   target="_blank"
                                   class="info-value text-decoration-none">
                                    <%= profile.getLinkedinUrl() %>
                                </a>
                            </div>
                        <% } %>

                        <% if (profile.getGithubUrl() != null &&
                               !profile.getGithubUrl().isBlank()) { %>
                            <div class="info-row">
                                <span class="info-label">GitHub</span>
                                <a href="<%= profile.getGithubUrl() %>"
                                   target="_blank"
                                   class="info-value text-decoration-none">
                                    <%= profile.getGithubUrl() %>
                                </a>
                            </div>
                        <% } %>

                    <% } %>

                    <!-- Resume -->
                    <% if (profile.getResumePath() != null &&
                           !profile.getResumePath().isBlank()) { %>
                        <div class="section-title mt-4">Resume</div>
                        <div class="info-row">
                            <span class="info-label">Resume</span>
                            <a href="${pageContext.request.contextPath}/seeker/resume"
                               target="_blank"
                               class="btn btn-outline-primary btn-sm"
                               style="border-radius:8px;">
                                📄 View Resume
                            </a>
                        </div>
                    <% } %>

                </div>
            <% } %>

            <!-- ===================== -->
            <!-- EDIT FORM (hidden)   -->
            <!-- ===================== -->
            <div class="card profile-card p-4"
                 id="profileForm"
                 style="display: <%= showForm ? "block" : "none" %>;">

                <div class="d-flex justify-content-between
                            align-items-center mb-4">
                    <h5 class="fw-bold mb-0">Edit Profile</h5>
                    <% if (hasProfile) { %>
                        <button type="button"
                                class="btn btn-outline-secondary btn-sm"
                                style="border-radius:8px;"
                                onclick="toggleForm()">
                            ✕ Cancel
                        </button>
                    <% } %>
                </div>

                <form action="${pageContext.request.contextPath}/seeker/profile"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- Personal Information -->
                    <div class="section-title">Personal Information</div>

                    <div class="row g-3 mb-4">

                        

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                Phone Number
                            </label>
                            <input type="tel"
                                   name="phone"
                                   class="form-control"
                                   placeholder="10 digit number"
                                   value="<%= hasProfile &&
                                              profile.getPhone() != null
                                              ? profile.getPhone() : "" %>"/>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                Location
                            </label>
                            <input type="text"
                                   name="location"
                                   class="form-control"
                                   placeholder="City, State"
                                   value="<%= hasProfile &&
                                              profile.getLocation() != null
                                              ? profile.getLocation() : "" %>"/>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                Years of Experience
                            </label>
                            <select name="experienceYears"
                                    class="form-select">
                                <% int exp = hasProfile
                                       ? profile.getExperienceYears()
                                       : 0; %>
                                <option value="0"
                                    <%= exp==0 ? "selected":"" %>>
                                    Fresher (0 years)
                                </option>
                                <option value="1"
                                    <%= exp==1 ? "selected":"" %>>
                                    1 year
                                </option>
                                <option value="2"
                                    <%= exp==2 ? "selected":"" %>>
                                    2 years
                                </option>
                                <option value="3"
                                    <%= exp==3 ? "selected":"" %>>
                                    3 years
                                </option>
                                <option value="4"
                                    <%= exp==4 ? "selected":"" %>>
                                    4 years
                                </option>
                                <option value="5"
                                    <%= exp>=5 ? "selected":"" %>>
                                    5+ years
                                </option>
                            </select>
                        </div>

                        <div class="col-12">
                            <label class="form-label fw-semibold">
                                Bio / About Me
                            </label>
                            <textarea name="bio"
                                      class="form-control"
                                      rows="4"
                                      placeholder="Write a short bio..."><%= hasProfile &&
                                          profile.getBio() != null
                                          ? profile.getBio() : "" %></textarea>
                        </div>

                    </div>

                    <!-- Social Links -->
                    <div class="section-title">Social Links</div>

                    <div class="row g-3 mb-4">

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                LinkedIn URL
                            </label>
                            <input type="url"
                                   name="linkedinUrl"
                                   class="form-control"
                                   placeholder="https://linkedin.com/in/yourname"
                                   value="<%= hasProfile &&
                                              profile.getLinkedinUrl() != null
                                              ? profile.getLinkedinUrl() : "" %>"/>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">
                                GitHub URL
                            </label>
                            <input type="url"
                                   name="githubUrl"
                                   class="form-control"
                                   placeholder="https://github.com/yourname"
                                   value="<%= hasProfile &&
                                              profile.getGithubUrl() != null
                                              ? profile.getGithubUrl() : "" %>"/>
                        </div>

                    </div>

                    <!-- Resume Upload -->
                    <div class="section-title">Resume</div>

                    <div class="mb-4">
                        <% if (hasProfile &&
                               profile.getResumePath() != null &&
                               !profile.getResumePath().isBlank()) { %>
                            <div class="alert alert-info mb-3"
                                 style="border-radius:10px; font-size:13px;">
                                📄 Resume already uploaded.
                                Upload a new file to replace it.
                            </div>
                        <% } %>

                        <div class="resume-box"
                             onclick="document.getElementById('resumeFile').click()">
                            <div style="font-size:36px;">📎</div>
                            <p class="fw-semibold mb-1">
                                Click to upload resume
                            </p>
                            <p class="text-muted mb-0"
                               style="font-size:13px;">
                                PDF or DOCX — Max 5MB
                            </p>
                            <p class="text-primary mb-0"
                               id="fileName"
                               style="font-size:13px; margin-top:8px;">
                            </p>
                        </div>

                        <input type="file"
                               name="resume"
                               id="resumeFile"
                               accept=".pdf,.doc,.docx"
                               style="display:none;"
                               onchange="showFileName(this)"/>
                    </div>

                    <!-- Save Button -->
                    <div class="d-flex justify-content-end gap-2">
                        <% if (hasProfile) { %>
                            <button type="button"
                                    class="btn btn-outline-secondary"
                                    style="border-radius:10px;"
                                    onclick="toggleForm()">
                                Cancel
                            </button>
                        <% } %>
                        <button type="submit"
                                class="btn btn-primary"
                                style="border-radius:10px;
                                       padding:10px 30px;
                                       font-weight:600;">
                            Save Profile
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function toggleForm() {
        const form = document.getElementById('profileForm');
        const view = document.getElementById('profileView');

        if (form.style.display === 'none' ||
            form.style.display === '') {
            form.style.display = 'block';
            if (view) view.style.display = 'none';
            form.scrollIntoView({ behavior: 'smooth' });
        } else {
            form.style.display = 'none';
            if (view) view.style.display = 'block';
        }
    }

    function showFileName(input) {
        if (input.files && input.files[0]) {
            document.getElementById('fileName').textContent
                = '✅ ' + input.files[0].name;
        }
    }
</script>
</body>
</html>