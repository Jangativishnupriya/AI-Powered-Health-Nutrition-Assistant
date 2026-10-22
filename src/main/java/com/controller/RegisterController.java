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

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String Fullname = request.getParameter("Fullname");
		String email = request.getParameter("email");
		String passwordKey = request.getParameter("passwordKey");
		String confirmPasssword = request.getParameter("confirmPassword");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");

		UserModel um = new UserModel();
		um.setName(Fullname);
		um.setEmail(email);
		um.setPassword(passwordKey);
		um.setConfirmPassword(confirmPasssword);
		um.setAge(age);

		UserDAO ud = new UserDAO();
		String status = ud.insertUser(um);

		if (status.equals("success")) {

			HttpSession session = request.getSession();
			session.setAttribute("Fullname", Fullname);

			RequestDispatcher rd = request.getRequestDispatcher("Login.jsp");
			rd.forward(request, response);
		} else {

			RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
			rd.forward(request, response);
		}

	}

}
