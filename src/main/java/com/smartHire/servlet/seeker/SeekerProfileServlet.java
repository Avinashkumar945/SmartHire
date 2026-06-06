package com.smartHire.servlet.seeker;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartHire.exception.AppException;
import com.smartHire.model.SeekerProfile;
import com.smartHire.model.User;
import com.smartHire.service.SeekerService;
import com.smartHire.service.impl.SeekerServiceimpl;

/**
 * Servlet implementation class SeekerProfile
 */
@WebServlet("/seeker/profile")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize       = 1024 * 1024 * 5,
	    maxRequestSize    = 1024 * 1024 * 10
	)
public class SeekerProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    SeekerService seekerService=new SeekerServiceimpl();
    public SeekerProfileServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("profile Servlet");
		 request.getRequestDispatcher(
		            "/WEB-INF/Views/seeker/profile.jsp"
		        ).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		HttpSession session = request.getSession(false);
	    User currentUser = (User) session.getAttribute("currentUser");
		SeekerProfile seeker =new SeekerProfile();
		String phone = cleanInput((request.getParameter("phone")));
		System.out.println(request.getParameter("phone"));
		String location =  cleanInput( request.getParameter("location"));
		Integer experienceYears=0;
		String experince=  request.getParameter("experienceYears"); 
		 if (experince!= null && !experince.isBlank()) {
	            experienceYears = Integer.parseInt(experince.trim());
	        }
		
		String linkdinUrl=cleanInput(request.getParameter("linkedinUrl"));
		String githubUrl=cleanInput(request.getParameter("githubUrl"));
		String bio=cleanInput(request.getParameter("bio"));
		
		seeker.setExperienceYears(experienceYears);
		seeker.setGithubUrl(githubUrl);
		seeker.setLinkedinUrl(linkdinUrl);
		seeker.setLocation(location);
		seeker.setPhone(phone);
		seeker.setBio(bio);
		seeker.setUserId(currentUser.getId().longValue());
		
		seeker.setFullName(currentUser.getName());
		SeekerProfile savedseeker=null;
		try {
			seekerService.saveSeekerProfile(seeker);
		} catch (AppException e) {
		    System.err.println("id already exist");
		}
		finally {
			savedseeker=seekerService.updateSeekerProfile(seeker);
			session.setAttribute("seeker", savedseeker);
		}
		
		request.getRequestDispatcher("/WEB-INF/Views/seeker/profile.jsp").forward(request,response);
	}

	private String cleanInput(String value) {
		if (value == null || value.isBlank()) {
	        return null;
	    }
	    return value.trim();
	}
	
	
   
}
