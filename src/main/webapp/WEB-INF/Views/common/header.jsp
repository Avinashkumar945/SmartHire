<%@ page language="java" 
         contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" 
           uri="http://java.sun.com/jsp/jstl/core"%>

<%
    com.smartHire.model.User currentUser = 
        (com.smartHire.model.User) 
        session.getAttribute("currentUser");
%>

<%-- opening nav tag was missing --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">

        <!-- Brand -->
        <a class="navbar-brand fw-bold" 
           href="${pageContext.request.contextPath}/">
            SmartHire
        </a>

        <!-- Toggle for mobile -->
        <button class="navbar-toggler" 
                type="button" 
                data-bs-toggle="collapse"
                data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">

            <!-- Left side links -->
            <ul class="navbar-nav me-auto">

                <%-- Seeker links --%>
                <% if (currentUser != null && 
                       currentUser.getRole() == 
                       com.smartHire.model.User.Role.JOB_SEEKER) { %>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/seeker/dashboard">
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/seeker/jobs">
                            Find Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/seeker/applications">
                            My Applications
                        </a>
                    </li>
                <% } %>

                <%-- Recruiter links --%>
                <% if (currentUser != null && 
                       currentUser.getRole() == 
                       com.smartHire.model.User.Role.RECRUITER) { %>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/recruiter/dashboard">
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/recruiter/jobs">
                            My Jobs
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/recruiter/pipeline">
                            Pipeline
                        </a>
                    </li>
                <% } %>

                <%-- Admin links --%>
                <% if (currentUser != null && 
                       currentUser.getRole() == 
                       com.smartHire.model.User.Role.ADMIN) { %>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/admin/dashboard">
                            Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/admin/users">
                            Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" 
                           href="${pageContext.request.contextPath}/admin/companies">
                            Companies
                        </a>
                    </li>
                <% } %>

            </ul>

            <!-- Right side — user info + logout -->
            <ul class="navbar-nav ms-auto">
                <% if (currentUser != null) { %>

                    <!-- Show logged in email -->
                    <li class="nav-item">
                        <span class="nav-link text-white-50">
                            👤 <%= currentUser.getEmail() %>
                        </span>
                    </li>

                    <!-- Logout button -->
                    <li class="nav-item">
                        <a class="nav-link btn btn-outline-light 
                                  btn-sm px-3 ms-2"
                           href="${pageContext.request.contextPath}/logout">
                            Logout
                        </a>
                    </li>

                <% } %>
            </ul>

        </div>
    </div>
</nav>