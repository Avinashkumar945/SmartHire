package com.smartHire.servlet.recruiter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartHire.exception.AppException;
import com.smartHire.model.Company;
import com.smartHire.model.User;
import com.smartHire.service.companyService;
import com.smartHire.service.impl.CompanyServiceImpl;

/**
 * Servlet implementation class CompanySetupServlet
 */
@WebServlet("/recruiter/company/setup")
public class CompanySetupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
      companyService service=new CompanyServiceImpl();
    public CompanySetupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 System.out.println("hello what happen");
		User currentUser = (User) request.getSession()
		            .getAttribute("currentUser");
		request.getRequestDispatcher(
	            "/WEB-INF/Views/recuiter/company-setup.jsp"
	        ).forward(request, response);
		}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String companyName  = request.getParameter("companyName");
        String industry     = request.getParameter("industry");
        String sizeRange    = request.getParameter("sizeRange");
        String website      = request.getParameter("website");
        String description  = request.getParameter("description");
        
        HttpSession session =request.getSession();
        if (companyName == null || companyName.isBlank() ||
                industry    == null || industry.isBlank()    ||
                sizeRange   == null || sizeRange.isBlank()   ||
                website     == null || website.isBlank()     ||
                description == null || description.isBlank()) {

                request.setAttribute("errorMessage",
                    "All mandatory fields are required.");
                request.setAttribute("companyName", companyName);
                request.setAttribute("companyIndustry", industry);
                request.setAttribute("companySizeRange", sizeRange);
                request.setAttribute("companyWebsite", website);
                request.setAttribute("companyDescription", description);
                request.getRequestDispatcher(
                    "/WEB-INF/Views/recruiter/company-setup.jsp"
                ).forward(request, response);
                return;
            }
        if (description.trim().length() < 50) {
            request.setAttribute("errorMessage",
                "Company description must be " +
                "at least 50 characters.");
            request.setAttribute("companyName", companyName);
            request.setAttribute("companyIndustry", industry);
            request.setAttribute("companySizeRange", sizeRange);
            request.setAttribute("companyWebsite", website);
            request.setAttribute("companyDescription", description);
            request.getRequestDispatcher(
                "/WEB-INF/Views/recruiter/company-setup.jsp"
            ).forward(request, response);
            return;
        }
        
        Company comp=new Company();
        
        comp.setName(companyName);
        comp.setSizeRange(sizeRange);
        comp.setDescription(description);
        comp.setIndustry(industry);
        comp.setWebsite(website);
        
        try {
        	System.out.println("abc");
        	 service.saveCompany(comp);
        	 request.setAttribute("Company", comp);
        	 
		} catch (AppException e) {
			request.setAttribute("errorMessage",e.getMessage());
		}
       response.sendRedirect(request.getContextPath()+"/recruiter/dashboard");
        

	}

}
