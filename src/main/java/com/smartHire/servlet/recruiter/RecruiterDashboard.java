package com.smartHire.servlet.recruiter;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartHire.model.Company;
import com.smartHire.model.User;
import com.smartHire.service.companyService;
import com.smartHire.service.impl.CompanyServiceImpl;

/**
 * Servlet implementation class RecuiterDashboard
 */
@WebServlet(urlPatterns = { "/recruiter/dashboard" })
public class RecruiterDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 companyService service=new CompanyServiceImpl();
    public RecruiterDashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session =request.getSession();
         User user=(User) session.getAttribute("currentUser");
         System.out.println(user.getId());
         Company savedCompany=service.alreadySavedCompanybyUserId(user.getId());
         request.setAttribute("company", savedCompany);
		request.getRequestDispatcher(
	            "/WEB-INF/Views/recuiter/dashboard.jsp"
	        ).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
	}

}
