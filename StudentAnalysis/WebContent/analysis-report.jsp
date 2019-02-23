<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!String name,dept,currentSelection; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">
<title>Report</title>
	    <% 
 	/*	 response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
	    
			if(session.getAttribute("user")==null){
				   out.println("No Session");
			}else{ 
			     name=session.getAttribute("user").toString();
			     dept=session.getAttribute("dept").toString();
			     currentSelection = session.getAttribute("current_selection").toString();
			} */
		%>
</head>
<body>
	
	<%if(session.getAttribute("user")!=null){ %> 
	
	<div class="container-fluid innercontainer header p-3">
		<h1 class="container">Student Analysis</h1>   
	</div>
	
	<div class="dashboard_head">
		<h3>Department of ${dept} Semester ${current_selection}</h3>
		<div class="viewopt">
			<a id="listbtn" class="viewbtn">List View</a>
			<a id="chartbtn" class="viewbtn">Chart View</a>
		</div>
	</div>
	
	<div class="list dashboard">
			list board
	</div>
	
	<div class="chart dashboard">
			Chart board 
	</div>
	
	<%} %> 
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/report.js"></script>
</body>
</html>