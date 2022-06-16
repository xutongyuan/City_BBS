<%@page import="ssm.po.Users"%>
<%@page import="ssm.po.readonly.ThemeRead"%>
<%@page import="java.util.List"%>
<%@page import="com.github.pagehelper.Page"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String areaStr = (String)request.getAttribute("area");
	pageContext.setAttribute("curArea", areaStr);	//当前论坛板块编号

	System.out.println("当前页面编号"+pageContext.getAttribute("curArea"));
	Page<ThemeRead> tu = (Page<ThemeRead>)request.getAttribute("postlist");
	List<ThemeRead> list =	tu.getResult();
	
	Page<ThemeRead> tu2 = (Page<ThemeRead>)request.getAttribute("goodlist");
	List<ThemeRead> list2 =	tu2.getResult();
	
	Users user = (Users)session.getAttribute("data");
%>
<base href="<%=basePath%>">
<link href="css/showlist/common.css" type="text/css" rel="stylesheet" />
<link href="css/showlist/share.css" type="text/css" rel="stylesheet" />
<link href="css/showlist/foot.css" type="text/css" rel="stylesheet" />
<script src="js/jquery-3.1.1.js" type="text/javascript"></script>
<script src="js/toptav.js" type="text/javascript" charset="gbk"></script>
<link href="css/showlist/select2css.css" type="text/css"
	rel="stylesheet" />


<script src="js/tanchu.js" type="text/javascript"></script>
</head>
<body>

	<jsp:include page="/nav.jsp"></jsp:include>
	<div class="lm_juti">
		<div style="height: 25px;">
			<img class="breadHome" id="td_cate" title="快速跳转至其他版块"
				src="<%=basePath%>images/showlist/home.gif" />
			版主: &nbsp; <a href="javascript:void(0)" class="ownerName">中国潮州网</a> &nbsp; &nbsp; &nbsp;
		</div>

	</div>
	<div class="blank8"></div>
	<div class="pw_content" id="pw_content">
		<div class="f_tree cc" id="sidebar">
			<div class="content_thread cc">
				<div class="content_ie">
					<div class="hB mb10 fwb">
						<h2 class="mr20 fl f12">
							<font color="#005fa7">当前版块：<strong id="bankuai"></strong></font> 
						</h2>
					</div>
					<div class="sidePd10"></div>
					<div id="c">
						<div class="cc pagess" id="tabA">

							<div class="fl" style="padding-top: 4px">
								<div class="page">
								<span class="page_1" ><a href="javascript:doPost('content/getlist',{'area':'<%=areaStr %>','pageIndex':<%=tu.getPageNum()-1 %>},'_self')" style="color:black;" id="pre1">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('content/getlist',{'area':'<%=areaStr %>','pageIndex':<%=tu.getPageNum()+1 %>},'_self')" style="color:black;" id="next1">&nbsp;&nbsp;下一页&nbsp;</a></span>
	
								</div>
							</div>
						</div>
						<div class="tadlist">
							<div class="tabA" style="display: none;">
								<ul class="cc">
									<li class="current"><a href="#">所有帖子</a></li>
								</ul>
							</div>
							<div id="ajaxtable">
								<div class="z threadCommon">
									<table style="table-layout: fixed" width="100%">
										<tbody id="threadlist">
											<tr class="tr4">
												<td width="50" class="style3" style="padding: 0px;">
													&nbsp;</td>
												<td class="style4" style="padding-left: 0px">
												<!-- 
												<span	style="font-size: 13px; float: left; padding-top: 6px; color: #f60; font-weight: bold;">筛选：</span>
													<div id="tm2008style">
														<select name="language_tm2008" id="language_tm2008"
															onchange="changeURL()"
															style="width: 90px; height: 23px; border: 1px solid #f60; color: #f60; vertical-align: middle;">
															<option value="0">时间</option>
															<option value="1">一天</option>
															<option value="3">三天</option>
															<option value="7">一周</option>
															<option value="21">三周</option>
															<option value="30">一个月</option>
															<option selected="selected" value="90">三个月</option>
														</select>
													</div> 
 													-->
												</td>
												<td width="188">作者</td>
												<td width="80">回复/阅读</td>
												<td width="118">操作</td>
											</tr>
											<c:forEach items="<%=list2 %>" var="list">
											<tr class="tr3">
												<td class="icon tac"><img
														title="总置顶" alt="总置顶"
														src="<%=basePath%>images/showlist/pin_3.gif"
														align="absMiddle" width="16px" height="16px"> </a></td>
												<td class="subject">
