<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.smartHire.model.User" %>
<!DOCTYPE html>
<html>
<head></head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String role = (currentUser != null) 
                  ? currentUser.getRole().name() 
                  : "";

    // set profile URL based on role
    String profileUrl  = "#";
    String dashboardUrl = "#";

    if ("JOB_SEEKER".equals(role)) {
        profileUrl   = request.getContextPath() + "/seeker/profile";
        dashboardUrl = request.getContextPath() + "/seeker/dashboard";
    } else if ("RECRUITER".equals(role)) {
        profileUrl   = request.getContextPath() + "/recruiter/company";
        dashboardUrl = request.getContextPath() + "/recruiter/dashboard";
    } else if ("ADMIN".equals(role)) {
        profileUrl   = request.getContextPath() + "/admin/profile";
        dashboardUrl = request.getContextPath() + "/admin/dashboard";
    }
%>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold text-primary fs-4"
           href="<%= dashboardUrl %>">
            SmartHire
        </a>

        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- Nav Links — changes based on role -->
            <ul class="navbar-nav me-auto">

                <% if ("JOB_SEEKER".equals(role)) { %>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/seeker/dashboard">
                            🏠 Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/seeker/jobs">
                            🔍 Browse Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/seeker/applications">
                            📋 My Applications
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/seeker/saved-jobs">
                            🔖 Saved Jobs
                        </a>
                    </li>

                <% } else if ("RECRUITER".equals(role)) { %>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/recruiter/dashboard">
                            🏠 Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/recruiter/post-job">
                            ➕ Post Job
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/recruiter/jobs">
                            📋 My Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/recruiter/applications">
                            👥 Applicants
                        </a>
                    </li>

                <% } else if ("ADMIN".equals(role)) { %>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/admin/dashboard">
                            🏠 Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/admin/users">
                            👥 Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/admin/companies">
                            🏢 Companies
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/admin/jobs">
                            📋 Jobs
                        </a>
                    </li>
                <% } %>

            </ul>

            <!-- Right side — profile dropdown -->
            <ul class="navbar-nav ms-auto align-items-center">

                <% if (currentUser != null) { %>

                    <li class="nav-item dropdown">

                        <!-- Profile button -->
                        <a class="nav-link dropdown-toggle
                                  d-flex align-items-center gap-2"
                           href="#"
                           id="profileDropdown"
                           data-bs-toggle="dropdown">

                            <!-- Avatar circle -->
                            <div style="width:34px; height:34px;
                                        border-radius:50%;
                                        background:#0d6efd;
                                        display:flex;
                                        align-items:center;
                                        justify-content:center;
                                        color:white;
                                        font-weight:700;
                                        font-size:14px;">
                                <%= currentUser.getEmail()
                                               .substring(0,1)
                                               .toUpperCase() %>
                            </div>

                            <!-- Role badge -->
                            <span style="font-size:13px;
                                         font-weight:500;">
                                <% if ("JOB_SEEKER".equals(role)) { %>
                                    Job Seeker
                                <% } else if ("RECRUITER".equals(role)) { %>
                                    Recruiter
                                <% } else if ("ADMIN".equals(role)) { %>
                                    Admin
                                <% } %>
                            </span>

                        </a>

                        <!-- Dropdown menu -->
                        <ul class="dropdown-menu dropdown-menu-end
                                   shadow border-0"
                            style="border-radius:12px;
                                   min-width:200px;
                                   padding:8px;">

                            <!-- Email display -->
                            <li>
                                <div class="px-3 py-2">
                                    <div style="font-size:12px;
                                                color:#6c757d;">
                                        Signed in as
                                    </div>
                                    <div style="font-size:13px;
                                                font-weight:600;
                                                word-break:break-all;">
                                        <%= currentUser.getEmail() %>
                                    </div>
                                </div>
                            </li>

                            <li><hr class="dropdown-divider my-1"/></li>

                            <!-- Profile link — role based -->
                            <li>
                                <a class="dropdown-item rounded-2"
                                   href="<%= profileUrl %>">
                                    👤 My Profile
                                </a>
                            </li>

                            <!-- Dashboard link -->
                            <li>
                                <a class="dropdown-item rounded-2"
                                   href="<%= dashboardUrl %>">
                                    🏠 Dashboard
                                </a>
                            </li>

                            <li><hr class="dropdown-divider my-1"/></li>

                            <!-- Logout -->
                            <li>
                                <a class="dropdown-item rounded-2
                                          text-danger"
                                   href="<%= request.getContextPath() %>/logout">
                                    🚪 Logout
                                </a>
                            </li>

                        </ul>
                    </li>

                <% } else { %>
                    <li class="nav-item">
                        <a class="btn btn-primary btn-sm"
                           style="border-radius:8px;"
                           href="<%= request.getContextPath() %>/login">
                            Sign In
                        </a>
                    </li>
                <% } %>

            </ul>

        </div>
    </div>
</nav>