<%@page import="ssm.po.Integration"%>
<%@page import="ssm.po.readonly.UsersInfo"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% UsersInfo usersInfo = (UsersInfo)request.getSession().getAttribute("usersInfo");
	Integration integration = (Integration)request.getSession().getAttribute("integration");
%>		
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>修改头像-个人空间-潮州论坛</title>
    <link href="css/user/home.css" type="text/css" rel="stylesheet" />
    <link href="css/user/tag.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-3.1.1.js"></script>
    <script src="js/ajaxfileupload.js" type="text/javascript"></script>
</head>
<body>
 <div class="all">
        <input id="userId" type="hidden" value="42175" />
        <!--top 固定位置 str-->
        <script type="text/javascript">
            $(document).ready(function () {
            	 
               	var sex = "${usersInfo.sex }";
               	var county= "${usersInfo.county }";
               	if(sex=="男"){
               		$("#male").attr("checked","checked");
               	}else{
               		$("#female").attr("checked","checked");
               	}
               	if(county=="潮安区"){
               	  $("option:nth-of-type(1)").attr("selected","");
               	}else if(county == "枫溪区"){
               	 $("option:nth-of-type(2)").attr("selected","");
               	}else if(county == "湘桥区"){
               	 $("option:nth-of-type(3)").attr("selected","");
               	}else {
               	 $("option:nth-of-type(4)").attr("selected","");
               	}
              
              
               	
                $("#touxiang_tagContent0 .img_text").each(function () {
                    $(this).click(function () {
                        $("#tx_change").attr("src", $(this).attr("src"));
                        $(".xttx_img").removeClass("xttx_current");
                        var parents = $(this).parent();
                        parents.addClass("xttx_current");
                    });
                });

                $("#touxiang_tagContent2 .img_text").each(function () {
                    $(this).click(function () {
                        $("#Img2").attr("src", $(this).attr("src"));
                        $(".xttx_img").removeClass("xttx_current");
                        var parents = $(this).parent();
                        parents.addClass("xttx_current");
                    });
                });

                $("#touxiang_tagContent3 .img_text").each(function () {
                    $(this).click(function () {
                        $("#tx_change").attr("src", $(this).attr("src"));
                        $(".xttx_img").removeClass("xttx_current");
                        var parents = $(this).parent();
                        parents.addClass("xttx_current");
                    });
                });

            });

            function touxiang_selectTag(touxiang_showContent, touxiang_selfObj) {
                // 操作标签
                var touxiang_tag = document.getElementById("touxiang_tags").getElementsByTagName("li");
                var touxiang_taglength = touxiang_tag.length;
                for (i = 0; i < touxiang_taglength; i++) {
                    touxiang_tag[i].className = "";
                }
                touxiang_selfObj.parentNode.className = "touxiang_selectTag";
                // 操作内容
                for (i = 0; j = document.getElementById("touxiang_tagContent" + i); i++) {
                    j.style.display = "none";
                }
                document.getElementById(touxiang_showContent).style.display = "block";

                if (touxiang_showContent == "touxiang_tagContent1" || touxiang_showContent == "touxiang_tagContent2") {
                    $("#def_div").hide();
                    $("#upload_div").show();
                } else {
                    $("#def_div").show();
                    $("#upload_div").hide();
                }
            }
            
            $(document).ready(function(){
            	loginUp();
            })
            </script>
               <!--top 固定位置 end-->
       		 <div class="tops"> 
            <link href="css/top.css" type="text/css" rel="stylesheet" />
            <script src="js/tanchu.js" type="text/javascript"></script>
            <script language="javascript">

            	function loginUp(){
            		$(".nologin1").css("display","none");
            		$(".logined").css("display","block");
            	};
            	
                function ulshows() {
                    $("#ulshow").css('display', 'block');
                }
                function ulhide() {
                    $("#ulshow").css('display', 'none');
                }
                function getthread() {
                    $("#thread").css('display', 'none');
                    $("#friend").css('display', 'block');
                    $("#forum").css('display', 'block');
                    $("#ulshow").css('display', 'none');
                    $("#s_search span").html("帖子");
                }
                function getfriend() {
                    $("#thread").css('display', 'block');
                    $("#friend").css('display', 'none');
                    $("#forum").css('display', 'block');
                    $("#ulshow").css('display', 'none');
                    $("#s_search span").html("潮友");
                }
                function getforum() {
                    $("#thread").css('display', 'block');
                    $("#friend").css('display', 'block');
                    $("#forum").css('display', 'none');
                    $("#ulshow").css('display', 'none');
                    $("#s_search span").html("版块");
                }
                $(document).ready(function () {
                    
                    $.post("/Home/loginInfo.ashx?url=" + encodeURIComponent(encodeURIComponent(window.location.href)), {}, function (data) {
                        $("#topalls_div").append(data);
                    });
                    
                    var login_popupStatus = 0;
                    function login_loadPopup() {
                        if (login_popupStatus == 0) {
                            $("#login_backgroundPopup").css({
                                "opacity": "0.7"
                            });
                            $("#login_backgroundPopup").fadeIn("fast");
                            $("#login_popupContact").fadeIn("fast");
                            login_popupStatus = 1;
                        }
                    }

                    function login_disablePopup() {
                        if (login_popupStatus == 1) {
                            $("#login_backgroundPopup").fadeOut("slow");
                            $("#login_popupContact").fadeOut("slow");
                            login_popupStatus = 0;
                        }
                    }

                    function login_centerPopup() {
                        var windowWidth = document.documentElement.clientWidth;
                        var windowHeight = document.documentElement.clientHeight;
                        var popupHeight = $("#login_popupContact").height();
                        var popupWidth = $("#login_popupContact").width();
                        $("#login_popupContact").css({
                            "position": "absolute",
                            "top": windowHeight / 2 - popupHeight / 2,
                            "left": windowWidth / 2 - popupWidth / 2
                        });
                        $("#login_backgroundPopup").css({
                            "height": windowHeight
                        });
                    }

                    $(".login_button").click(function () {
                        login_centerPopup();
                        login_loadPopup();
                    });

                    $("#login_popupContactClose").click(function () {
                        login_disablePopup();
                    });
                });




                var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");

                var browser = navigator.userAgent.toLowerCase();

                var isMobile = false;
                
            </script>
            
            <div class="topall">
			<div id="topalls_div" class="topalls">
				<a href="index.jsp" title="中国潮州首页"><img id="top01" src="<%=basePath%>images/home/topczlt1.gif" alt="中国潮州首页" /></a>
				<a href="index.jsp" class="a_first headcurrent" style="margin-top:5px">论坛首页</a>
				<!--  
				 <a href="javascript:void(0);" id="weixin_button" class="a_first" style="margin-top:5px">精华帖</a>
				 -->
				
				
				<a href="exit2.jsp" class="logined" onclick="loginOut()" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; cursor:pointer; _padding-top: 5px; float: right; display:none">退出</a>
				<a href="javascript:void(0);" class="logined" id="user" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; _padding-top: 5px; float: right; display:none;">${sessionScope.data.email }</a>
			</div>
		</div>

        </div>
        <div class="contents">
            <div class="con_top">
              
