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
import com.analysis.dao.StudentList;


@WebServlet("/StudentListImpl")
public class StudentListImpl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
	private ArrayList<StudentList> list;
	
    public StudentListImpl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String semester = (String)session.getAttribute("current_selection");
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("SELECT  DISTINCT (student_name), register_no FROM marklist WHERE semester = '"+semester+"' ");
			list = new ArrayList<StudentList>();
			while(rs.next()) {
				StudentList student = new StudentList();
				student.setStudentName(rs.getString(1));
				student.setRegisterNumber(rs.getString(2));
				list.add(student);
			} 
			
			session.setAttribute("studentlist", list); 
			System.out.println("Student list Stored");
			 
		}catch(Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
