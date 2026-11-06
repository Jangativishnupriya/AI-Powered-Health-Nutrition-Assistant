package com.controller;

import java.io.IOException;

import com.DAO.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Get current session
        HttpSession session = request.getSession(false);

        if (session != null) {

            // Get logged-in user's email
            String email = (String) session.getAttribute("userEmail");

            // Mark user as inactive in database
            if (email != null && !email.isEmpty()) {

                UserDAO userDAO = new UserDAO();
                userDAO.markInactive(email);
            }

            // Invalidate user session
            session.invalidate();
        }

        // Redirect to Home page
        response.sendRedirect("Home.jsp");
    }
}
