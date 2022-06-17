<%@page import="java.util.List"%>
<%@page import="com.github.pagehelper.Page"%>
<%@page import="ssm.po.News"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Page<News> tu1 = (Page<News>)request.getAttribute("postListPage");
	List<News> list1 =	tu1.getResult();
	
	Page<News> tu2 = (Page<News>)request.getAttribute("recevListPage");
	List<News> list2 =	tu2.getResult();
%>
<base href="<%=basePath%>">
</head>
<title>潮州交友论坛-好友管理</title>
<body>
<jsp:include page="frame_left.jsp"></jsp:include>
<div class="home_rig">
                    <div class="home_rig_li home_rig_current" id="tagContents5" name="好友管理">
                        <div id="friend">
                           <ul id="friend_tags">
                                <li >
                                    <a href="user/findfriend">查找好友</a>
                                </li>
                                <li>
                                    <a href="user/friendmanager">管理好友</a>
                                </li>
                                <li class="friend_selectTag">
                                    <a href="javascript:void(0);">添加好友消息</a>
                                </li>
                            </ul>
                            <div id="friend_tagContent">
                                <div class="friend_tagContent friend_selectTag" id="friend_tagContent1">
                                    <ul>
                                        
                                        <c:forEach items="<%=list1 %>" var="list">
                                        <li>
                                            <div class="fr_images">
                                                <a href="javascript:doPost('user/otherUser',{'userId':'${list.recevId }'},'_blank');" ><img src="images/user/avatar/txjiajiren.gif" /></a></div>
                                            <span>
                                                <font style="font-size: 12px;">你向&nbsp;${list.recevNickname }&nbsp;  提出了好友请求</font>
                                            </span>
                                            <c:if test="${list.status==null }">
                                            	<span>
                                                <font style="font-size: 12px;">对方还没有回复你的请求</font>
                                           		</span>
                                            </c:if>
                                            <c:if test="${list.status=='Y' }">
                                            	<span>
                                                <font style="font-size: 12px;">对方同意了你的申请</font>
                                           		</span>
                                            </c:if>
                                            <c:if test="${list.status=='N' }">
                                            	<span>
                                                <font style="font-size: 12px;">对方拒绝了你的申请</font>
                                           		</span>
                                            </c:if>
                                            
                                            <span>
                                                <font style="font-size: 12px;">时间${list.time }</font>
                                                
                                                <c:if test="${list.status==null }">
                                                <a href="javascript:void(0)" class="cancel">取消</a>
                                                <input class="newsid" type="text" value="${list.id }" style="display:none;">
                                                </c:if>
                                            </span>
                                        </li>
                                        </c:forEach>
                                        
                                         <c:forEach items="<%=list2 %>" var="list">
                                        <li>
                                            <div class="fr_images">
                                                <a href="javascript:doPost('user/otherUser',{'userId':'${list.postId }'},'_blank');"><img src="images/user/avatar/txjiajiren.gif" /></a></div>
                                            <span>
                                                <font style="font-size: 12px;"> ${list.postNickname }&nbsp;  向你提出了好友请求</font>
                                            </span>
                                            <c:if test="${list.status==null }">
                                            	<span>
                                                <font style="font-size: 12px;">你还没回复对方的请求</font>
                                           		</span>
                                            </c:if>
                                            <c:if test="${list.status=='Y' }">
                                            	<span>
                                                <font style="font-size: 12px;">你同意了对方的好友申请</font>
                                           		</span>
                                            </c:if>
                                            <c:if test="${list.status=='N' }">
                                            	<span>
                                                <font style="font-size: 12px;">你拒绝了对方的好友申请</font>
                                           		</span>
                                            </c:if>
                                            
                                            <span>
                                                <font style="font-size: 12px;">${list.time }</font>
                                                <c:if test="${list.status==null }">
                                               
                                                <a href="javascript:void(0)" class="reject">拒绝  </a>
                                                 <a href="javascript:void(0)" class="agree">同意&nbsp;&nbsp; </a>
                                                 <input type="text" value="${list.id }" style="display:none;">
                                                </c:if>
                                            </span>
                                        </li>
                                        </c:forEach>
                                       
                                        
                                    </ul>
                                    <div class="pages" style="padding-top: 4px; float: left;">    
	                                	 <div class="page">
											<span class="page_1" ><a href="javascript:doPost('user/friendaddmes',{'pageIndex':<%=tu1.getPageNum()-1 %>},'_self')" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
											<span class="page_1">&nbsp;&nbsp;当前页：<%=tu1.getPageNum() %>/总页数：<%=tu1.getPages() %>&nbsp;</span>
											<span class="page_1"><a href="javascript:doPost('user/friendaddmes',{'pageIndex':<%=tu1.getPageNum()+1 %>},'_self')" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
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
            <div class="blank8">
            </div>
            <div class="user_bottom">
<%--             	版权by:五邑大学 160810班 许桐源 &nbsp;仅用于毕业设计--%>
    粤ICP备2022047901
                <br>
            </div>
        </div>
    </div>

<script>
	function ajaxModel(to,params){
		$.ajax({
			type:'post',
			url:to,
			dataType:'json',
			
			data:params,
			success:function(result){
				if(result.res="success"){
					alert(result.mes);
					window.location.reload();
				}else{
					alert(result.mes);
				}
			},
			error:function(err){
				alert("错误");
			}
		}); 
	}
	$(".cancel").click(function(){
		if(!confirm("确认取消该申请吗？")){
			return false;
		}
		var id = $(this).next().val();
		var params = {'id':id};
		ajaxModel("user/cancelNews",params);	
	});
	$(".agree").click(function(){
		var id = $(this).next().val();
		var params = {'id':id};
		ajaxModel("user/agreeNews",params);	
	});
	
	$(".reject").click(function(){
		var id = $(this).next().next().val();
		var params = {'id':id};
		ajaxModel("user/rejectNews",params);	
	});
	
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
	
</script>

</body>
</html>