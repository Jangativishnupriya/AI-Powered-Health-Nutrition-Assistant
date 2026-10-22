package com.controller;

import java.io.IOException;
import java.util.List;

import com.DAO.UserDAO;
import com.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewUsersController")
public class ViewUsersController extends HttpServlet {


private static final long serialVersionUID = 1L;

private UserDAO userDAO;

@Override
public void init() throws ServletException {

    userDAO = new UserDAO();
}

@Override
protected void doGet(HttpServletRequest request,
                     HttpServletResponse response)
        throws ServletException, IOException {

    // Check whether admin is logged in
    HttpSession session = request.getSession(false);

    if (session == null ||
        session.getAttribute("adminName") == null) {

        response.sendRedirect("AdminLogin.jsp");
        return;
    }

    try {

        // Get all normal users
        List<UserModel> users = userDAO.getAllUsers();

        // Send users to JSP
        request.setAttribute("users", users);

        // Open ViewUsers.jsp
        request.getRequestDispatcher("ViewUsers.jsp")
               .forward(request, response);

    } catch (Exception e) {

        e.printStackTrace();

        request.setAttribute(
            "errorMessage",
            "Unable to load user accounts."
        );

        request.getRequestDispatcher("ViewUsers.jsp")
               .forward(request, response);
    }
}

@Override
protected void doPost(HttpServletRequest request,
                      HttpServletResponse response)
        throws ServletException, IOException {

    doGet(request, response);
}


}
