<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartHire — Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .welcome-banner {
            background: linear-gradient(135deg, #0d6efd, #0099ff);
            color: white;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
        }
        .stat-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            transition: transform 0.2s;
            cursor: pointer;
        }
        .stat-card:hover { transform: translateY(-4px); }
        .stat-icon { font-size: 36px; margin-bottom: 8px; }
        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #0d6efd;
        }
        .stat-label { color: #6c757d; font-size: 14px; }
        .section-title {
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 16px;
            color: #212529;
        }
        .job-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            transition: transform 0.2s;
        }
        .job-card:hover { transform: translateY(-2px); }
        .company-logo {
            width: 48px;
            height: 48px;
            border-radius: 8px;
            background: #e9ecef;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .status-badge {
            font-size: 12px;
            padding: 4px 12px;
            border-radius: 20px;
        }
        .quick-action-btn {
            border-radius: 12px;
            padding: 16px;
            font-weight: 600;
            transition: all 0.2s;
        }
        .profile-completion {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        .progress { height: 8px; border-radius: 4px; }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/Views/common/header.jsp" />
 
<div class="container py-4">

    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div class="row align-items-center">
            <div class="col">
                <h2 class="mb-1 fw-bold">Welcome back! 👋</h2>
                <p class="mb-0 opacity-75">
                    ${sessionScope.currentUser.name}
                </p>
                <p class="mb-0 opacity-75 mt-1">
                    Find your dream job today.
                </p>
            </div>
            <div class="col-auto d-none d-md-block">
                <a href="${pageContext.request.contextPath}/seeker/jobs"
                   class="btn btn-light fw-bold px-4 py-2">
                    🔍 Search Jobs
                </a>
            </div>
        </div>
    </div>

    <!-- Stats Row -->
    <div class="row g-3 mb-4">

        <div class="col-6 col-md-3">
            <div class="card stat-card p-3 text-center"
                 onclick="window.location=
                 '${pageContext.request.contextPath}/seeker/applications'">
                <div class="stat-icon">📋</div>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty totalApplications}">
                            ${totalApplications}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">Total Applications</div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="card stat-card p-3 text-center">
                <div class="stat-icon">⏳</div>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty pendingApplications}">
                            ${pendingApplications}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">Under Review</div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="card stat-card p-3 text-center">
                <div class="stat-icon">✅</div>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty shortlistedApplications}">
                            ${shortlistedApplications}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">Shortlisted</div>
            </div>
        </div>

        <div class="col-6 col-md-3">
            <div class="card stat-card p-3 text-center"
                 onclick="window.location=
                 '${pageContext.request.contextPath}/seeker/saved-jobs'">
                <div class="stat-icon">🔖</div>
                <div class="stat-number">
                    <c:choose>
                        <c:when test="${not empty savedJobs}">
                            ${savedJobs}
                        </c:when>
                        <c:otherwise>0</c:otherwise>
                    </c:choose>
                </div>
                <div class="stat-label">Saved Jobs</div>
            </div>
        </div>

    </div>

    <div class="row g-4">

        <!-- Left Column -->
        <div class="col-lg-8">

            <!-- Recent Applications -->
            <div class="mb-4">
                <div class="d-flex justify-content-between
                            align-items-center mb-3">
                    <div class="section-title mb-0">
                        Recent Applications
                    </div>
                    <a href="${pageContext.request.contextPath}/seeker/applications"
                       class="text-primary text-decoration-none"
                       style="font-size:14px;">
                        View all →
                    </a>
                </div>

                <c:choose>
                    <c:when test="${not empty recentApplications}">
                        <c:forEach var="app"
                                   items="${recentApplications}">
                            <div class="card job-card p-3 mb-3">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="company-logo">🏢</div>
                                    <div class="flex-grow-1">
                                        <div class="fw-semibold">
                                            ${app.jobTitle}
                                        </div>
                                        <div class="text-muted"
                                             style="font-size:13px;">
                                            ${app.companyName}
                                        </div>
                                    </div>
                                    <div>
                                        <c:choose>
                                            <c:when test="${app.status == 'APPLIED'}">
                                                <span class="badge bg-primary status-badge">
                                                    Applied
                                                </span>
                                            </c:when>
                                            <c:when test="${app.status == 'SHORTLISTED'}">
                                                <span class="badge bg-warning status-badge">
                                                    Shortlisted
                                                </span>
                                            </c:when>
                                            <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}">
                                                <span class="badge bg-info status-badge">
                                                    Interview
                                                </span>
                                            </c:when>
                                            <c:when test="${app.status == 'OFFERED'}">
                                                <span class="badge bg-success status-badge">
                                                    Offered
                                                </span>
                                            </c:when>
                                            <c:when test="${app.status == 'REJECTED'}">
                                                <span class="badge bg-danger status-badge">
                                                    Rejected
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary status-badge">
                                                    ${app.status}
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="card border-0 rounded-3 p-5 text-center"
                             style="background:#f8f9fa;">
                            <div style="font-size:48px">📭</div>
                            <h5 class="mt-3 text-muted">
                                No applications yet
                            </h5>
                            <p class="text-muted"
                               style="font-size:14px;">
                                Start applying to jobs to
                                track your progress here.
                            </p>
                            <a href="${pageContext.request.contextPath}/seeker/jobs"
                               class="btn btn-primary mt-2 px-4">
                                Browse Jobs
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <!-- Latest Jobs -->
            <div>
                <div class="d-flex justify-content-between
                            align-items-center mb-3">
                    <div class="section-title mb-0">
                        Latest Jobs
                    </div>
                    <a href="${pageContext.request.contextPath}/seeker/jobs"
                       class="text-primary text-decoration-none"
                       style="font-size:14px;">
                        View all →
                    </a>
                </div>

                <c:choose>
                    <c:when test="${not empty latestJobs}">
                        <c:forEach var="job" items="${latestJobs}">
                            <div class="card job-card p-3 mb-3">
                                <div class="d-flex align-items-center gap-3">
                                    <div class="company-logo">🏢</div>
                                    <div class="flex-grow-1">
                                        <div class="fw-semibold">
                                            ${job.title}
                                        </div>
                                        <div class="text-muted"
                                             style="font-size:13px;">
                                            ${job.location} •
                                            <span class="badge bg-light
                                                         text-dark"
                                                  style="font-size:11px;">
                                                ${job.jobType}
                                            </span>
                                        </div>
                                    </div>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/seeker/jobs?id=${job.id}"
                                           class="btn btn-outline-primary btn-sm">
                                            View
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="card border-0 rounded-3 p-4 text-center"
                             style="background:#f8f9fa;">
                            <p class="text-muted mb-0">
                                No jobs available right now.
                                Check back later!
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

        </div>

        <!-- Right Column -->
        <div class="col-lg-4">

            <!-- Profile Completion -->
            <div class="card profile-completion p-4 mb-4">
                <div class="section-title">Profile Strength</div>
                <div class="progress mb-2">
                    <div class="progress-bar bg-primary"
                         style="width:
                         ${not empty profileCompletion
                           ? profileCompletion : 30}%">
                    </div>
                </div>
                <div class="d-flex justify-content-between">
                    <small class="text-muted">
                        Complete your profile
                    </small>
                    <small class="text-primary fw-bold">
                        ${not empty profileCompletion
                          ? profileCompletion : 30}%
                    </small>
                </div>
                <a href="${pageContext.request.contextPath}/seeker/profile"
                   class="btn btn-outline-primary btn-sm mt-3 w-100">
                    Complete Profile
                </a>
            </div>

            <!-- Quick Actions -->
            <div class="card border-0 rounded-3 p-4 mb-4"
                 style="box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                <div class="section-title">Quick Actions</div>
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/seeker/jobs"
                       class="btn btn-primary quick-action-btn">
                        🔍 Search Jobs
                    </a>
                    <a href="${pageContext.request.contextPath}/seeker/profile"
                       class="btn btn-outline-primary quick-action-btn">
                        👤 Edit Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/seeker/saved-jobs"
                       class="btn btn-outline-secondary quick-action-btn">
                        🔖 Saved Jobs
                    </a>
                    <a href="${pageContext.request.contextPath}/seeker/applications"
                       class="btn btn-outline-secondary quick-action-btn">
                        📋 My Applications
                    </a>
                </div>
            </div>

            <!-- Tips Card -->
            <div class="card border-0 rounded-3 p-4"
                 style="background:#e8f4fd;
                        box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                <div class="section-title">💡 Tips</div>
                <ul class="list-unstyled mb-0"
                    style="font-size:13px; color:#555;">
                    <li class="mb-2">
                        ✅ Complete your profile to get
                        noticed by recruiters
                    </li>
                    <li class="mb-2">
                        ✅ Upload your resume for
                        one-click applications
                    </li>
                    <li class="mb-2">
                        ✅ Save interesting jobs to
                        apply later
                    </li>
                    <li>
                        ✅ Check application status
                        regularly
                    </li>
                </ul>
            </div>

        </div>

    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>