<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartHire — Company Setup</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <style>
        body { background: #f0f2f5; }
        .setup-card {
            max-width: 700px;
            margin: 40px auto;
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }
        .step-header {
            background: linear-gradient(135deg, #198754, #20c997);
            color: white;
            border-radius: 16px 16px 0 0;
            padding: 32px;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 16px;
            border: 1.5px solid #dee2e6;
            font-size: 15px;
        }
        .form-control:focus, .form-select:focus {
            border-color: #198754;
            box-shadow: 0 0 0 3px rgba(25,135,84,0.1);
        }
        .btn-setup {
            border-radius: 10px;
            padding: 12px;
            font-size: 16px;
            font-weight: 600;
        }
        .required-star {
            color: #dc3545;
            margin-left: 2px;
        }
        .field-hint {
            font-size: 12px;
            color: #6c757d;
            margin-top: 4px;
        }
        .section-divider {
            border: none;
            border-top: 1.5px solid #f0f2f5;
            margin: 24px 0;
        }
        .mandatory-note {
            background: #fff3cd;
            border-radius: 10px;
            padding: 12px 16px;
            font-size: 13px;
            color: #664d03;
            margin-bottom: 24px;
        }
    </style>
</head>
<body>

<%-- Include navbar --%>
<jsp:include page="/WEB-INF/Views/common/header.jsp"/>

<div class="container py-4">
    <div class="setup-card card">

        <!-- Header -->
        <div class="step-header">
            <div class="d-flex align-items-center gap-3">
                <span style="font-size:40px;">🏢</span>
                <div>
                    <h3 class="mb-1 fw-bold">Company Setup</h3>
                    <p class="mb-0 opacity-75">
                        Fill in your company details to get verified
                        and start posting jobs.
                    </p>
                </div>
            </div>
        </div>

        <div class="p-4 p-md-5">

            <!-- Mandatory Note -->
            <div class="mandatory-note">
                ⚠️ Fields marked with
                <span class="required-star">*</span>
                are mandatory for admin verification.
                Please fill them accurately.
            </div>

            <!-- Error Message -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible
                            fade show" role="alert">
                    <strong>Error:</strong> ${errorMessage}
                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>
                </div>
            </c:if>

            <!-- Company Setup Form -->
            <form action="${pageContext.request.contextPath}/recruiter/company/setup"
                  method="post"
                  id="companySetupForm">

                <!-- Section 1 — Basic Info -->
                <h6 class="fw-bold text-success mb-3">
                    📋 Basic Information
                </h6>

                <!-- Company Name — MANDATORY -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Company Name
                        <span class="required-star">*</span>
                    </label>
                    <input type="text"
                           name="companyName"
                           class="form-control"
                           placeholder="e.g. Google India Pvt Ltd"
                           value="${not empty companyName
                                   ? companyName : ''}"
                           required/>
                    <div class="field-hint">
                        Enter the official registered name
                        of your company.
                    </div>
                </div>

                <!-- Industry — MANDATORY -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Industry
                        <span class="required-star">*</span>
                    </label>
                    <select name="industry"
                            class="form-select"
                            required>
                        <option value="">
                            -- Select Industry --
                        </option>
                        <option value="Information Technology"
                            ${companyIndustry == 'Information Technology'
                              ? 'selected' : ''}>
                            Information Technology
                        </option>
                        <option value="Finance & Banking"
                            ${companyIndustry == 'Finance & Banking'
                              ? 'selected' : ''}>
                            Finance & Banking
                        </option>
                        <option value="Healthcare"
                            ${companyIndustry == 'Healthcare'
                              ? 'selected' : ''}>
                            Healthcare
                        </option>
                        <option value="E-Commerce"
                            ${companyIndustry == 'E-Commerce'
                              ? 'selected' : ''}>
                            E-Commerce
                        </option>
                        <option value="Education"
                            ${companyIndustry == 'Education'
                              ? 'selected' : ''}>
                            Education
                        </option>
                        <option value="Manufacturing"
                            ${companyIndustry == 'Manufacturing'
                              ? 'selected' : ''}>
                            Manufacturing
                        </option>
                        <option value="Consulting"
                            ${companyIndustry == 'Consulting'
                              ? 'selected' : ''}>
                            Consulting
                        </option>
                        <option value="Media & Entertainment"
                            ${companyIndustry == 'Media & Entertainment'
                              ? 'selected' : ''}>
                            Media & Entertainment
                        </option>
                        <option value="Retail"
                            ${companyIndustry == 'Retail'
                              ? 'selected' : ''}>
                            Retail
                        </option>
                        <option value="Other"
                            ${companyIndustry == 'Other'
                              ? 'selected' : ''}>
                            Other
                        </option>
                    </select>
                </div>

                <!-- Company Size — MANDATORY -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Company Size
                        <span class="required-star">*</span>
                    </label>
                    <select name="sizeRange"
                            class="form-select"
                            required>
                        <option value="">
                            -- Select Company Size --
                        </option>
                        <option value="1-10"
                            ${companySizeRange == '1-10'
                              ? 'selected' : ''}>
                            1-10 employees (Startup)
                        </option>
                        <option value="11-50"
                            ${companySizeRange == '11-50'
                              ? 'selected' : ''}>
                            11-50 employees (Small)
                        </option>
                        <option value="51-200"
                            ${companySizeRange == '51-200'
                              ? 'selected' : ''}>
                            51-200 employees (Medium)
                        </option>
                        <option value="201-500"
                            ${companySizeRange == '201-500'
                              ? 'selected' : ''}>
                            201-500 employees (Large)
                        </option>
                        <option value="501-1000"
                            ${companySizeRange == '501-1000'
                              ? 'selected' : ''}>
                            501-1000 employees
                        </option>
                        <option value="1000+"
                            ${companySizeRange == '1000+'
                              ? 'selected' : ''}>
                            1000+ employees (Enterprise)
                        </option>
                    </select>
                </div>

                <hr class="section-divider"/>

                <!-- Section 2 — Contact & Online Presence -->
                <h6 class="fw-bold text-success mb-3">
                    🌐 Contact & Online Presence
                </h6>

                <!-- Website — MANDATORY -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Company Website
                        <span class="required-star">*</span>
                    </label>
                    <input type="url"
                           name="website"
                           class="form-control"
                           placeholder="https://www.yourcompany.com"
                           value="${not empty companyWebsite
                                   ? companyWebsite : ''}"
                           required/>
                    <div class="field-hint">
                        Must start with https://
                        Used by admin to verify your company.
                    </div>
                </div>

                <!-- LinkedIn URL — Optional -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        LinkedIn Company Page
                        <span class="text-muted fw-normal"
                              style="font-size:12px;">
                            (Optional)
                        </span>
                    </label>
                    <input type="url"
                           name="linkedinUrl"
                           class="form-control"
                           placeholder="https://linkedin.com/company/yourcompany"
                           value="${not empty companyLinkedin
                                   ? companyLinkedin : ''}"/>
                    <div class="field-hint">
                        Helps admin verify your company faster.
                    </div>
                </div>

                <hr class="section-divider"/>

                <!-- Section 3 — About Company -->
                <h6 class="fw-bold text-success mb-3">
                    📝 About Company
                </h6>

                <!-- Description — MANDATORY -->
                <div class="mb-3">
                    <label class="form-label fw-semibold">
                        Company Description
                        <span class="required-star">*</span>
                    </label>
                    <textarea name="description"
                              class="form-control"
                              rows="4"
                              placeholder="Describe what your company does, your culture, values and what makes you a great place to work..."
                              required
                              minlength="50"
                              maxlength="1000">${not empty companyDescription
                                                ? companyDescription
                                                : ''}</textarea>
                    <div class="d-flex justify-content-between">
                        <div class="field-hint">
                            Minimum 50 characters.
                            Shown to job seekers on job listings.
                        </div>
                        <div class="field-hint"
                             id="charCount">
                            0/1000
                        </div>
                    </div>
                </div>

                <hr class="section-divider"/>

                <!-- Submit -->
                <div class="d-flex gap-3">
                    <button type="submit"
                            class="btn btn-success btn-setup flex-grow-1">
                        🏢 Submit for Verification
                    </button>
                    <a href="${pageContext.request.contextPath}/recruiter/dashboard"
                       class="btn btn-outline-secondary btn-setup px-4">
                        Cancel
                    </a>
                </div>

                <!-- What happens next -->
                <div class="mt-4 p-3 rounded-3"
                     style="background:#f8f9fa; font-size:13px;">
                    <div class="fw-semibold mb-2">
                        📋 What happens after submission?
                    </div>
                    <div class="text-muted">
                        1. Our admin team reviews your company details<br>
                        2. Verification usually takes 24-48 hours<br>
                        3. You will be notified via email once verified<br>
                        4. After verification you can start posting jobs
                    </div>
                </div>

            </form>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>
<script>
    // Character counter for description
    const textarea = document.querySelector(
        'textarea[name="description"]');
    const charCount = document.getElementById('charCount');

    function updateCount() {
        const len = textarea.value.length;
        charCount.textContent = len + '/1000';
        if (len < 50) {
            charCount.style.color = '#dc3545';
        } else {
            charCount.style.color = '#198754';
        }
    }

    textarea.addEventListener('input', updateCount);
    updateCount();

    // Form validation
    document.getElementById('companySetupForm')
        .addEventListener('submit', function(e) {
            const desc = textarea.value.trim();
            if (desc.length < 50) {
                e.preventDefault();
                textarea.focus();
                charCount.style.color = '#dc3545';
                alert('Company description must be ' +
                      'at least 50 characters.');
            }
        });
</script>
</body>
</html>