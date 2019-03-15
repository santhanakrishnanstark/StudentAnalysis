package com.analysis.dao;

public class PassPercentage {
	
	private String subjectcode;
	private String subjectname;
	private int appeared;
	private int passed;
	private int ra;
	private String passpercent;
	
	public String getSubjectcode() {
		return subjectcode;
	}
	public void setSubjectcode(String subjectcode) {
		this.subjectcode = subjectcode;
	}
	public String getSubjectname() {
		return subjectname;
	}
	public void setSubjectname(String subjectname) {
		this.subjectname = subjectname;
	}
	public int getAppeared() {
		return appeared;
	}
	public void setAppeared(int appeared) {
		this.appeared = appeared;
	}
	public int getPassed() {
		return passed;
	}
	public void setPassed(int passed) {
		this.passed = passed;
	}
	public int getRa() {
		return ra;
	}
	public void setRa(int ra) {
		this.ra = ra;
	}
	public String getPasspercent() {
		return passpercent;
	}
	public void setPasspercent(String passpercent) {
		this.passpercent = passpercent;
	}
	@Override
	public String toString() {
		return "PassPercentage [subjectcode=" + subjectcode + ", subjectname=" + subjectname + ", appeared=" + appeared
				+ ", passed=" + passed + ", ra=" + ra + ", passpercent=" + passpercent + "]";
	}
	
	
	
}
