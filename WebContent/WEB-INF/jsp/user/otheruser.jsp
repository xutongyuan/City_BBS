<%@page import="ssm.po.Users"%>
<%@page import="ssm.po.readonly.Theme_BackRead"%>
<%@page import="java.util.List"%>
<%@page import="ssm.po.readonly.ThemeRead"%>
<%@page import="com.github.pagehelper.Page"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>潮州交友论坛-用户空间</title>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		Users user =  (Users)session.getAttribute("data");
		Page<ThemeRead> tu = (Page<ThemeRead>)request.getAttribute("themelist");
		List<ThemeRead> list =	tu.getResult();
		
		List<Theme_BackRead> list2 = (List<Theme_BackRead>)request.getAttribute("backlist");
		List<ThemeRead> list3 = (List<ThemeRead>)request.getAttribute("jinglist");
		%>
		
		<base href="<%=basePath%>">

    <link href="css/otheruser.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-3.1.1.js"></script>
    <link rel="stylesheet" type="text/css" href="css/tag_otheruser.css" />
    <script type="text/javascript">
        $(document).ready(function () {
            changeImgSizeToId(490);
            setInterval(function () {
                changeImgSizeToId(490);
            }, 100);
        });

        function changeImgSizeToId(widthN) {
            $(".reply_box img").each(function () {
                var maxWidth = widthN;
                var img = new Image();
                img.src = $(this).attr("src");
                var height = img.height;
                var width = img.width;
                var newHeight = height / width * maxWidth;
                if (width > maxWidth) {
                    $(this).width(maxWidth);
                    $(this).height(newHeight);
                }
            });
        }

        function addFriendInfo() {
            var recUserId = '${iudata.userId}';
            <%if(user==null){	%>
            	alert("请先登录");
            	return false;
          <%  }else{%>
            var userId = '<%=user.getUserId()%>';
           	
            var json = {'postId':userId,'recevNickname':'${iudata.nickname }','recevId':recUserId};
            if(recUserId==userId){
            	alert("不能添加自己为好友");
            }else{
            	$.ajax({
    				type:'post',
    				url:'user/addfriend',
    				dataType:'json',
    				
    				data:json,
    				success:function(result){
    					console.log(result);
    					if(result.res="success"){
    						alert(result.mes);
    					}else{
    						alert("发送失败");
    					}
    				},
    				error:function(err){
    					alert("错误");
    				}
    			});  
            }
            
        <%  }%> 
        }
    </script>
    <style type="text/css">
        .yy_class
        {
            width: 960px;
            height: auto;
            border: 1px dashed #cccccc;
            background: #f9f9f9;
            margin-top: 15px;
            margin-left: 20px;
            line-height: 25px;
            letter-spacing: 2px;
            padding-left: 10px;
            padding-right: 10px;
        }
        .yy_re_class
        {
            width: 96%;
            height: auto;
            border: 1px dashed #cccccc;
            background: #f9f9f9;
            margin-top: 15px;
            line-height: 25px;
            letter-spacing: 2px;
            padding-left: 10px;
            padding-right: 10px;
        }
    </style>

</head>
<body style="background-color: #a4ddf2">
<jsp:include page="nav.jsp" flush="true"></jsp:include>
<div class = "top"></div>
<link href="css/top.css" type="text/css" rel="stylesheet" />
<script src="js/tanchu.js" type="text/javascript"></script>
<script language="javascript">
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


    function loginout() {
        if (confirm("您确定要退出吗？")) {
            loading("系统处理中...");
            $.post("/Home/ashx/outlogin.ashx", {}, function (data) {
                alert(data);
                if (data.indexOf("成功") != -1) {
                    location.reload();
                } else {
                    $("#tanchu_all").remove();
                }
            });
        }
    }


    var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");

    var browser = navigator.userAgent.toLowerCase();

    var isMobile = false;
    
