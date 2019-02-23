
$(document).ready(function(){
	$('#registercontainer').hide();
	$('#showRegister').bind("click",showRegisterForm);
	$('#showLogin').bind("click",showLoginForm);
	$('#loginbtn').bind("click",checkUser);
	$('#registerbtn').bind("click",createUser);
});

function showRegisterForm(){
	$('#logincontainer').fadeOut();
	$('#registercontainer').fadeIn();
	$('#msginfo').text(" "); $("input").removeClass("invalid");
}

function showLoginForm(){
	$('#registercontainer').fadeOut();
	$('#logincontainer').fadeIn(); 
	$("input").removeClass("invalid");
}

function createUser(e){
	e.preventDefault();
	$('#registerbtn').text('Registering...');
	$.ajax({
		url:'CreateUser',
		type:'post',
		data:$('#register').serialize(),
		success:function(result){
				alert(result);
		}
	});
	$('#registerbtn').text('Register');
}

function checkUser(e){
	e.preventDefault();
	$('#loginbtn').text('Submitting...');
	$.ajax({
		url:'CheckUser',
		type:'post',
		data:$('#login').serialize(),
		success:function(result){
			let res = $.trim(result);
				if(res==='success'){ 
						$('#msginfo').text("Login Success Redirecting... ! ");
						$("input").removeClass("invalid");
						$('#loginbtn').text('Submitting...');
						setTimeout(myFunction, 2500); function myFunction(){
						window.location="dashboard.jsp";
					}
					}else{ 
						$('#msginfo').text(res); $("input").addClass("invalid");
						$('#loginbtn').text('Submit');
						}
		}
	});
	
}