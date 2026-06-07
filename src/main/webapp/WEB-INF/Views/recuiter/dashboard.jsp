<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartHire — Recruiter Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .welcome-banner {
            background: linear-gradient(135deg, #198754, #20c997);
            color: white;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
        }
        .setup-banner {
            background: linear-gradient(135deg, #0d6efd, #0099ff);
            color: white;
            border-radius: 16px;
            padding: 32px;
            margin-bottom: 24px;
        }
        .pending-banner {
            background: linear-gradient(135deg, #fd7e14, #ffc107);
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
            color: #198754;
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
        .applicant-card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        .avatar-sm {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #198754;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 16px;
            flex-shrink: 0;
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
        .job-status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }
        .progress { height: 8px; border-radius: 4px; }
        .setup-step {
            background: rgba(255,255,255,0.15);
            border-radius: 12px;
            padding: 16px;
            margin-top: 16px;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/Views/common/header.jsp"/>

<div class="container py-4">

    <%-- ============================================ --%>
    <%-- CASE 1 — No company set up yet              --%>
    <%-- ============================================ --%>
    <c:if test="${empty company}">

        <!-- Setup Company Banner -->
        <div class="setup-banner">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="mb-1 fw-bold">
                        Welcome to SmartHire! 👋
                    </h2>
                    <p class="mb-0 opacity-75">
                        ${sessionScope.currentUser.name}
                    </p>
                    <p class="mb-2 opacity-75 mt-1">
                        Complete your company profile to
                        start posting jobs and finding
                        great candidates.
                    </p>
                    <div class="setup-step">
                        <div class="d-flex align-items-center gap-3">
                            <span style="font-size:32px;">🏢</span>
                            <div>
                                <div class="fw-bold">
                                    Set up your company profile
                                </div>
                                <div class="opacity-75"
                                     style="font-size:13px;">
                                    Add company name, industry,
                                    website and description
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-auto d-none d-md-block">
                    <a href="${pageContext.request.contextPath}/recruiter/company/setup"
                       class="btn btn-light fw-bold px-4 py-3"
                       style="border-radius:12px; font-size:16px;">
                        🏢 Setup Company Now
                    </a>
                </div>
            </div>
        </div>

        <!-- Setup Steps Guide -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card border-0 rounded-3 p-4 text-center"
                     style="box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                    <div style="font-size:40px;">🏢</div>
                    <h6 class="fw-bold mt-3">Step 1</h6>
                    <p class="text-muted" style="font-size:13px;">
                        Set up your company profile with
                        name, industry and description
                    </p>
                    <a href="${pageContext.request.contextPath}/recruiter/company/setup"
                       class="btn btn-primary btn-sm"
                       style="border-radius:8px;">
                        Start Here
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 rounded-3 p-4 text-center"
                     style="box-shadow:0 2px 12px rgba(0,0,0,0.06);
                            opacity:0.5;">
                    <div style="font-size:40px;">⏳</div>
                    <h6 class="fw-bold mt-3">Step 2</h6>
                    <p class="text-muted" style="font-size:13px;">
                        Wait for admin to verify
                        your company profile
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card border-0 rounded-3 p-4 text-center"
                     style="box-shadow:0 2px 12px rgba(0,0,0,0.06);
                            opacity:0.5;">
                    <div style="font-size:40px;">📋</div>
                    <h6 class="fw-bold mt-3">Step 3</h6>
                    <p class="text-muted" style="font-size:13px;">
                        Start posting jobs and
                        manage your applicants
                    </p>
                </div>
            </div>
        </div>

    </c:if>

    <%-- ============================================ --%>
    <%-- CASE 2 — Company exists but not verified    --%>
    <%-- ============================================ --%>
    <c:if test="${not empty company && !company.verified}">

        <!-- Pending Verification Banner -->
        <div class="pending-banner">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="mb-1 fw-bold">
                        Verification Pending ⏳
                    </h2>
                    <p class="mb-0 opacity-75">
                        ${sessionScope.currentUser.email}
                    </p>
                    <p class="mb-2 opacity-75 mt-1">
                        Your company
                        <strong>${company.name}</strong>
                        is under review by our admin team.
                        You will be notified once verified.
                    </p>
                    <div class="setup-step">
                        <div class="d-flex align-items-center gap-3">
                            <span style="font-size:32px;">📧</span>
                            <div style="font-size:13px;"
                                 class="opacity-75">
                                We will send a notification to
                                <strong>
                                    ${sessionScope.currentUser.email}
                                </strong>
                                once your company is verified.
                                This usually takes 24-48 hours.
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-auto d-none d-md-block">
                    <a href="${pageContext.request.contextPath}/recruiter/company"
                       class="btn btn-light fw-bold px-4 py-2"
                       style="border-radius:12px;">
                        🏢 View Company Profile
                    </a>
                </div>
            </div>
        </div>

        <!-- Company Details Card -->
        <div class="card border-0 rounded-3 p-4 mb-4"
             style="box-shadow:0 2px 12px rgba(0,0,0,0.06);">
            <div class="section-title">🏢 Your Company Details</div>
            <div class="row">
                <div class="col-md-6">
                    <table class="table table-borderless"
                           style="font-size:14px;">
                        <tr>
                            <td class="text-muted fw-semibold"
                                style="width:140px;">
                                Company Name
                            </td>
                            <td>${company.name}</td>
                        </tr>
                        <tr>
                            <td class="text-muted fw-semibold">
                                Industry
                            </td>
                            <td>${company.industry}</td>
                        </tr>
                        <tr>
                            <td class="text-muted fw-semibold">
                                Size
                            </td>
                            <td>${company.sizeRange} employees</td>
                        </tr>
                        <tr>
                            <td class="text-muted fw-semibold">
                                Website
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty company.website}">
                                        <a href="${company.website}"
                                           target="_blank">
                                            ${company.website}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">
                                            Not provided
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-muted fw-semibold">
                                Status
                            </td>
                            <td>
                                <span class="badge bg-warning text-dark">
                                    ⏳ Pending Verification
                                </span>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="col-md-6">
                    <div class="text-muted fw-semibold mb-2"
                         style="font-size:14px;">
                        Description
                    </div>
                    <p class="text-muted" style="font-size:13px;">
                        ${not empty company.description
                          ? company.description
                          : "No description provided."}
                    </p>
                    <a href="${pageContext.request.contextPath}/recruiter/company/edit"
                       class="btn btn-outline-warning btn-sm"
                       style="border-radius:8px;">
                        ✏️ Edit Company Details
                    </a>
                </div>
            </div>
        </div>

    </c:if>

    <%-- ============================================ --%>
    <%-- CASE 3 — Company verified → Full Dashboard  --%>
    <%-- ============================================ --%>
    <c:if test="${not empty company && company.verified}">

        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="mb-1 fw-bold">
                        Recruiter Dashboard 🏢
                    </h2>
                    <p class="mb-0 opacity-75">
                        ${sessionScope.currentUser.email} •
                        ${company.name}
                    </p>
                    <p class="mb-0 opacity-75 mt-1">
                        Manage your job postings and applicants.
                    </p>
                </div>
                <div class="col-auto d-none d-md-block">
                    <a href="${pageContext.request.contextPath}/recruiter/post-job"
                       class="btn btn-light fw-bold px-4 py-2">
                        ➕ Post New Job
                    </a>
                </div>
            </div>
        </div>

        <!-- Stats Row -->
        <div class="row g-3 mb-4">

            <div class="col-6 col-md-3">
                <div class="card stat-card p-3 text-center"
                     onclick="window.location=
                     '${pageContext.request.contextPath}/recruiter/jobs'">
                    <div class="stat-icon">📋</div>
                    <div class="stat-number">
                        ${not empty totalJobs ? totalJobs : 0}
                    </div>
                    <div class="stat-label">Total Jobs</div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="card stat-card p-3 text-center">
                    <div class="stat-icon">✅</div>
                    <div class="stat-number">
                        ${not empty activeJobs ? activeJobs : 0}
                    </div>
                    <div class="stat-label">Active Jobs</div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="card stat-card p-3 text-center"
                     onclick="window.location=
                     '${pageContext.request.contextPath}/recruiter/applications'">
                    <div class="stat-icon">👥</div>
                    <div class="stat-number">
                        ${not empty totalApplicants
                          ? totalApplicants : 0}
                    </div>
                    <div class="stat-label">Total Applicants</div>
                </div>
            </div>

            <div class="col-6 col-md-3">
                <div class="card stat-card p-3 text-center">
                    <div class="stat-icon">🎯</div>
                    <div class="stat-number">
                        ${not empty shortlisted ? shortlisted : 0}
                    </div>
                    <div class="stat-label">Shortlisted</div>
                </div>
            </div>

        </div>

        <div class="row g-4">

            <!-- Left Column -->
            <div class="col-lg-8">

                <!-- My Job Postings -->
                <div class="mb-4">
                    <div class="d-flex justify-content-between
                                align-items-center mb-3">
                        <div class="section-title mb-0">
                            My Job Postings
                        </div>
                        <a href="${pageContext.request.contextPath}/recruiter/post-job"
                           class="btn btn-success btn-sm"
                           style="border-radius:8px;">
                            ➕ Post New Job
                        </a>
                    </div>

                    <c:choose>
                        <c:when test="${not empty myJobs}">
                            <c:forEach var="job" items="${myJobs}">
                                <div class="card job-card p-3 mb-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">
                                                ${job.title}
                                            </div>
                                            <div class="text-muted mt-1"
                                                 style="font-size:13px;">
                                                ${job.location} •
                                                <span class="badge bg-light text-dark"
                                                      style="font-size:11px;">
                                                    ${job.jobType}
                                                </span>
                                            </div>
                                            <div class="mt-1"
                                                 style="font-size:12px;">
                                                <c:choose>
                                                    <c:when test="${job.status == 'ACTIVE'}">
                                                        <span class="job-status-dot"
                                                              style="background:#198754;">
                                                        </span>
                                                        <span class="text-success">Active</span>
                                                    </c:when>
                                                    <c:when test="${job.status == 'DRAFT'}">
                                                        <span class="job-status-dot"
                                                              style="background:#6c757d;">
                                                        </span>
                                                        <span class="text-muted">Draft</span>
                                                    </c:when>
                                                    <c:when test="${job.status == 'CLOSED'}">
                                                        <span class="job-status-dot"
                                                              style="background:#dc3545;">
                                                        </span>
                                                        <span class="text-danger">Closed</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">
                                                            ${job.status}
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/recruiter/pipeline?jobId=${job.id}"
                                               class="btn btn-outline-success btn-sm"
                                               style="border-radius:8px;">
                                                👥 Applicants
                                            </a>
                                            <a href="${pageContext.request.contextPath}/recruiter/edit-job?id=${job.id}"
                                               class="btn btn-outline-secondary btn-sm"
                                               style="border-radius:8px;">
                                                ✏️
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="card border-0 rounded-3 p-5 text-center"
                                 style="background:#f8f9fa;">
                                <div style="font-size:48px;">📭</div>
                                <h5 class="mt-3 text-muted">
                                    No jobs posted yet
                                </h5>
                                <p class="text-muted"
                                   style="font-size:14px;">
                                    Post your first job to start
                                    receiving applications.
                                </p>
                                <a href="${pageContext.request.contextPath}/recruiter/post-job"
                                   class="btn btn-success mt-2 px-4">
                                    Post a Job
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>

                <!-- Recent Applicants -->
                <div>
                    <div class="d-flex justify-content-between
                                align-items-center mb-3">
                        <div class="section-title mb-0">
                            Recent Applicants
                        </div>
                        <a href="${pageContext.request.contextPath}/recruiter/applications"
                           class="text-primary text-decoration-none"
                           style="font-size:14px;">
                            View all →
                        </a>
                    </div>

                    <c:choose>
                        <c:when test="${not empty recentApplicants}">
                            <c:forEach var="app"
                                       items="${recentApplicants}">
                                <div class="card applicant-card p-3 mb-3">
                                    <div class="d-flex align-items-center gap-3">
                                        <div class="avatar-sm">
                                            ${app.seekerName.substring(0,1).toUpperCase()}
                                        </div>
                                        <div class="flex-grow-1">
                                            <div class="fw-semibold">
                                                ${app.seekerName}
                                            </div>
                                            <div class="text-muted"
                                                 style="font-size:13px;">
                                                Applied for:
                                                <strong>${app.jobTitle}</strong>
                                            </div>
                                        </div>
                                        <div class="d-flex flex-column
                                                    align-items-end gap-1">
                                            <c:choose>
                                                <c:when test="${app.status == 'APPLIED'}">
                                                    <span class="badge bg-primary status-badge">Applied</span>
                                                </c:when>
                                                <c:when test="${app.status == 'SHORTLISTED'}">
                                                    <span class="badge bg-warning status-badge">Shortlisted</span>
                                                </c:when>
                                                <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}">
                                                    <span class="badge bg-info status-badge">Interview</span>
                                                </c:when>
                                                <c:when test="${app.status == 'OFFERED'}">
                                                    <span class="badge bg-success status-badge">Offered</span>
                                                </c:when>
                                                <c:when test="${app.status == 'REJECTED'}">
                                                    <span class="badge bg-danger status-badge">Rejected</span>
                                                </c:when>
                                            </c:choose>
                                            <a href="${pageContext.request.contextPath}/recruiter/pipeline?jobId=${app.jobId}"
                                               class="btn btn-outline-primary btn-sm"
                                               style="border-radius:8px; font-size:11px;">
                                                Review
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
                                    No applicants yet.
                                </p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>

            </div>

            <!-- Right Column -->
            <div class="col-lg-4">

                <!-- Company Info -->
                <div class="card border-0 rounded-3 p-4 mb-4"
                     style="box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                    <div class="section-title">🏢 Company</div>
                    <div class="fw-semibold">${company.name}</div>
                    <div class="text-muted mt-1"
                         style="font-size:13px;">
                        ${company.industry}
                    </div>
                    <div class="text-muted"
                         style="font-size:13px;">
                        ${company.sizeRange} employees
                    </div>
                    <c:if test="${not empty company.website}">
                        <a href="${company.website}"
                           target="_blank"
                           class="text-primary text-decoration-none"
                           style="font-size:13px;">
                            🌐 ${company.website}
                        </a>
                    </c:if>
                    <div class="mt-2">
                        <span class="badge bg-success">
                            ✅ Verified
                        </span>
                    </div>
                </div>

                <!-- Pipeline Summary -->
                <div class="card border-0 rounded-3 p-4 mb-4"
                     style="box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                    <div class="section-title">
                        📊 Pipeline Summary
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span style="font-size:13px;">Applied</span>
                        <span class="badge bg-primary">
                            ${not empty appliedCount
                              ? appliedCount : 0}
                        </span>
                    </div>
                    <div class="progress mb-3">
                        <div class="progress-bar bg-primary"
                             style="width:100%"></div>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span style="font-size:13px;">Shortlisted</span>
                        <span class="badge bg-warning text-dark">
                            ${not empty shortlistedCount
                              ? shortlistedCount : 0}
                        </span>
                    </div>
                    <div class="progress mb-3">
                        <div class="progress-bar bg-warning"
                             style="width:60%"></div>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span style="font-size:13px;">Interview</span>
                        <span class="badge bg-info">
                            ${not empty interviewCount
                              ? interviewCount : 0}
                        </span>
                    </div>
                    <div class="progress mb-3">
                        <div class="progress-bar bg-info"
                             style="width:40%"></div>
                    </div>

                    <div class="d-flex justify-content-between mb-2">
                        <span style="font-size:13px;">Offered</span>
                        <span class="badge bg-success">
                            ${not empty offeredCount
                              ? offeredCount : 0}
                        </span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar bg-success"
                             style="width:20%"></div>
                    </div>

                </div>

                <!-- Quick Actions -->
                <div class="card border-0 rounded-3 p-4"
                     style="box-shadow:0 2px 12px rgba(0,0,0,0.06);">
                    <div class="section-title">Quick Actions</div>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/recruiter/post-job"
                           class="btn btn-success quick-action-btn">
                            ➕ Post New Job
                        </a>
                        <a href="${pageContext.request.contextPath}/recruiter/jobs"
                           class="btn btn-outline-success quick-action-btn">
                            📋 Manage Jobs
                        </a>
                        <a href="${pageContext.request.contextPath}/recruiter/applications"
                           class="btn btn-outline-secondary quick-action-btn">
                            👥 All Applicants
                        </a>
                        <a href="${pageContext.request.contextPath}/recruiter/company"
                           class="btn btn-outline-secondary quick-action-btn">
                            🏢 Company Profile
                        </a>
                    </div>
                </div>

            </div>

        </div>

    </c:if>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
</body>
</html>