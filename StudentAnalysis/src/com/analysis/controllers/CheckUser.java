package com.analysis.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.analysis.dao.DbConnect;
import com.analysis.dao.User;
import com.mysql.jdbc.Statement;

@WebServlet("/CheckUser")
public class CheckUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
 
    public CheckUser() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		try {
			User user = new User();
			user.setUsername(request.getParameter("username"));
			user.setPassword(request.getParameter("password"));
			user.setDepartment(request.getParameter("department"));
			if(user.isExist()) {
				session.setAttribute("user", user.getUsername());
				session.setAttribute("dept", user.getDepartment());
				int uid = getUserId(session.getAttribute("user").toString());
				session.setAttribute("userid", uid);
				out.println("success"); 
			}else {
				out.println("Invalid Credintial !"+user.getError());
			}
			 
		}catch(Exception ex) {
			out.println(ex);
		}
	}

	private int getUserId(String string) {
		int id=0;
		try {
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("select id from users where username='"+string+"' ");
			 if(rs.next()) {
				 id = rs.getInt(1);
			 }
		}catch(Exception ex) {
			System.out.println(ex);
		}
		return id;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
