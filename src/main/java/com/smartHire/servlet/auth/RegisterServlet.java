package com.smartHire.servlet.auth;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smartHire.exception.AppException;
import com.smartHire.model.User.Role;
import com.smartHire.service.UserService;
import com.smartHire.service.impl.UserServiceImpl;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 request.getRequestDispatcher(
		            "WEB-INF/Views/auth/register.jsp"
		        ).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService userService = new UserServiceImpl();
		String email=request.getParameter("email");
	    String password =request.getParameter("password");
	    String confirmPassword=request.getParameter("confirmPassword");
	    String role=request.getParameter("role");
	    
	    if(email==null || email.isBlank() || password==null || password.isBlank()
	    		|| confirmPassword==null || confirmPassword.isBlank() || role==null || role.isBlank()) {
	    	request.setAttribute("errorMessage", "All fields are required");
	    	request.setAttribute("email", email);
	    	request.getRequestDispatcher("WEB-INF/Views/auth/register.jsp").forward(request,response);
	    	return;
	    }
	    if(!password.equals(confirmPassword)) {
	    	request.setAttribute("errorMessage", "password does not match with confirem password");
	    	request.setAttribute("email", email);
	    	request.getRequestDispatcher("WEB-INF/Views/auth/register.jsp").forward(request,response);
	    	return;
	    }
	    
	    if (password.length() < 8) {
            request.setAttribute("errorMessage",
                "Password must be at least 8 characters.");
            request.setAttribute("email", email);
            request.getRequestDispatcher(
                "/WEB-INF/Views/auth/register.jsp"
            ).forward(request, response);
            return;
        }
	    
	    
	 try {
		 userService.register(email, confirmPassword, Role.valueOf(role));
		 response.sendRedirect(request.getContextPath()+"/login?registered=true");
	} catch (AppException e) {
		// TODO: handle exception
		 request.setAttribute("errorMessage", e.getMessage());
         request.setAttribute("email", email); // keep email filled
         request.getRequestDispatcher(
             "/WEB-INF/Views/auth/register.jsp"
         ).forward(request, response);
		
	}
	   
	}
}
