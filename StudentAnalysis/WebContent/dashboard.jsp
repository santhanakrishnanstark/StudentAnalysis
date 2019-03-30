<%@page import="java.sql.ResultSet"%>
<%@page import="com.analysis.dao.DbConnect"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!String name,dept; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
 <link href="https://fonts.googleapis.com/css?family=Laila|Quicksand" rel="stylesheet">
 <link href="https://fonts.googleapis.com/css?family=Srisakdi:700" rel="stylesheet">
<title>Dashboard</title>
	    <% 
 		 response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	    
			if(session.getAttribute("user")==null){
				   out.println("No Session");
			}else{ 
			     name=session.getAttribute("user").toString();
			     dept=session.getAttribute("dept").toString();
			} 
		%>
</head>
<body>
	
	<%if(session.getAttribute("user")!=null){ %> 
	
	<div class="sidepanel px-3 py-5">
	<span id="menu" class="float-right"><i class="fa fa-bars fa-2x"></i></span>
		<h4 class="text-center">MENU</h4>
		<div class="mt-3 p-3">
			<table>
				<% Statement st = DbConnect.getConnection();
					ResultSet rs = st.executeQuery("select distinct(semester) from uploaded_files ");
					while(rs.next()){
				%>	  	
					<tr class="semrow mt-3">
						<td><i class="fa fa-folder-open text-secondary"></i> 
						<a onClick="openSemester(this)"><%=rs.getString(1) %></a></td>
					</tr>
				<% 	} 
				%>
			</table>
		</div>
	</div>
	<div class="container innercontainer mt-5">
		<div class="row">
			<div class="col-3">
			</div>
			<div class="col-9"><h1>Student Analysis</h1> </div>
			<div class="col-1"></div>
		</div>   
	</div>
	
	<div class="dashboard">
		<h3 class="mb-3">Department of ${dept}</h3> 
		  <form action="upload" method="post" enctype="multipart/form-data">
		   <div class="form-row">
		   	  <div class="col-md-3">
				<div class="form-group">
		   			<label>Student Year:</label>
		   			<select name="stuyear" id="stuyear" class="form-control" required>
		   				<option>Choose year</option> 
		   				<option value="I">I</option> <option value="II">II</option>
		   				<option value="III">III</option>
		   			</select>
		   		</div>
		   	  </div>
		   	  <div class="col-md-3">
				<div class="form-group">
		   			<label>Semester :</label>
		   			<select name="semester" id="sem" class="form-control" required>
		   				<option>Choose Semester</option> 
		   				<option value="I">I</option> <option value="II">II</option>
		   				<option value="III">III</option> <option value="IV">IV</option>
		   				<option value="V">V</option> <option value="VI">VI</option>
		   			</select>
		   		</div>
		   	  </div>
		   	  <div class="col-md-2">
		   		  <div class="form-group">
		   			<label>Month :</label>
		   				<select name="month" id="month" class="form-control" required>
		   				<option>Select Month</option> 
		   			    <option value="APR">APR</option>
		   				<option value="NOV">NOV</option> 
		   			</select>
		   		  </div>
		   		</div> 
		   		<div class="col-md-2">
		   		  <div class="form-group">
		   			<label>Year :</label>
		   			<input type="text" name="year" id="year" class="form-control" required>
		   		  </div>
		   		</div> 
		   		<div class="col-md-2">
		   		  <div class="form-group">
		   			<label>No of Subject :</label>
		   			<input type="number" name="subjects" id="sub" min="1" max="10" class="form-control">
		   		  </div>
		   		</div> 
		   </div>
		   
		   <div id="fileinput" class="mt-3">
		   		
		   </div>
		   
		   <div id="uploadbtn">
		       <div class="form-row">
		       		<div class="col"></div>
		       		<div class="col"></div>
		       		<div class="col"></div> 
		       		<div class="col">
		   				<input type="submit" value="Upload" class="btn submit_btn">
		       		</div>
		       </div>
		   </div>
	   </form>
	</div>
	
	<div class="dashboard">
	  <div class="row">
	  	<div class="col-md-8"></div>
	  	<div class="col-md-4">
	  		<input type="text" onkeyup="search(this)" class="form-control" placeholder="Search" />
	  	</div>
	  </div>
		<div class="row semesters mt-5">
			<% Statement st1 = DbConnect.getConnection();
					ResultSet rs1 = st.executeQuery("select u.semester,u1.username from uploaded_files AS u, users u1 WHERE u.uploaded_by=u1.id ");
					while(rs1.next()){
			%>
				<div class="col-md-4">
					<div class="card">
					  <img src="${pageContext.request.contextPath}/images/mark.png" style="height:80px" class="card-img-top" alt="...">
					  <div class="card-body">
					    <h6 class="card-title"><%=rs1.getString(1) %></h6>
					    <p class="card-text"></p>
					    <a onClick="openSemester(this)" value="<%=rs1.getString(1) %>" class="btn reportbtn">View Report</a>
					  	<footer class="blockquote-footer mt-2"> by <cite title="Source Title"> <%=rs1.getString(2) %></cite></footer>
					  </div>
					</div>
				</div> 
			 <%} %>
		</div>
	</div>
	
	
	<div class=" container fixed-bottom p-3">
      <a href="#" data-toggle="modal" data-target="#uploadform"><div class="add mb-5 d-inline-block p-2 mr-3" style="float: right;"><i class="icn fa fa-plus fa-1x" aria-hidden="true"></i></div></a>
    </div>
    

   <!-- Modal --> 
   <div class="modal fade" id="uploadform">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">Department of ${dept}</h3>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-center">
        <h5>**** Instructions ****</h5>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-warning text-white" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
  </form>
</div>
	
	<%} %> 
	
	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script><script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>