package com.filter;

import java.io.IOException;

import com.DAO.UserDAO;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@WebFilter("/*")
public class ActivityTrackingFilter implements Filter {

    private UserDAO userDAO;

    @Override
    public void init(jakarta.servlet.FilterConfig config)
            throws ServletException {

        userDAO = new UserDAO();
    }

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpSession session = httpRequest.getSession(false);

        if (session != null) {

            String email =
                    (String) session.getAttribute("userEmail");

            if (email != null && !email.isEmpty()) {

                userDAO.updateLastActivity(email);
            }
        }

        chain.doFilter(request, response);
    }
}

