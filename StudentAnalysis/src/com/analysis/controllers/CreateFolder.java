package com.analysis.controllers;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateFolder")
public class CreateFolder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String foldername;
	
    public CreateFolder() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String studentyear = request.getParameter("stuyear");
		String semester = request.getParameter("sem");
		String month = request.getParameter("month");
		String year = request.getParameter("year");
		String dept = (String) session.getAttribute("dept");
		foldername = studentyear+"_"+dept+"_"+semester+"_"+month+"_"+year;
		session.setAttribute("newfolder", foldername);
		out.println(foldername);
	/*	try {
			 
			String paths= session.getServletContext().getRealPath("/");
			File file = new File(paths+"\\ExcelSheets\\"+foldername); 
			file.mkdir();
			session.setAttribute("foldername", foldername);
				out.println(foldername);
		}catch(Exception ex) {
			System.out.println(ex);
		} */
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
