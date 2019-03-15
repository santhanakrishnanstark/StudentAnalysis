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
import com.analysis.dao.SubjectWise;

@WebServlet("/SubjectwiseImpl")
public class SubjectwiseImpl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
	private ArrayList<SubjectWise> list;
 
    public SubjectwiseImpl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String semester = (String)session.getAttribute("current_selection");
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("SELECT m.subject_code,m.subject_name, m.register_no, m.student_name,mm.max_marks FROM marklist AS m\r\n" + 
					"INNER JOIN (SELECT subject_code, subject_name, register_no, student_name, MAX(total) AS max_marks FROM marklist WHERE semester='"+semester+"' GROUP BY subject_code) AS mm ON m.subject_code = mm.subject_code AND m.total = mm.max_marks WHERE semester='"+semester+"' AND m.subject_code NOT LIKE '%P' ");
			list = new ArrayList<SubjectWise>();
			while(rs.next()) { 
				SubjectWise subject = new SubjectWise();
				subject.setSubjectcode(rs.getString(1));
				subject.setSubjectname(rs.getString(2));
				subject.setRegno(rs.getString(3));
				subject.setName(rs.getString(4));
				subject.setMark(rs.getInt(5));
				list.add(subject);
			} 
			
			session.setAttribute("subjectwise", list);
			System.out.println("subject wise topper Object Stored");
			
		}catch(Exception ex) {
			System.out.println(ex);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
