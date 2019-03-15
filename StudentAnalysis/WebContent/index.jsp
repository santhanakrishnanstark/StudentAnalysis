<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Homepage</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
 <link href="https://fonts.googleapis.com/css?family=Noto+Sans" rel="stylesheet">
 <link href="https://fonts.googleapis.com/css?family=Srisakdi:700" rel="stylesheet">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sweetalert2.min.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
</head>
<body>
	<div class="container innercontainer mt-5">
		<h1>Student Analysis</h1>      
	</div>
	<div class="container">
		<div class="row mt-5">
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-6">
						<img src="${pageContext.request.contextPath}/images/ch5.png">
					</div>
					<div class="col-md-6">
						<img src="${pageContext.request.contextPath}/images/ch1.png">
					</div>
				</div> 
				<div class="row">
					<div class="col-md-12">
						<img src="${pageContext.request.contextPath}/images/ch6.png" height="280px">
					</div>
				</div> 
			</div>
			<div class="col-md-2"></div>
			<div class="col-md-4">
				<div class="formcontainer pt-4 pb-3 px-4">
				  <div class="msgbox"> 
				  	<span id="msginfo"></span>
				  </div>
					<div id="logincontainer">
						<form id="login"> 
						<h4>Login</h4> <br>
							<div class="form-group">
								<label for="username">Username</label>
								<input type="text" name="username" class="form-control">
							</div>
							<div class="form-group">
								<label for="password">Password</label>
								<input type="password" name="password" class="form-control">
							</div>
							<div class="form-group">
								<label for="dept">Department</label>
								<select name="department" class="form-control">
									<option value="MCA">MCA</option>
									<option value="MBA">MBA</option>
								</select>
							</div>
							<span style="font-size: 14px">Create new Account  <a id="showRegister"> here</a></span> <br> <br>
							<button id="loginbtn" class="btn submit_btn">Submit</button>
						</form>
					</div>
					
					<div id="registercontainer">
						<form id="register"> 
						<h4>Register</h4> <br>
							<div class="form-group">
								<label for="username">Username</label>
								<input type="text" name="username" class="form-control">
							</div>
							<div class="form-group">
								<label for="dept">Department</label>
								<select name="department" class="form-control">
									<option value="MCA">MCA</option>
									<option value="MBA">MBA</option>
								</select>
							</div>
							<div class="form-group">
								<label for="password">Password</label>
								<input type="password" name="password" class="form-control">
							</div>
							<div class="form-group">
								<label for="cpassword">Confirm Password</label>
								<input type="password" name="cpassword" class="form-control">
							</div> 
							<button id="registerbtn" class="btn submit_btn">Register</button> 
							<br> <br>
							<span style="font-size: 14px">Already have Account ?  <a id="showLogin">Sign in</a></span> 
						</form>
					</div> 
					
					<!-- Message Box-->
					
				</div>
			</div>
		</div>
	</div>
	
	<footer class="container text-center">
		<h5>@Gurunanak college</h5>   
	</footer>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/sweetalert2.all.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index.js"></script>
	
</body>
</html>