
$(document).ready(function(){
	$("#listbtn").addClass("active");
	$(".chart").hide();
	$("#listbtn").bind("click",showListView);
	$("#chartbtn").bind("click",showChartView);
});

function showListView(){
	$("#listbtn").addClass("active"); $("#chartbtn").removeClass("active");
	$(".list").show(); $(".chart").hide();
}

function showChartView(){
	$("#chartbtn").addClass("active"); $("#listbtn").removeClass("active");
	$(".chart").show(); $(".list").hide();
}