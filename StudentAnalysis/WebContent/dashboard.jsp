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
		<h4>MENU</h4>
	</div>
	<div class="container innercontainer mt-5">
		<div class="row">
			<div class="col-9">
				<h1>Student Analysis</h1> 
			</div>
			<div class="col-2"></div>
			<div class="col-1">
				<span id="menu" class="float-right mt-3"><i class="fa fa-th-list fa-2x"></i></span> 
			</div>
		</div>   
	</div>
	
	<div class="dashboard">
		<h3 class="mb-3">Department of ${dept}</h3> 
		  <form action="upload" method="post" enctype="multipart/form-data">
		   <div class="form-row">
		   	  <div class="col">
				<div class="form-group">
		   			<label>Student Year:</label>
		   			<select name="stuyear" id="stuyear" class="form-control">
		   				<option selected>Choose year</option> 
		   				<option value="I">I</option> <option value="II">II</option>
		   				<option value="III">III</option>
		   			</select>
		   		</div>
		   	  </div>
		   	  <div class="col">
				<div class="form-group">
		   			<label>Semester :</label>
		   			<select name="semester" id="sem" class="form-control">
		   				<option selected>Choose Semester</option> 
		   				<option value="I">I</option> <option value="II">II</option>
		   				<option value="III">III</option> <option value="IV">IV</option>
		   				<option value="V">V</option> <option value="VI">VI</option>
		   			</select>
		   		</div>
		   	  </div>
		   	  <div class="col">
		   		  <div class="form-group">
		   			<label>Month :</label>
		   				<select name="month" id="month" class="form-control">
		   				<option selected>Select Month</option> 
		   				<option value="JAN">JAN</option> <option value="FEB">FEB</option>
		   				<option value="MAR">MAR</option> <option value="APR">APR</option>
		   				<option value="MAY">MAY</option> <option value="JUN">JUN</option>
		   				<option value="JUL">JUL</option> <option value="AUG">AUG</option>
		   				<option value="SEP">SEP</option> <option value="OCT">OCT</option>
		   				<option value="NOV">NOV</option> <option value="DEC">DEC</option>
		   			</select>
		   		  </div>
		   		</div> 
		   		<div class="col">
		   		  <div class="form-group">
		   			<label>Year :</label>
		   			<input type="text" name="year" id="year" class="form-control">
		   		  </div>
		   		</div> 
		   		<div class="col">
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
	<%} %> 
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>