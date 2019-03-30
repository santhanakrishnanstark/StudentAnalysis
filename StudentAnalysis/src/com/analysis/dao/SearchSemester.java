package com.analysis.dao;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchSemester")
public class SearchSemester extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public SearchSemester() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			PrintWriter out = response.getWriter();
			String semester = request.getParameter("semester").replace(" ", "_");
			Statement st = DbConnect.getConnection();
			ResultSet rs = st.executeQuery("select u.semester,u1.username from uploaded_files AS u, users u1 WHERE u.uploaded_by=u1.id and u.semester like '%"+semester+"%' ");
			
			while(rs.next()) {
				out.println("<div class='col-md-4'><div class='card'> <img src='"+request.getContextPath()+"/images/mark.png' style='height:80px' class='card-img-top' alt='...'> <div class='card-body'>" + 
						"<h6 class='card-title'>"+rs.getString(1)+"</h6> <p class='card-text'></p> <a onClick='openSemester(this)' value="+rs.getString(1)+" class='btn btn-secondary text-white'>View Report</a> "+
						"<footer class='blockquote-footer mt-2'> by <cite title='Source Title'> "+rs.getString(2) +" </cite></footer></div></div></div> ");
			}
			
		}catch(Exception e) {
			System.out.println(e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
