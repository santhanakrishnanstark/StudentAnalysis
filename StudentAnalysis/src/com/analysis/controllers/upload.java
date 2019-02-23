package com.analysis.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.analysis.dao.DbConnect;
import com.mysql.jdbc.Statement;
import com.oreilly.servlet.MultipartRequest;

@WebServlet("/upload")
public class upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static Workbook workbook;
	public static Sheet sheet;
	public static Row row;
	public static Cell cell;
	public static FileInputStream fis;
	public static FileOutputStream fos;
	
	private int rows;
	private int cols;
	
	private String subject_name;
	private String subject_code;
	private String addedid;
	
	private String records[][];
	private String dataset[][];
	
	private Statement st;
	
	private int number;
	
    public upload() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String foldername = (String) session.getAttribute("newfolder");
		String user = (String) session.getAttribute("user");
		int userid = (int) session.getAttribute("userid");
		StringBuilder query= new StringBuilder();
		
		try {
			 
			String paths= session.getServletContext().getRealPath("/");
			System.out.println(paths);
			File f = new File(paths+"\\ExcelSheets\\"+foldername); 
			f.mkdir();
			
			MultipartRequest m = new MultipartRequest(request,paths+"\\ExcelSheets\\"+foldername+"\\",15 * 1024 * 1024);
		    String fullpath = paths+"\\ExcelSheets\\"+foldername;
		    File files = new File(fullpath);
		    dataset = new String[68][10];
		    
		    // insert uploaded details 
		     String fpath = fullpath.replace('\\', '/');
		     insertUploadedDetails(foldername,fpath,userid,request);
		     addedid = String.valueOf(session.getAttribute("added_id"));
		    
			// for each loop for iterate each files in folder
		    for(String file : files.list()) {
		    	
		    	fis = new FileInputStream(fullpath+"/"+file);
				workbook = WorkbookFactory.create(fis);
				sheet = workbook.getSheetAt(0);
				
				 rows = sheet.getLastRowNum();
				 cols = sheet.getRow(7).getLastCellNum() + 3;
		    	
		    	subject_name = getSubjectName(file);
		    	subject_code = getSubjectCode(file);
		    	
	    		records = new String[rows-6][cols];
	    		
	    		// extract data from excel and store to 2d array
				for(int i=0; i<(rows-6); i++) {
					for(int j=0; j<cols; j++) {
						if(j==0) { records[i][j]=foldername; }else
							if(j==1) {records[i][j]=subject_name; }else 
								if(j==2) {records[i][j]=subject_code; }else 
								if(j==9) {records[i][j]=addedid; }else { System.out.println(j);
						records[i][j] = sheet.getRow((i+7)).getCell(j-2).toString();  }
					}
				}
		    
				dataset = append(dataset,records);
				
		    }
		    
		    // list the dataset values
		    for(int i=(rows-6); i<dataset.length; i++) {
				for(int j=0; j<dataset[i].length; j++) {
					if(dataset[i][j]!=null) { 
					System.out.print(dataset[i][j]+"  ");
					}
				}
				System.out.println();  System.out.println(); 
			}
		    
		    System.out.println("----End list----");
		    
		    // insert the dataset array to db 
		    query.append("insert into marklist(semester,subject_name,subject_code,register_no,student_name,cia,ese,total,result,added_id) values ");
			
		    for(int i=(rows-6); i<dataset.length; i++) {
		    	query.append(" ( ");
		    	for(int j=0; j<dataset[i].length; j++) {
					if(dataset[i][j]!=null) { 
						// insert process
						query.append(checkInteger(dataset[i][j])?number+"," : "\'"+dataset[i][j]+"\'," );
					}
				}
				query.append(") , ");
				// to cut the last comma 
				int index_of_comma = query.indexOf(",", query.length()-6);
				query.deleteCharAt(index_of_comma).toString();
			}
		    // to cut the last comma 
			int index_of_lastcomma = query.indexOf(",", query.length()-3);
			query.deleteCharAt(index_of_lastcomma).toString();
		    	//System.out.println(query.toString());
		    
		    // All for this one line of code :) 
		    st = (Statement) DbConnect.getConnection();
		    int res = st.executeUpdate(query.toString());
		    if(res>=0) { 
		    	System.out.println("Your succeed 50% :) ");
		    	session.setAttribute("current_selection", foldername);
		    	response.sendRedirect("analysis-report.jsp");
		    }else {
		    	out.print("<script>alert('Error Occured ! '); window.location='dashboard.jsp'</script>");
		    }
				
			
		}catch(Exception ex) {
			System.out.println(ex);
		}
	}

	private boolean checkInteger(String string) {
		boolean result = false;
		String str = string.replace(".0", "");
		result = Pattern.matches("[0-9]+", str);
		if(result) number = Integer.parseInt(str);
	return result;
	}

	private void insertUploadedDetails(String foldername, String fpath, int user,HttpServletRequest request) {
		int added_id=0;
		System.out.println(foldername+" "+fpath+" "+user);
		try {
		    st = (Statement) DbConnect.getConnection(); 
		    int res = st.executeUpdate("insert into uploaded_files(semester,location,uploaded_by) "
		    		+ "values('"+foldername+"','"+fpath+"',"+user+") ");
		    System.out.println("Inserted Upload Details !");
		    HttpSession session = request.getSession();
		    
		    st = (Statement) DbConnect.getConnection();
			ResultSet rs = st.executeQuery("select id from uploaded_files where uploaded_by='"+user+"' ");
			if(rs.next()) {
				added_id = rs.getInt("id");
			}
			 session.setAttribute("added_id", added_id);
		}catch(Exception ex) {
			System.out.println(ex);
		}
	}

	private String[][] append(String[][] dataset2, String[][] records2) {
		 String result[][] = new String[dataset2.length + records2.length][];
		 System.arraycopy(dataset2, 0, result, 0, dataset2.length);
	     System.arraycopy(records2, 0, result, dataset2.length, records2.length);
		
		return result;
	}

	private String getSubjectCode(String file) {
		String header = sheet.getRow(0).getCell(1).getStringCellValue();
		String rheader = reverse(header);
		int indexofsubject = rheader.toString().indexOf('-');
		int indexofcode = rheader.indexOf('-', indexofsubject+1);
		subject_code = reverse(rheader.substring(indexofsubject+1, indexofcode).trim());
		String sub_name = reverse(rheader.substring(0, indexofsubject).trim());
		
		if(sub_name.equals("PRACTICAL")) {
			int indexofcd = rheader.indexOf('-', indexofcode+1);
			subject_code = reverse(rheader.substring(indexofcode+1, indexofcd).trim());
		}
		subject_code = subject_code.substring(8).trim();
		
		return subject_code;
	}

	private String getSubjectName(String file) {
		String header = sheet.getRow(0).getCell(1).getStringCellValue();
		String rheader = reverse(header);
		int indexofsubject = rheader.toString().indexOf('-');
		subject_name = reverse(rheader.substring(0, indexofsubject).trim());
		
		if(subject_name.equals("PRACTICAL")) {
			int indexofpractical = rheader.indexOf('-', indexofsubject+1);
			subject_name = reverse(rheader.substring(indexofsubject+1, indexofpractical).trim());
			subject_name += " PRACTICAL";
		}
		
		return subject_name;
	}
	
	private static String reverse(String text) {
		StringBuilder sb = new StringBuilder(text);
		return sb.reverse().toString();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			doGet(request, response);
	}

}
