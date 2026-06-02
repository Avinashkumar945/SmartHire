package com.smartHire.filter;

import java.io.IOException;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.smartHire.service.UserService;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */
@WebFilter(dispatcherTypes = {DispatcherType.REQUEST }
					, urlPatterns = { "/seeker/*", "/recruiter/*", "/admin/*" })
public class AuthenticationFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AuthenticationFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		 UserService userService;
		 
		 HttpServletRequest req= (HttpServletRequest)request;
		 HttpServletResponse res=(HttpServletResponse)response;
		 HttpSession session = req.getSession(false);
		 boolean isLoggedIn=(session!=null) && (session.getAttribute("currentUser")!=null);
		  
		 if(!isLoggedIn) {
			 res.sendRedirect(req.getContextPath()+"/login");
			 return;
		 }
		// pass the request along the filter chain
		  
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
