// JavaScript Document


function tanchu_iframe(htmlUrl,htmlTitle,htmlWidth,htmlHeight){
	var htmlHeight; //弹出框的高度
	var iframeHeight = htmlHeight-40;
	$("body").css({
		'width':'100%',
		'overflow':'auto'
	});
$("body").append('<div id="tanchu_all"><div class="black_bg"></div><div style="width:' + htmlWidth + 'px;height:' + htmlHeight + 'px;" class="tanchu_box"><div class="tanchu_title"><font>' + htmlTitle + '</font><div class="close_btn"><img src="images/tanchu/close_before.png" /></div></div><iframe src="' + htmlUrl + '" scrolling="yes" frameborder="0" width="100%" height="' + iframeHeight + '"></iframe></div></div>');
	$(".black_bg").height($(document).height());
	var tcbox_Height = $(".tanchu_box").height();
	var tcbox_Width = $(".tanchu_box").width();
	$(".tanchu_box").css("left","50%");
	$(".tanchu_box").css("top","50%");
	$(".tanchu_box").css("margin-left",-tcbox_Width/2);
	$(".tanchu_box").css("margin-top",-tcbox_Height/2 - 50);
	$(".close_btn img").mouseover(function(){
		$(".close_btn img").attr("src","images/tanchu/close_after.png");
	});
	$(".close_btn img").mouseout(function(){
		$(".close_btn img").attr("src","images/tanchu/close_before.png");
	});
	$(".close_btn img").click(function(){
		$("#tanchu_all").remove();
	});
}

function tanchu_pic(picUrl){
	$("body").css({
		'width':'100%',
		'height':'100%',
		'overflow':'auto'
	});
	$("body").append('<div id="tanchu_all"><div class="black_bg"></div><div class="tanchu_pic_box"><img src="'+picUrl+'" /></div></div>');
	$(".black_bg").height($("body").height());
	var tcbox_Height = $(".tanchu_pic_box").height() - 50;
	$(".tanchu_pic_box").height(tcbox_Height);
	$(".tanchu_pic_box IMG").height(tcbox_Height);
	var tcbox_Width = $(".tanchu_pic_box").width();
	$(".tanchu_pic_box").css("margin-left",-tcbox_Width/2);
	$(".tanchu_pic_box").css("margin-top",-tcbox_Height/2);
	$(".tanchu_pic_box").css("left","50%");
	$(".tanchu_pic_box").css("top","50%");
	setInterval('var tcbox_Height = $(".tanchu_pic_box").height();var tcbox_Width = $(".tanchu_pic_box").width();$(".tanchu_pic_box").css("margin-left",-tcbox_Width/2);$(".tanchu_pic_box").css("margin-top",-tcbox_Height/2);$(".tanchu_pic_box").css("left","50%");$(".tanchu_pic_box").css("top","50%");', 50);
	$("#tanchu_all").click(function(){
		$("#tanchu_all").remove();
	});
}

function loading(htmlTitle){
	var htmlTitle;
	$("body").css({
		'width':'100%',
		'height':'100%',
		'overflow':'auto'
	});
	$("body").append('<div id="tanchu_all"><div class="black_bg"></div><div class="loading_box"><font>'+htmlTitle+'</font></div></div>');
	$("#black_bg").height($("body").height());
	var tcbox_Height = $(".loading_box").height();
	var tcbox_Width = $(".loading_box").width();
	$(".loading_box").css("left","50%");
	$(".loading_box").css("top","50%");
	$(".loading_box").css("margin-left",-tcbox_Width/2);
	$(".loading_box").css("margin-top",-tcbox_Height/2 - 50);
	setTimeout('$("#loading_pic").css("display","block")' ,500);
}