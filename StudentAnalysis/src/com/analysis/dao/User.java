package com.analysis.dao;

import java.sql.Date;
import java.sql.ResultSet;

import com.mysql.jdbc.Statement;

public class User {
	
	private String username;
	private String department;
	private String password;
	private String createDate;
	private String error;
	private Statement st;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getCreateDate() {
		long millis=System.currentTimeMillis();  
        Date date=new Date(millis);  
        this.createDate = date.toString();
		return createDate;
	}
	public String getError() {
		return error;
	}
	public boolean saveUser() { 
		try {
		    st = (Statement) DbConnect.getConnection(); 
			int res = st.executeUpdate("insert into users(username,department,password,created_date) "
					+ "values ('"+getUsername()+"','"+getDepartment()+"','"+getPassword()+"','"+getCreateDate()+"') ");
			if(res>=0) {
				return true;
			}
		}catch(Exception ex) {
			System.out.println(ex);
			error = ex.getMessage();
		}
		return false;
	}
	public boolean isExist() {
		try {
			st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("select * from users where username='"+getUsername()+"'"
					+ "and password='"+getPassword()+"' and department='"+getDepartment()+"' ");
			if(rs.next()) {
				return true;
			}
		}catch(Exception ex) {
			error = ex.getMessage();
		}
		return false;
	}
	
	
}
