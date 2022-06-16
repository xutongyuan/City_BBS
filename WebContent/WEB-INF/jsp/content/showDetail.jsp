<%@page import="ssm.po.Users"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="ssm.po.readonly.ThemeBackRead"%>
<%@page import="ssm.po.readonly.ThemeRead"%>
<%@page import="java.util.List"%>
<%@page import="com.github.pagehelper.Page"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
   + path + "/";
 ThemeRead themeRead = (ThemeRead)request.getAttribute("themeRead");
 
 String areaStr = (String)request.getAttribute("area");
 System.out.println("--------"+areaStr);
	pageContext.setAttribute("curArea", areaStr);	//当前论坛板块编号
	
 if(themeRead!=null){
 	pageContext.setAttribute("curPostId", themeRead.getPostId());	//当前主题帖Id
 }
 Page<ThemeBackRead> tu = (Page<ThemeBackRead>)request.getAttribute("backList");
List<ThemeBackRead> list =	tu.getResult();

Users user = (Users)session.getAttribute("data");
%>
	<base href="<%=basePath%>">

		<script src="js/jquery-3.1.1.js" type="text/javascript"></script>
		<link href="css/showlist/common.css" type="text/css" rel="stylesheet" />
		<link rel="stylesheet" href="css/content.css" />
		<script src="js/toptav.js" type="text/javascript" charset="gbk"></script>
		<link rel="stylesheet" href="css/content.css" />
		<script type="text/javascript">
			$(document).ready(function () {
	        	function log_close() {
	            $("#logingbox").hide();
	        	}
	        })
		</script>
		
        
	</head>
	
	<body>
	<jsp:include page="/nav.jsp"></jsp:include>
	<div style="width:1024px;margin:0 auto;height:100%">
		<div class="hB mb10 fwb" style="float:left;">
						<h2 class="mr20 fl f12">
							<font color="#005fa7">当前版块：<strong id="bankuai"></strong></font> 
						</h2>
		</div>
		<div class="pages">

			<span>
                    <a class="post02" href="javascript:roll_bottom();" title="回复">我要回复</a></span>

			<span>
                  
                </span>

			<div class="fl" style="padding-top: 4px">
				<div class="page">
								
								<span class="page_1" ><a href="javascript:doPost('content/showDetail',{'postId':<%=pageContext.getAttribute("curPostId") %>,'area':'<%=areaStr%>','pageIndex':<%=tu.getPageNum()-1 %>},'_self');" style="color:black;" id="pre1">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('content/showDetail',{'postId':<%=pageContext.getAttribute("curPostId") %>,'area':'<%=areaStr%>','pageIndex':<%=tu.getPageNum()+1 %>},'_self');" style="color:black;" id="next1">&nbsp;&nbsp;下一页&nbsp;</a></span>
									
								
				</div>
			</div>
		</div>
		
		<div class="main_content">
			<table cellspacing="0" cellpadding="0">
				<tbody>
					<tr>
						<td class="pls ptn pbn">
							<div class="hm" style="padding-top: 2px;">
								<font style="color: #888;">查看: </font>
								<font style="color: #F26C4F;">${themeRead.readcount }</font>
								<br />
								<font style="color: #888;">回复: </font>
								<font style="color: #F26C4F;">${themeRead.backcount }</font>
							</div>
						</td>
						<td class="plc ptn pbn vwthd" id="td_title">
							<font style="color: #555; font-size: 16px; font-weight: bold; letter-spacing: 2px;">
							<font style="color: #F90;">【原创】</font>${themeRead.title }</font>	
						</td>
					</tr>
				</tbody>
			</table>

		<% if(request.getAttribute("integration")!=null){ %>
			<table cellspacing="0" cellpadding="0" class="ad">
				<tbody>
					<tr>
						<td class="pls">
						</td>
						<td class="plc">
						</td>
					</tr>
				</tbody>
			</table>
			<table>
				<tr>
					<td class="pls">
						<div class="pls" style="border: none;">

							<div class="txnc">
								<div class="nicheng">
									<a href="javascript:void(0);" name="1">${themeRead.nickname }</a>
								</div>
								<div class="tx_box">
									<div class="txBG">
										<a href="javascript:doPost('user/otherUser',{'userId':'${integration.userId }'},'_blank');"><img src="<%=basePath%>${themeRead.image }" /></a>
									</div>

								</div>
							</div>

							<div class="zttz">
								<div class="zhuti">
									<div class="ztnum">
										<a href="#">${integration.backNum }</a>
									</div>
									<div class="ztname">
										回复</div>
								</div>
								<div class="tiezi">
									<div class="ztnum">
										<a href="#">${integration.postNum }</a>
									</div>
									<div class="ztname">
										帖子</div>
								</div>
							</div>
							<div class="djxx" name="等级信息">
								<span>
                                        等级:</span>
								<a href="javascript:void(0);">${integration.monicker }</a>
								<span>
                                        积分:</span>
								<a href="javascript:void(0);">${integration.score }</a>
								
							<div class="jiangzhang">

							</div>
						</div>
						
					</td>
					<td class="plc">
						<div style="width: 160px; height: 100px; position: absolute; right: 300px; top: 0px; z-index: 1">

						</div>
						<div>
						</div>
						<div class="fby">
							<img src="images/showDetail/online_member.gif" />
							<font style="font-size: 12px; color: #555; float: left;">发表于:${themeRead.postingTime }</font>
							<span style="float: right; margin-left: 5px;">
                                    <img src="/Home/<%=basePath%>images/thread-prev.png" title="跳转到第一楼层" style="margin-left: 10px; cursor: pointer; display: none;" />
                                    <input id="floor" type="text" style="width: 25px; height: 15px; float: left; margin-top: -4px; margin-left: 5px; text-align: center;" />
                                    <img onclick="jumptofloor();" src="<%=basePath%>images/showDetail/fj_btn.png" title="跳转到指定楼层" style="margin-left: 5px; cursor: pointer;" />
                                    <img onclick="jumptolastfloor();" src="<%=basePath%>images/showDetail/thread-next.png"title="跳转到最后一楼层" style="margin-left: 5px; cursor: pointer;" />
                                </span>
							<font style="font-size: 12px; color: #555; float: right;">楼主</font>
						</div>

						 <%if(session.getAttribute("data")==null||session.getAttribute("data").equals("")){ %>
				            	<div class="logingbox" id="logingbox">
							<div class="logingbox01">
								<div class="log_close">
									<a href="javascript:$('.logingbox').hide();" title="关闭该界面">X</a>
								</div>
								<font>欢迎您注册潮州论坛，注册后您将享有更多功能</font>
								<span>
                                  	您需要<a class="login_button" style="cursor: pointer" href="javascript:login()">登录</a>才可以回复，没有帐号？<a href="register.jsp" target="_blank">注册</a>
	                             </span>
								</div>
							</div>
				         <%} %>
						

						<div class="li_contents" id="li_1">
							${themeRead.content }	<!-- 主题帖内容 -->
						
						</div>

						
						
		</td>
		</tr>
		</table>
		<%} %>
		<c:forEach items="<%=list %>" var="list" varStatus="status">
		<table cellspacing="0" cellpadding="0" class="ad">
			<tbody>
				<tr>
					<a name="" id=""></a>
					<td class="pls">
					</td>
					<td class="plc">
					</td>
				</tr>
			</tbody>
		</table>
		<table>
			<tr>
				<td class="pls">
					<div class="pls" style="border: none;">
						<div class="txnc">

							<div class="txnc">
								<div class="nicheng">
									<a href="/user/space/8821/1/_1" name="2">${list.nickname }</a>
								</div>
								<div class="tx_box">
									<div class="txBG">
										<a href="javascript:doPost('user/otherUser',{'userId':'${list.userId }'},'_blank');"><img src="<%=basePath%>${list.image }" /></a>
									</div>

								</div>
							</div>

						</div>
						
						<div class="djxx" name="等级信息">
							<span style="margin-top: 5px;">
                                        等级:</span>
							<a href="javascript:;" style="margin-top: 5px;">${list.monicker }</a>
			
						<div class="jiangzhang">

						</div>
					</div>
				</td>
				
				<td class="plc">
					<div class="fby">
						<img src="images/showDetail/online_member.gif" />
						<font style="font-size: 12px; color: #555; float: left;">${list.replyTime }</font>
						<font style="font-size: 12px; color: #555; float: right;" class="louceng">${status.count }</font>
					</div>
					<div class="li_contents">

						<div id="li_2">
							${list.content }
						</div>
					</div>
					<div class="yyhf">
						<c:set var="userId" value="${list.userId }" scope="page"></c:set>
						<%if(user==null){
							
						}else{
							String[] strArray = user.getPmsArea().split(",");
							String uid = (String)pageContext.getAttribute("userId");
							
							if(user.getRoleId()==2){
								for(int i=0;i<strArray.length;i++){
									if(user.getUserId().equals(uid)){	%>
						
						<a href="javascript:void(0);"  class="removeBack" title="删除">删除</a>
						<font style="color: #999; margin-left: 10px; margin-right: 10px; float: left; margin-top: -2px; _margin-top: 0px;">|</font>		
						
						<% 	break;		}else if(strArray[i].equals(areaStr)){	%>
						
						<a href="javascript:void(0);" class="removeBack" title="删除">删除</a>
						<font style="color: #999; margin-left: 10px; margin-right: 10px; float: left; margin-top: -2px; _margin-top: 0px;">|</font>
						
						<% break; }	
								}
							}else if(user.getRoleId()==3&&user.getUserId().equals(uid)){%>
						
						<a href="javascript:void(0);"  class="removeBack" title="删除">删除</a>
						<font style="color: #999; margin-left: 10px; margin-right: 10px; float: left; margin-top: -2px; _margin-top: 0px;">|</font>
						
						<%	}
						} %>
						
						<input type="text" value="${list.backId }" class="backId" style="display:none;">
						
					</div>
				</td>
			</tr>
		</table>
		</c:forEach>
		</div>
		
		<div class="pages">

			<span>
                    
                </span>

			<div class="fl" style="padding-top: 4px">
			<!-- 
				<div class="page">
					<span class="page_1">&nbsp;&nbsp;共6条/1页&nbsp;</span><input style="width:30px" class="txt_page" id="txt_page74511330" value="1" />&nbsp;
					<a class="go_btn" href="javascript:location='_'+($.trim($('#txt_page74511330').val())==''?1:$.trim($('#txt_page74511330').val()));">Go>></a>
				</div>
				-->
				
				<div class="page">
								
								<span class="page_1" ><a href="javascript:doPost('content/showDetail',{'postId':<%=pageContext.getAttribute("curPostId") %>,'area':'<%=areaStr%>','pageIndex':<%=tu.getPageNum()-1 %>},'_self');" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('content/showDetail',{'postId':<%=pageContext.getAttribute("curPostId") %>,'area':'<%=areaStr%>','pageIndex':<%=tu.getPageNum()+1 %>},'_self');" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
									<input style="width: 30px" class="txt_page" id="txt_page1815393863" value="1" />&nbsp;
										<a class="go_btn" href="javascript:void(0)" onclick="jump()">Go>></a>
								
				</div>
			</div>
		</div>
		
		 <%if(session.getAttribute("data")==null||session.getAttribute("data").equals("")){ %>
            	<jsp:include page="nologin_bottom.jsp" flush="true"></jsp:include>
         <%}else{ %>
         	 	<jsp:include page="post_back.jsp" flush="true">
         	 		<jsp:param value='<%=pageContext.getAttribute("curPostId") %>'
			name="postId" />
         	 	</jsp:include>
         	 	
         <%} %>
         
         <div class="back_top_bottom" style="display: none;">
			<img id="backtop" alt="返回顶部"
				src="<%=basePath%>images/showlist/backtop_01.png"
				style="margin-bottom: 15px;" />
			<img id="backbottom" alt="返回底部"
				src="<%=basePath%>images/showlist/backbottom_01.png" />
		</div>
	</div>
	<div class="footer">
    <div class="COMM">
        <div class="foot_img" id="div_123"><span id="_ideConac"><a href="javascript:void(0)" target="_blank"><img id="imgConac" vspace="0" hspace="0" border="0" src="images/home/topczlt1.gif" ></a></span></div>
        <div id="copyr">
