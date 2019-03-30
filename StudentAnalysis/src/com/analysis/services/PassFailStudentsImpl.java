package com.analysis.services;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.analysis.dao.DbConnect;
import com.analysis.dao.PassFailStudents;

@WebServlet("/PassFailStudentsImpl")
public class PassFailStudentsImpl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
	private ArrayList<PassFailStudents> list;

    public PassFailStudentsImpl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String semester = (String)session.getAttribute("current_selection");
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("SELECT (SELECT COUNT(DISTINCT student_name) FROM marklist WHERE semester='"+semester+"')-(SELECT COUNT(DISTINCT student_name)) AS Passed, (SELECT COUNT(DISTINCT student_name) FROM marklist WHERE semester = '"+semester+"' AND result ='RA') AS Failed FROM marklist WHERE semester = '"+semester+"' AND result ='RA' ");
			list = new ArrayList<PassFailStudents>();
			while(rs.next()) {
				PassFailStudents psf = new PassFailStudents();
				psf.setNoOfStudentPassed(rs.getInt(1));
				psf.setNoOfStudentFailed(rs.getInt(2));
				list.add(psf);
			}
			
			session.setAttribute("passfailstudents", list); 
			System.out.println("Pass Fail Student Stored");
			
		}catch(Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
