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
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
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
	
	<div class="dashboard_head hide">
		<h3>Department of ${dept} Semester ${current_selection}</h3>
		<div class="viewopt">
			<a id="listbtn" class="viewbtn">List View</a>
			<a id="chartbtn" class="viewbtn">Chart View</a>
			<a id="studentlistbtn" class="viewbtn">Student List</a>
			
			<a id="printbtn" class="btn btn-sm btn-primary text-white" onclick="doPrint()">Print</a>
		</div>
	</div>
	<div class="list"> 
		<div class="dashboard">
			<h4 class="">No of Student Passed :${passfailstudents.get(0).getNoOfStudentPassed()} </h4>
			<h4 class="">No of Student Arrear :${passfailstudents.get(0).getNoOfStudentFailed()} </h4>
		</div>
	
		<div class="dashboard">
			<h4>Class Topper </h4> 
			<table id="classtopper" class="table table-bordered text-center mt-4">  
				<thead>
					<tr>
						<th>S.No</th>
						<th>Student Name</th>
						<th>Register No</th>
						<th>Percentage</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${classtopperlist}" var="list" varStatus="loop">
							<tr>
								<td>${loop.index+1}</td>
								<td>${list.getName()}</td>
								<td>${list.getRegno()}</td>
								<td>${list.getPercentage()}</td>
							</tr> 
					 </c:forEach> 
				</tbody>
			</table>
		</div>
		<div class="dashboard subpasspercent">
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
		<div class="dashboard subwisetopper">
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
	  <div class="container mt-3">
		<div class="row">
			<div class="col-md-6">
				<div class="dashboard">
					<h4>Class Topper </h4> 
					<table class="table table-bordered text-center mt-4 highchart" 
					data-graph-container-before="1" data-graph-type="column"
					data-graph-color-1="#36a2eb" data-graph-color-2="#ff9800" data-graph-color-3="#000000" data-graph-height="200">  
						<thead>
							<tr>
								<th>Student Name</th>
								<th>Percentage</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${classtopperlist}" var="list" varStatus="loop">
									<tr>
										<td>${list.getName()}</td>
										<td>${list.getPercentage()}</td>
									</tr> 
							 </c:forEach> 
						</tbody>
					</table>
				</div>
			</div>	
			<div class="col-md-6">
				<div class="dashboard">
					<h4>Pass / Fail  </h4> 
					<table class="table table-bordered text-center mt-4 highchart" data-graph-container-before="1" 
					data-graph-type="pie" data-graph-height="200" data-graph-color-1="#36a2eb" data-graph-color-2="#ff6384">  
						<thead>
							<tr>
								<th>Passed</th>
								<th>Student</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${passfailstudents}" var="list" varStatus="loop">
									<tr>
										<td>Passed</td>	
										<td data-graph-item-color="#36a2eb">${list.getNoOfStudentPassed()}</td>
									</tr>
									<tr>
										<td>Failed</td>
										<td data-graph-item-color="#ff6384">${list.getNoOfStudentFailed()}</td>
									</tr> 
							 </c:forEach> 
						</tbody>
					</table>
				</div>
			</div>
		</div>
		</div>
		
	
		<div class="row mt-5">
		  <div class="col-md-12">
				 <div class="dashboard">
				<h4>Subjectwise Pass Percentage </h4> 
				<table class="table table-bordered text-center mt-4 highchart" 
				data-graph-container-before="1" data-graph-type="column" 
				data-graph-color-1="#36a2eb" data-graph-color-2="#ff9800" data-graph-color-3="#000000">  
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
			<div class="col-md-12"> 
			<div class="dashboard">
				<h4>Subjectwise Topper </h4> 
				<table class="table table-bordered text-center mt-4 highchart" 
				data-graph-container-before="1" data-graph-type="column"
				data-graph-color-2="#36a2eb">  
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
	
	<div class="studentlist">
		<div class="dashboard">
			<h4 class="hide">Student List</h4>
			<div class="row">
				<div class="col-md-6 hide">
					<table id="studentlist" class="table table-bordered studentlist text-center mt-4">  
						<thead>
							<tr>
								<th>S.No</th>
								<th>Student Name</th>
								<th>Register No</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${studentlist}" var="list" varStatus="loop">
							<tr onclick="getStudent(this)">
								<td>${loop.index+1}</td>
								<td>${list.getStudentName()}</td>
								<td>${list.getRegisterNumber()}</td>
							</tr> 
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="col-md-5">
					<div class="studentchart " id="draggable_removed">
						<div id="studentchart" class="table table-bordered studentlist p-4 text-center mt-4">
							
						</div>
					</div>
				</div>
				<div class="col-md-1"></div>
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