<%--       		    版权by:五邑大学 160810班 许桐源 &nbsp;仅用于毕业设计--%>
			粤ICP备2022047901
        </div>
    </div>
	</div>
	<script>
	
	function jump(){
		var index = $("#txt_page1815393863").val();
		var maxindex = <%=tu.getPages() %>;
		if(index>maxindex||index<1){
			alert("超出范围，无内容");
			return;
		}
		doPost('content/showDetail',
					{'postId':<%=pageContext.getAttribute("curPostId") %>,"area":<%=areaStr%>,'pageIndex':index},'_self');
	}
	
	$(document).ready(function(){
		var curpage = <%=tu.getPageNum() %>;
		var maxpage = <%=tu.getPages() %>;
		
		if(curpage<=1){
			$("#pre1").attr('href', 'javascript:void(0)'); 
			$("#pre2").attr('href', 'javascript:void(0)'); 
		}else{
			$("#pre1").attr('href', 'javascript:doPost("content/showDetail",{"postId":<%=pageContext.getAttribute("curPostId") %>,"area":"<%=areaStr%>","pageIndex":"<%=tu.getPageNum()-1 %>"},"_self")'); 
			$("#pre2").attr('href', 'javascript:doPost("content/showDetail",{"postId":<%=pageContext.getAttribute("curPostId") %>,"area":"<%=areaStr%>","pageIndex":"<%=tu.getPageNum()-1 %>"},"_self")'); 
		}
		
		if(curpage>=maxpage){
			$("#next1").attr('href', 'javascript:void(0)'); 
			$("#next2").attr('href', 'javascript:void(0)'); 
		}else{
			$("#next1").attr('href', 'javascript:doPost("content/showDetail",{"postId":<%=pageContext.getAttribute("curPostId") %>,"area":"<%=areaStr%>","pageIndex":<%=tu.getPageNum()+1 %>},"_self")'); 
			$("#next2").attr('href', 'javascript:doPost("content/showDetail",{"postId":<%=pageContext.getAttribute("curPostId") %>,"area":"<%=areaStr%>","pageIndex":<%=tu.getPageNum()+1 %>},"_self")'); 
			
		}
		
		
	})
	//删除帖子事件
	$(".removeBack").click(function(event){
		 if (confirm("确认删除该条回复吗？")){ 
			 var backId = $(this).next().next().val();
			

			 $.ajax({
					type:'post',
					url:'content/removeBack',
					dataType:'json',
					
					data:{"backId":backId},
					success:function(result){
						$.each(result, function(index, item) {
							window.location.reload();
					});
					},
					error:function(err){
						alert("错误");
					}
				});

	        }else {  
	          
	        } 
		 event.stopPropagation();
	})
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
	//楼层设置
	$(document).ready(function(){
		
		var page = <%=tu.getPageNum() %>;
		
		$(".louceng").each(function(){
			var num = parseInt($(this).text());
			var value = num+(page-1)*10;
			var valStr = value+"楼";
			$(this).text(valStr);
		});
	})
	
	var areaStr = {"1":"我说潮州","2":"找男友","3":"找女友","4":"骑行交友","5":"摄影交友","6":"电影交友",
					"7":"以茶会友","8":"聚会party","9":"创业交流","10":"健身交流","11":"体育交流","12":"爱吃一族",
					"13":"爱车一族","14":"家有儿女","15":"家有宠物","16":"游记分享","17":"游戏讨论","18":"艺术园地",
					"19":"跳蚤市场","20":"新闻时事","21":"开心一刻","22":"灌水专区","30":"搜索页面"};
	var curNum = "<%=pageContext.getAttribute("curArea") %>";
	$("#bankuai").text(areaStr[curNum]);
	//回滚最下面
	function roll_bottom(){
		$('html,body').animate({ scrollTop: document.body.clientHeight }, 500);
	}
	</script>
	
	<style>
		.hm font{float:none;}
	</style>
</body>
</html>