<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@page import="com.analysis.dao.PassPercentage"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%!String name,dept,currentSelection; %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/all.min.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/report.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datatables.min.css">
 <link href="https://fonts.googleapis.com/css?family=Srisakdi:700" rel="stylesheet">
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/report.js"></script>
	
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
	<div class="list">
		<div class="dashboard">
			<h4>Subjectwise Pass Percentage </h4> 
			<table id="subpasspercent" class="table table-bordered text-center mt-4">  
				<thead>
					<tr>
						<th>S.No</th>
						<th>Subject Code</th>
						<th>Subject Name</th>
						<th>Student Appeared</th>
						<th>Student Passed</th>
						<th>ReAppear</th>
						<th>Pass Percentage</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${passpercentlist}" var="list" varStatus="loop">
							<tr>
								<td>${loop.index+1}</td>
								<td>${list.getSubjectcode()}</td>
								<td>${list.getSubjectname()}</td>
								<td>${list.getAppeared()}</td>
								<td>${list.getPassed()}</td>
								<td>${list.getRa()}</td>
								<td>${list.getPasspercent()}</td>
							</tr> 
					 </c:forEach> 
				</tbody>
			</table>
		</div>
		<div class="dashboard">
			<h4>Subjectwise Topper </h4> 
			<table id="subwisetopper" class="table table-bordered text-center mt-4">  
				<thead>
					<tr>
						<th>S.No</th>
						<th>Subject Code</th>
						<th>Subject Name</th>
						<th>Student Name</th>
						<th>Register No</th>
						<th>Mark</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${subjectwise}" var="list" varStatus="loop">
							<tr>
								<td>${loop.index+1}</td>
								<td>${list.getSubjectcode()}</td>
								<td>${list.getSubjectname()}</td>
								<td>${list.getName()}</td>
								<td>${list.getRegno()}</td>
								<td>${list.getMark()}</td>
							</tr> 
					 </c:forEach> 
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="chart">
		<div class="row">
		  <div class="col-6">
				 <div class="dashboard">
				<h4>Subjectwise Pass Percentage </h4> 
				<table class="table table-bordered text-center mt-4 highchart" data-graph-container-before="1" data-graph-type="column">  
					<thead>
						<tr>
							<th>Subject Name</th>
							<th>Pass Percentage</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${passpercentlist}" var="list" varStatus="loop">
								<tr>
									<td>${list.getSubjectname()}</td>
									<td>${list.getPasspercent()}</td>
								</tr> 
						 </c:forEach> 
					</tbody>
				</table>
			</div>
			</div>
			<div class="col-6">
			<div class="dashboard">
				<h4>Subjectwise Topper </h4> 
				<table class="table table-bordered text-center mt-4 highchart" data-graph-container-before="1" data-graph-type="column">  
					<thead>
						<tr>
							<th>Subject Name</th>
							<th>Student Name</th>
							<th>Mark</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${subjectwise}" var="list" varStatus="loop">
								<tr>
									<td>${list.getSubjectname()}</td>
									<td>${list.getName()}</td>
									<td data-graph-name="${list.getName()} : ${list.getMark()}">${list.getMark()}</td>
								</tr>  
						 </c:forEach> 
					</tbody>
				</table>
			</div>
			</div>
		</div>
	</div>
	
	<%} %> 
	
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/datatables.min.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highchartTable/2.0.0/jquery.highchartTable.min.js"></script>
    <script>
        $('table.highchart').highchartTable();
    </script>

</body>
</html>