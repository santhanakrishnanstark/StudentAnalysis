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
import com.analysis.dao.PassPercentage;

@WebServlet("/PassPercentageImpl")
public class PassPercentageImpl extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Statement st;
	private ArrayList<PassPercentage> list;
 
    public PassPercentageImpl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();
			String semester = (String)session.getAttribute("current_selection");
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("select subject_code, subject_name, COUNT(register_no) AS appeared, SUM(CASE WHEN result = 'P' THEN 1 ELSE 0 END) as passed, SUM(CASE WHEN result = 'RA' THEN 1 ELSE 0 END) as RA, CONCAT(ceil(SUM(CASE WHEN result = 'P' THEN 1 ELSE 0 END)/COUNT(register_no) * 100), ' %') as PassPercentage from marklist WHERE semester='"+semester+"' GROUP BY subject_code ");
			list = new ArrayList<PassPercentage>();
			while(rs.next()) { 
				PassPercentage subject = new PassPercentage();
				subject.setSubjectcode(rs.getString(1));
				subject.setSubjectname(rs.getString(2));
				subject.setAppeared(Integer.parseInt(rs.getString(3))); 
				subject.setPassed(Integer.parseInt(rs.getString(4)));
				subject.setRa(Integer.parseInt(rs.getString(5)));
				subject.setPasspercent(rs.getString(6));
				list.add(subject);
			}
			
			session.setAttribute("passpercentlist", list);
			System.out.println("Subject wise Pass percentage Stored");
			
		}catch(Exception ex) {
			System.out.println(ex);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