</script>



	<div class="contents">
            <div class="con_main">
                <div class="con_main_left">
                    <div class="con_main_left_img">
                        <img src="${iudata.image }" />
                    </div>
                    <div class="con_main_left_text">
                        <div class="zhuti" style="border-right: 1px solid #dedede;">
                            <div class="ztnum" >
                                ${iudata.backNum }</div>
                            <div class="ztname">
                                回复</div>
                        </div>
                        <div class="zhuti" style="border-right: 1px solid #dedede;">
                            <div class="ztnum" title="总的发帖数为：644">
                                ${iudata.postNum }</div>
                            <div class="ztname">
                                帖子</div>
                        </div>
                        <div class="zhuti">
                            <div class="ztnum" title="总的积分为：20709">
                                ${iudata.score }</div>
                            <div class="ztname">
                                积分</div>
                        </div>
                       
                    </div>
                </div>
                <div class="con_main_middle">
                    <div class="con_main_middle_name">
                        <span>
                            <font name="name" style="font-size: 16px; font-weight: bold; float: left;">昵称：${iudata.nickname }</font>
                            <a style="display: inline" href="javascript:addFriendInfo()">加好友</a>
                        </span>
                        <span>
                            <p>等级：${iudata.monicker }</p>
                            
                        </span>
                    </div>
                    <div id="con">
                        <ul id="tags">
                            <li id="li1" class="selectTag">
                                <a onclick="selectTag('tagContent0',this)" href="javascript:void(0)">ta的帖子</a>
                            </li>
                            <li id="li2" class="">
                                <a onclick="selectTag('tagContent1',this)" href="javascript:void(0)">ta的回复</a>
                            </li>
                            <li id="li3" class="">
                                <a onclick="selectTag('tagContent2',this)" href="javascript:void(0)">ta的精华帖</a>
                            </li>
                           
                        </ul>
                        <div id="tagContent">
                            <!--他的帖子-->
                            <div class="tagContent selectTag" id="tagContent0">
                               <c:forEach items="<%=list %>" var="list"> 
                                <div class="tiezi_box">
                                    <div class="tiezi_box_title">
                                        <a href="javascript:doPost('content/showDetail',{'postId':'${list.postId }','userId':'${list.userId }','area':'${list.area }'});">${list.title }</a>
                                    </div>
                                    <div class="tiezi_box_content">
                                        
                                    </div>
                                    <div class="tiezi_box_other">
                                        <span style="float: right;">
                                            来自：<a class="area1" href="content/getlist?area=${list.area } " title="进入该版块">${list.area }</a></span>
                                        <span style="float: right; margin-right: 10px;">
                                            ${list.postingTime }</span>
                                        <span style="margin-right: 10px;">
                                            查看：<a href="javascript:void(0);">${list.readcount }</a></span>
                                        <span>
                                            回复：<a href="javascript:void(0);">${list.backcount }</a></span>
                                    </div>
                                    ${list.content }
                               		 </div>
                               	</c:forEach> 

                                <div class="page">
								
								<span class="page_1" ><a href="javascript:doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':<%=tu.getPageNum()-1 %>},'_self');" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':<%=tu.getPageNum()+1 %>},'_self');" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
									<input style="width: 30px" class="txt_page" id="txt_page1" value="1" />&nbsp;
										<a class="go_btn" href="javascript:void(0)" onclick="jump1()">Go>></a>
								
								</div>
                            </div>
                            <!--他的回复-->
                            <div class="tagContent " id="tagContent1">
                            
                                <c:forEach items="<%=list2 %>" var="list"> 
                                <div class="tiezi_box">
                                    <div class="tiezi_box_title">
                                        <a href="javascript:doPost('content/showDetail',{'postId':'${list.postId }','userId':'${list.userId }','area':'${list.area }'});">${list.title }</a>        
                                    </div>
                                    <div class="tiezi_box_content">
                                        ${list.content }
                                    </div>
                                    <div class="tiezi_box_other">
                                        <span style="float: right;">
                                            来自：<a class="area1" href="content/getlist?area=${list.area }" title="进入该版块">${list.area }</a></span>
                                        <span style="float: right; margin-right: 10px;">
                                            ${list.replyTime }</span>
                                        <span style="margin-right: 10px;">
                                            查看：<a href="javascript:void(0);">${list.readCount }</a></span>
                                        <span>
                                            回复：<a href="javascript:void(0);">${list.backCount }</a></span>
                                    </div>
                                    <div class="reply_box">
                                        <strong>回复的内容</strong>：<br />
                                        <span></span><p>${list.backcontent }</p>
                                        
