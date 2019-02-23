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
	fileinput="";
	subjects=$('#sub').val();
	for(let i=0; i<subjects; i++){
		 fileinput += "<input type='file' name='"+i+"' class='form-control' >";
	}
	$("#fileinput").html(fileinput);
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