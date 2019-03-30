
$(document).ready(function(){
	
	$("#listbtn").addClass("active");
	$(".chart , .studentlist").hide();
	$("#listbtn").bind("click",showListView); 
	$("#chartbtn").bind("click",showChartView);
	$("#studentlistbtn").bind("click",showStudentView);
	$( "#draggable" ).draggable();
	//$('#subpasspercent').DataTable();
	
	//$('[data-highcharts-chart="0"]').css("height","100px");
	
	
});

function showListView(){
	$("#listbtn").addClass("active"); $("#chartbtn , #studentlistbtn").removeClass("active");
	$(".list").show(); $(".chart , .studentlist").hide();
}

function showChartView(){
	$("#chartbtn").addClass("active"); $("#listbtn , #studentlistbtn").removeClass("active");
	$(".chart").show(); $(".list , .studentlist").hide();
}

function showStudentView(){
	$("#studentlistbtn").addClass("active"); $("#listbtn , #chartbtn").removeClass("active");
	$(".studentlist").show(); $(".list, .chart").hide();
}

function getStudent(e){
	console.log($( $(e).html()).last().text() );
	let registerno = $($(e).html()).last().text().trim();
	$.ajax({
		url: 'StudentMark',
		method: 'post',
		data: {regno : registerno},
		success: function(result){
			$('table#highchart tbody').val("");
			$("#studentchart").html(result);
			$('table#highchart').highchartTable();
		}
	});
}

function doPrint(){
	window.print();
}

