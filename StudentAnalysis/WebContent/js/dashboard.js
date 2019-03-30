let semester,subjects,fileinput;
$(document).ready(function(){
	$("#sem").bind("change",getSemester);
	$("#sub").bind("keyup",getSubjects); $("#sub").bind("focusout",createFolder); 
	$("#menu").bind("click",toggleMenu);
 });  

function toggleMenu(){
	$(".sidepanel").toggleClass("toggle");
}

function getSemester(){
	semester=$('#sem').val();
}
function getSubjects(){
	let studentyear = $("#stuyear").val();
	let semester = $("#sem").val();
	let month = $("#month").val();
	let year = $("#year").val();
	if(studentyear !="Choose year" && semester != "Choose Semester" && month !="Select Month" && year !=""){
	fileinput="";
	subjects=$('#sub').val();
	for(let i=0; i<subjects; i++){
		 fileinput += "<input type='file' name='"+i+"' class='form-control' >";
	}
	$("#fileinput").html(fileinput);
  }else{
	  alert("Please Provide all the Necessary Fields...");
  }
}
function createFolder(){
	let studentyear = $("#stuyear").val();
	let semester = $("#sem").val();
	let month = $("#month").val();
	let year = $("#year").val();
	
	$.ajax({
		url:"CreateFolder",
		type:"post",
		data:{stuyear: studentyear, sem: semester, month: month, year: year},
		success:function(result){
				console.log(result);
			}
	});
}
function search(e){
	let data = $(e).val();
	$.ajax({
		url:"SearchSemester",
		type:"post",
		data:{semester : data},
		success:function(result){
				$(".semesters").html(result);
			}
	});
}
function openSemester(e){
	let semester = "";
	if(($(e).text())!="View Report"){
	   semester = $(e).text();  
	}else{
		semester = $(e).attr("value");
	}
		
	console.log(semester); 
	$.ajax({
		url:"CreateSession",
		type:"post",
		data: {semester:semester},
		success:function(result){
			console.log('session stored');
		}
	});
	$.ajax({
		url:'PassPercentageImpl',
		method:'post',
		success:function(result){
			console.log('calculated pass percentage for subject');
		}		
	});
	$.ajax({
		url:'SubjectwiseImpl',
		method:'post',
		success:function(result){
			console.log('calculated subejct wise topper');
		}		
	});
	$.ajax({
		url:'ClassTopperImpl',
		method:'post',
		success:function(result){
			console.log('calculated class topper');
		}		
	});
	$.ajax({
		url:'PassFailStudentsImpl',
		method:'post',
		success:function(result){
			console.log('calculated pass fail student');
		}		
	});
	$.ajax({
		url:'StudentListImpl',
		method:'post',
		success:function(result){
			console.log('list the student list');
		}		
	});
	$.ajax({
		url:'PassFailStudentsImpl',
		method:'post',
		success:function(result){
			console.log('Pass Fail student list stored');
			window.location='analysis-report.jsp';
		}		
	});
}
