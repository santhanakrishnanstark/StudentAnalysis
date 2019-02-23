package com.analysis.controllers;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.analysis.dao.User;

@WebServlet("/CreateUser")
public class CreateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public CreateUser() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
		String pass = request.getParameter("password");
		String cpass = request.getParameter("cpassword");
		if(pass.equals(cpass)) {
			User user = new User();
			user.setUsername(request.getParameter("username"));
			user.setDepartment(request.getParameter("department"));
			user.setPassword(pass);
			if(user.saveUser()) {
			out.println("Register Successfully");
			}else {
				out.println(user.getError());
			}
		}else {
			out.println("Password Doesnot Match");
		}
		}catch(Exception ex) {
			out.println(ex);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
