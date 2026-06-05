package com.smartHire.servlet.auth;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/seeker/dashboard")
public class SeekerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
       System.out.println("asghdb");
        request.getRequestDispatcher(
            "/WEB-INF/Views/seeker/dashboard.jsp"
        ).forward(request, response);
    }
   
}