<link href="css/user/home.css" type="text/css" rel="stylesheet" />
<div class="con_imgs">
    <img src="${usersInfo.image }" />
    
</div>
<div class="con_text">
    <div class="con_box02">
        <span>
            <p>
                <strong>昵称</strong>：${usersInfo.nickname }</p>
            <p>
                <strong>等级</strong>：${integration.monicker }</p>
            <p>
                <strong>帖子</strong>：${integration.postNum }</p>
            <p style="margin-right: 0;">
                <strong>回复</strong>：${integration.backNum }</p>
        </span>
        <span>
            <p>
                <strong>积分</strong>：<font style="color: #F60">${integration.score }</font></p>
            <p>
                
            </p>
        </span>
    </div>
    <div class="jiangzhang">
        
    </div>
</div>

            </div>
            <div class="home_content">
                
<div class="home_lef" id="home_lef">
    <a class="home_lef_first">设置</a>
    <div  class='home_lef_current'>
        <a href="user/userinfo"><img src="images/user/home01.gif" />修改头像</a>
    </div>
    <div >
        <a href="user/userinfo"><img src="images/user/home02.gif" />个人资料</a>
    </div>
    <div >
        <a href="user/userinfo"><img src="images/user/home03.gif" />修改密码</a>
    </div>
    <div >
        <a href="user/userinfo"><img src="images/user/home04.gif" />密码保护</a>
    </div>
    <div >
        <a href="user/userinfo"><img src="images/user/home05.gif" />积分</a>
    </div>
     <div >
        <a href="user/findfriend"><img src="images/user/home06.gif" />好友管理</a>
    </div>
    <div >
        <a href="user/postmessage"><img src="images/user/home08.gif" />给ta发信息</a>
    </div>
</div>

 
</body>
</html>