package com.smartHire.servlet.auth;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.smartHire.exception.AppException;
import com.smartHire.service.UserService;
import com.smartHire.service.impl.UserServiceImpl;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 request.getRequestDispatcher("/WEB-INF/Views/auth/login.jsp")
         .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserService userService = new UserServiceImpl();
		    String email=request.getParameter("email");
		    String password =request.getParameter("password");
		    
		    PrintWriter out =response.getWriter();
		try {
			   userService.login(email,password);
			   
		} catch (AppException e) {
			  
			 request.setAttribute("errorMessage", e.getMessage());
			System.out.println("error");
			 request.getRequestDispatcher("/WEB-INF/Views/auth/login.jsp")
	           .forward(request, response);
		}
		   
		
	}

}
