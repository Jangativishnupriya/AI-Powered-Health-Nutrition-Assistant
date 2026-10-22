package com.controller;

import java.io.IOException;

import com.DAO.UserDAO;
import com.model.UserModel;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String Fullname =  request.getParameter("Fullname");
		String email = request.getParameter("email");
		String passwordKey = request.getParameter("passwordKey");
		
		UserModel um = new UserModel();
		um.setName(Fullname);
		um.setEmail(email);
		um.setPassword(passwordKey);
		
		UserDAO ud = new UserDAO();
		String status = ud.validateUser(email,passwordKey);
		
		if(status.equals("success")) {
			
		    String fullname = ud.getUserNameByEmail(email);
			
			HttpSession session = request.getSession();
			session.setAttribute("Fullname",fullname);
			
			RequestDispatcher rd = request.getRequestDispatcher("Dashboard.jsp");
			rd.forward(request, response);
		}else {
			
			RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
			rd.forward(request, response);
		}
	}

}