<%--                                        <img src="http://wscz.chaozhou.gov.cn/controls/ueditor/dialogs/emotion/images/jx2/j_0058.gif" />--%>
                                        
                                    </div>
                                </div>
								</c:forEach>
                                
                                <!-- 
                                <div class="page">
                               
								<span class="page_1" ><a href="javascript:doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':<%=tu.getPageNum()-1 %>},'_self');" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':<%=tu.getPageNum()+1 %>},'_self');" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
									<input style="width: 30px" class="txt_page" id="txt_page1" value="1" />&nbsp;
										<a class="go_btn" href="javascript:void(0)" onclick="jump1()">Go>></a>
								
								</div>
								 --> 
                            </div>
                            <!--他的精华帖-->
                            <div class="tagContent selectTag" id="tagContent0">
                               <c:forEach items="<%=list3 %>" var="list"> 
                                <div class="tiezi_box">
                                    <div class="tiezi_box_title">
                                        <a href="javascript:doPost('content/showDetail',{'postId':'${list.postId }','userId':'${list.userId }','area':'${list.area }'});">${list.title }</a>
                                        <span class="imgs">
                                        <img src="<%=basePath %>/images/showlist/jing.gif">
                                    </span>
                                    </div>
                                    
                                    <div class="tiezi_box_content">
                                        
                                    </div>
                                    <div class="tiezi_box_other">
                                        <span style="float: right;">
                                            来自：<a class="area1" href="content/getlist?area=${list.area }" title="进入该版块">${list.area }</a></span>
                                        <span style="float: right; margin-right: 10px;">
                                            ${list.postingTime }</span>
                                        <span style="margin-right: 10px;">
                                            查看：<a href="javascript:void(0);">${list.readcount }</a></span>
                                        <span>
                                            回复：<a href="javascript:void(0);">${list.backcount }</a></span>
                                    </div>
                                    ${list.content }
                               		 </div>
                               	</c:forEach> 

                                <div class="page">
								
								<!--  
								<span class="page_1" ><a href="javascript:doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':<%=tu.getPageNum()-1 %>},'_self');" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':<%=tu.getPageNum()+1 %>},'_self');" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
									<input style="width: 30px" class="txt_page" id="txt_page1" value="1" />&nbsp;
										<a class="go_btn" href="javascript:void(0)" onclick="jump1()">Go>></a>
								
								</div>
								-->
                            </div>

                            </div>     
                            </div>
                        </div>
                    </div>
                </div>
               
            </div>
            <!--操作标签 jQ-->
            <script type="text/javascript">
                function selectTag(showContent, selfObj) {
                    // 操作标签
                    var tag = document.getElementById("tags").getElementsByTagName("li");
                    var taglength = tag.length;
                    for (i = 0; i < taglength; i++) {
                        tag[i].className = "";
                    }
                    selfObj.parentNode.className = "selectTag";
                    // 操作内容
                    for (i = 0; j = document.getElementById("tagContent" + i); i++) {
                        j.style.display = "none";
                    }
                    document.getElementById(showContent).style.display = "block";
                    window.onload = herback();
                }
                function selectTag2() {
                    // 操作标签
                    var type = document.getElementById("type").value;
                    var tag = document.getElementById("tags").getElementsByTagName("li");
                    var taglength = tag.length;
                    for (i = 0; i < taglength; i++) {
                        tag[i].className = "";
                    }
                    document.getElementById("li" + type).className = "selectTag";
                    // 操作内容
                    for (i = 0; j = document.getElementById("tagContent" + i); i++) {
                        j.style.display = "none";
                    }
                    document.getElementById("tagContent" + (type - 1)).style.display = "block";
                }
                window.onload = selectTag2;
            </script>
            <div class="blank8">
            </div>
            <div class="user_bottom">
<%--          		    版权by:五邑大学 160810班 许桐源 &nbsp;仅用于毕业设计--%>
    粤ICP备2022047901
                <br>
            </div>

	
	<script>
	function jump1(){
		var index = $("#txt_page1").val();
		var maxindex = <%=tu.getPages() %>;
		if(index>maxindex||index<1){
			alert("超出范围，无内容");
			return;
		}
		doPost('user/otherUser',{'userId':'${iudata.userId }','pageIndex':index},'_self');
		}  
	//post方式提交a标签
	    function doPost(to, params,location) {  // to:提交动作（action）,p:参数  
	        var myForm = document.createElement("form");       
	        myForm.method = "post";  
	        myForm.action = to;  
	        myForm.target = location;
	    for (var i in params){      
             var myInput = document.createElement("input");       
             myInput.setAttribute("name", i);  // 为input对象设置name  
             myInput.setAttribute("value", params[i]);  // 为input对象设置value  
             myForm.appendChild(myInput);  
	         }     
         document.body.appendChild(myForm);     
         myForm.submit();   
         document.body.removeChild(myForm);  // 提交后移除创建的form  
   		 }
		$(document).ready(function(){
			 var areaStr = {"1":"我说潮州","2":"找男友","3":"找女友","4":"骑行交友","5":"摄影交友","6":"电影交友",
						"7":"以茶会友","8":"聚会party","9":"创业交流","10":"健身交流","11":"体育交流","12":"爱吃一族",
						"13":"爱车一族","14":"家有儿女","15":"家有宠物","16":"游记分享","17":"游戏讨论","18":"艺术园地",
						"19":"跳蚤市场","20":"爱心公益","21":"开心一刻","22":"灌水专区","30":"搜索页面"};
				$(".area1").each(function(){
					var curNum = $(this).text();
					$(this).text(areaStr[curNum]);
				})
		})
	   
		
	</script>
</body>
</html>