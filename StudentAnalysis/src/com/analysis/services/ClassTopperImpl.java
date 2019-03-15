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

@WebServlet("/ClassTopperImpl")
public class ClassTopperImpl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
	private ArrayList<ClassTopper> list;
	
    public ClassTopperImpl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String semester = (String)session.getAttribute("current_selection");
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("SELECT student_name, register_no , SUM(total) / COUNT(DISTINCT(subject_code)) AS percentage FROM marklist WHERE semester = '"+semester+"' GROUP BY student_name ORDER BY percentage DESC LIMIT 3");
			list = new ArrayList<ClassTopper>();
			while(rs.next()) {
				ClassTopper topper = new ClassTopper();
				topper.setName(rs.getString(1));
				topper.setRegno(rs.getString(2));
				topper.setPercentage(rs.getDouble(3));
				list.add(topper);
			}
			
			session.setAttribute("classtopperlist", list);
			System.out.println("Class Topper percentage Stored");
			
		}catch(Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