<%--														window.open("content/showDetail?postId="+postId+"&userId="+userId+"&area=<%=areaStr%>',"_blank");--%>
													<a class="f14"
													href="javascript:window.open('content/showDetail?postId=${list.postId }&userId=${list.userId }&area=${list.area }','_blank');" name="readlink">
														<font color="#888888"> <strong>${list.title }&nbsp;</strong></font>

													</a>&nbsp;
												<span class="imgs"> <img
														src="<%=basePath%>images/showlist/jing.gif" />
												</span> 
												<span class="gray tpage">
												</span> <span class="tps"> </span></td>
												<td class="author">
													<div class="aimg">
														
													</div> <a href="/user/space/2281/1/_1" title=${list.nickname }>${list.nickname }</a>
													<p>${list.postingTime }</p>
												</td>
												<td class="num"><em>${list.backcount }</em>/${list.readcount }</td>

												<td></td>

											</tr>
											</c:forEach>
											<tr>
												<td colspan="5"
													style="height: 30px; background: #f9f9f9; border-bottom: 1px dotted #dedede">
													&nbsp;&nbsp;&nbsp;版块主题</td>
											</tr>
											<c:forEach items="<%=list %>" var="list">
											<tr class="tr3 post" >
												<td class="icon tac"><a title="开放主题" href="javascript:void(0);"
													target="_blank"><img
														src="<%=basePath%>images/showlist/folder_new.gif"
														align="absMiddle" width="16px" height="16px" /></a></td>
												<td class="subject" id="td_1336173"><a
													href="javascript:void(0)" class="f14" id="a_ajax_1336173"
													name="readlink" target="_blank"> <font color="#666">${list.title }&nbsp;</font></a>

												<span class="imgs" style="display:none;"> <img
														src="<%=basePath%>images/showlist/jing.gif" />
												</span> 
												<span class="gray tpage"> 
													
												</span> <span class="tps">
												</span></td>
												<td class="author">
													 <a href="javascript:void(0);" title="${list.nickname }">${list.nickname }</a>
													<p>${list.postingTime }</p>
												</td>
												<td class="num"><em>${list.backcount }/ ${list.readcount }</em></td>
												<c:set var="userId" value="${list.userId }" scope="page"></c:set>
												<%if(user==null){
													
												}else{
													
													String[] strArray = user.getPmsArea().split(",");
													String flag = "false";
													String uid = (String)pageContext.getAttribute("userId");
													System.out.println(uid);
													if(user.getRoleId()==2){
														for(int i=0;i<strArray.length;i++){
															if(strArray[i].equals(areaStr)){	
																flag="true";%>
														<td class="td_opera1">
															<a href="javascript:void()" class="removePost">[删除]</a>
															<c:if test="${list.goodPost=='N' }">
															<a href="javascript:void(0);" class="addjing">  [加精]</a>
															</c:if>
															<c:if test="${list.goodPost=='Y' }">
															<a href="javascript:void(0);" class="canceljing">  [取消加精]</a>
															</c:if>
															
														</td>
												<% break; }	
														}
														if(flag.equals("false")){
															if(user.getUserId().equals(uid)){	%>
																<td class="td_opera1" >
																	<a href="javascript:void()" class="removePost">[删除]</a>						
																</td>	
															<% }
														}
													}else if(user.getRoleId()==3&&user.getUserId().equals(uid)){%>
												<td class="td_opera1">
													<a href="javascript:void()" class="removePost">[删除]</a>						
												</td>	
												<%	}
												} %>

												<td style="display:none;">
													<input type="text" value="${list.postId }" class="postId" style="display:none;">	<!-- 绑定帖子id -->
													<input type="text" value="${list.userId }" class="userId" style="display:none;">
													<input type="text" value="${list.goodPost }" class="goodPost" style="display:none;">
												</td>

											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="cc p10">

							<div class="fl" style="padding-top: 4px">
							<form action="" method="post" id="form11"></form>
								<div class="page">
								
								<span class="page_1" ><a href="javascript:doPost('content/getlist',{'area':'<%=areaStr %>','pageIndex':<%=tu.getPageNum()-1 %>},'_self')" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('content/getlist',{'area':'<%=areaStr %>','pageIndex':<%=tu.getPageNum()+1 %>},'_self')" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
									<input style="width: 30px" class="txt_page" id="txt_page1815393863" value="1" />&nbsp;
										<a class="go_btn" href="javascript:void(0)" onclick="jump()">Go>></a>
								
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%if(session.getAttribute("data")==null||session.getAttribute("data").equals("")){ %>
	<jsp:include page="nologin_bottom.jsp" flush="true"></jsp:include>
	<%}else{ %>
	<jsp:include page="theme_post.jsp" flush="true">
		<jsp:param value='<%=pageContext.getAttribute("curArea") %>'
			name="area" />
	</jsp:include>
	<%} %>

	<div class="back_top_bottom" style="display: none;">
		<img id="backtop" alt="返回顶部"
			src="<%=basePath%>images/showlist/backtop_01.png"
			style="margin-bottom: 15px;" />
		<img id="backbottom" alt="返回底部"
			src="<%=basePath%>images/showlist/backbottom_01.png" />
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

	<script type="text/javascript">
	function jump(){
		var index = $("#txt_page1815393863").val();
		var maxindex = <%=tu.getPages() %>;
		if(index>maxindex||index<1){
			alert("超出范围，无内容");
			return;
		}
		doPost('content/getlist',
					{'area':'<%=areaStr %>','pageIndex':index},'_self');
	}
	
	
	$(document).ready(function(){
		var curpage = <%=tu.getPageNum() %>;
		var maxpage = <%=tu.getPages() %>;
		
		if(curpage<=1){
			$("#pre1").attr('href', 'javascript:void(0)'); 
			$("#pre2").attr('href', 'javascript:void(0)'); 
		}else{
			$("#pre1").attr('href', 'javascript:doPost("content/getlist",{"area":<%=areaStr %>,"pageIndex":<%=tu.getPageNum()-1 %>},"_self")'); 
			$("#pre2").attr('href', 'javascript:doPost("content/getlist",{"area":<%=areaStr %>,"pageIndex":<%=tu.getPageNum()-1 %>},"_self")'); 
		}
		
		if(curpage>=maxpage){
			$("#next1").attr('href', 'javascript:void(0)'); 
			$("#next2").attr('href', 'javascript:void(0)'); 
		}else{
			$("#next1").attr('href', 'javascript:doPost("content/getlist",{"area":<%=areaStr %>,"pageIndex":<%=tu.getPageNum()+1 %>},"_self")'); 
			$("#next2").attr('href', 'javascript:doPost("content/getlist",{"area":<%=areaStr %>,"pageIndex":<%=tu.getPageNum()+1 %>},"_self")'); 
			
		}
		
		var areaStr = {"1":"我说潮州","2":"找男友","3":"找女友","4":"骑行交友","5":"摄影交友","6":"电影交友",
					"7":"以茶会友","8":"聚会party","9":"创业交流","10":"健身交流","11":"体育交流","12":"爱吃一族",
					"13":"爱车一族","14":"家有儿女","15":"家有宠物","16":"游记分享","17":"游戏讨论","18":"艺术园地",
					"19":"跳蚤市场","20":"新闻时事","21":"开心一刻","22":"灌水专区","30":"搜索页面"};
		var curNum = "<%=pageContext.getAttribute("curArea") %>";
		$("#bankuai").text(areaStr[curNum]);
		
		$(".post").each(function(){
			var postjing = $(this).find(".goodPost").val();
			if(postjing=="Y"){
				$(this).find(".imgs").css("display","block");
				console.log(postjing);
			}
		});
	})
	
	
	//帖子列表点击事件
		$(".post").click(function(){
			
			var postId = $(this).find(".postId").val();
			var userId = $(this).find(".userId").val();
			//console.log("postId:"+postId);
			//console.log("userId:"+userId);
			<%--doPost("content/showDetail",{"postId":postId,"userId":userId,"area":<%=areaStr%> },"_blank");--%>
			//换成get方法调用
			window.open('content/showDetail?postId='+postId+'&userId='+userId+'&area=<%=areaStr%>',"_blank");
		
		})

	//加精事件
	$(".addjing,.canceljing").click(function(event){
		 if (confirm("确认对该帖子加精/取消加精吗？")){ 
			 var postId = $(this).parent().next().find(".postId").val();
			 var userId = $(this).parent().next().find(".userId").val();
			 var goodPost = $(this).parent().next().find(".goodPost").val();
			 if(goodPost=="Y"){
				 goodPost = "N";
			 }else{
				 goodPost = "Y";
			 }
			 $.ajax({
					type:'post',
					url:'content/setGoodPost',
					dataType:'json',
					
					data:{"postId":postId,"goodPost":goodPost,"userId":userId},
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
	
	//删除帖子事件
	$(".removePost").click(function(event){
		 if (confirm("确认删除该帖子吗？")){ 
			 var postId = $(this).parent().next().find(".postId").val();
			 var userId = $(this).parent().next().find(".userId").val();
			 var goodPost = $(this).parent().next().find(".goodPost").val();

			 $.ajax({
					type:'post',
					url:'content/removePost',
					dataType:'json',
					
					data:{"postId":postId,"goodPost":goodPost,"userId":userId},
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
	$(document).ready(function(){
		var area = "<%=areaStr%>";
		$.ajax({
			type:'post',
			url:'content/getOwner',
			dataType:'json',
			
			data:{"area":area},
			success:function(result){
				var nickname ="";
				console.log(result);
				$.each(result.owner,function(index,item){
					
					var userId = result.owner[index].userId;
					var nn = result.owner[index].nickname;
					nickname = nickname+" "+nn;
					
				});
				$(".ownerName").text(nickname);
			},
			error:function(err){
				alert("错误");
			}
		});
	})
	
	</script>
	
	
</body>
</html>