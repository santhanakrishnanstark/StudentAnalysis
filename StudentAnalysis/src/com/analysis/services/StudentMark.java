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

import com.analysis.dao.ClassTopper;
import com.analysis.dao.DbConnect;

@WebServlet("/StudentMark")
public class StudentMark extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
	
    public StudentMark() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String semester = (String)session.getAttribute("current_selection");
			String registerno = (String)request.getParameter("regno");
			String percentage = null;
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("SELECT student_name,register_no,subject_name,cia,ese,total,(SELECT round(SUM(total)/count(*),2) FROM marklist WHERE semester  = '"+semester+"' AND register_no='"+registerno+"') AS Percentage FROM marklist WHERE semester = '"+semester+"' AND register_no='"+registerno+"'");
			if(rs.next()) {
			out.print("<h5>Name : "+rs.getString(1)+"</h5> "
					+ "<h5>Register No : "+rs.getString(2)+"</h5> <br><table class='table table-sm'> <thead> <tr> <th>SUBJECT NAME</th>"
					+ "<th>CIA</th>"
					+ "<th>ESE</th> "
					+ "<th>TOTAL</th></tr> </thead> <tbody>");
				percentage = rs.getString(7);
			while(rs.next()) {
				out.print(" <tr> <td>"+rs.getString(3)+"</td> <td>"+rs.getString(4)+"</td><td>"+rs.getString(5)+"</td><td>"+rs.getString(6)+"</td></tr> ");
			}
			
			out.print("</tbody> </table> <br/> <h5>Percentage : "+percentage+"</h5> <br>");
			
		   }
			System.out.println("Student Mark Chat Loaded ");
			
		}catch(Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
