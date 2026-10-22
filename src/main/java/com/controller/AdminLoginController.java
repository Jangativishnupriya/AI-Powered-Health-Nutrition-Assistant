package com.controller;

import java.io.IOException;

import com.DAO.UserDAO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AdminLoginController")
public class AdminLoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String Fullname = request.getParameter("Fullname");
        String passwordKey = request.getParameter("passwordKey");

        System.out.println("Admin Name: " + Fullname);
        System.out.println("Password: " + passwordKey);

        UserDAO ud = new UserDAO();

        String status = ud.validateAdmin(Fullname, passwordKey);

        System.out.println("Status: " + status);

        if (status.equals("success")) {

            HttpSession session = request.getSession();

            session.setAttribute("adminName", Fullname);

            response.sendRedirect("Admin.jsp");

        } else {

            request.setAttribute(
                "error",
                "Invalid admin name or password."
            );

            RequestDispatcher rd =
                    request.getRequestDispatcher("AdminLogin.jsp");

            rd.forward(request, response);
        }
    }
}