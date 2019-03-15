package com.analysis.dao;

public class SubjectWise {

	private String subjectcode;
	private String subjectname;
	private String name;
	private String regno;
	private int mark;
	
	
	public String getSubjectname() {
		return subjectname;
	}
	public void setSubjectname(String subjectname) {
		this.subjectname = subjectname;
	}
	public String getSubjectcode() {
		return subjectcode;
	}
	public void setSubjectcode(String subjectcode) {
		this.subjectcode = subjectcode;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRegno() {
		return regno;
	}
	public void setRegno(String regno) {
		this.regno = regno;
	}
	public int getMark() {
		return mark;
	}
	public void setMark(int mark) {
		this.mark = mark;
	}
	@Override
	public String toString() {
		return "SubjectWise [subjectcode=" + subjectcode + ", name=" + name + ", regno=" + regno + ", mark=" + mark
				+ "]";
	}
	
	
	
	
}
