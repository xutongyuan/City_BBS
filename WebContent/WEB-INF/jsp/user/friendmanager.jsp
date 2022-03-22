<%@page import="java.util.List"%>
<%@page import="com.github.pagehelper.Page"%>
<%@page import="ssm.po.Userdetail"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	Page<Userdetail> tu = (Page<Userdetail>)request.getAttribute("userdetailPage");
	List<Userdetail> list =	tu.getResult();
	
%>
<base href="<%=basePath%>">
</head>
<body>
<jsp:include page="frame_left.jsp"></jsp:include>
<div class="home_rig">
                    <div class="home_rig_li home_rig_current" id="tagContents5" name="好友管理">
                        <div id="friend">
                            <ul id="friend_tags">
                                <li>
                                    <a href="user/findfriend">查找好友</a>
                                </li>
                                <li class="friend_selectTag">
                                    <a href="javascript:void(0);">管理好友</a>
                                </li>
                                <li>
                                    <a href="user/friendaddmes">添加好友消息</a>
                                </li>
                            </ul>
                            <div id="friend_tagContent">
                                <div class="friend_tagContent friend_selectTag" id="friend_tagContent1">
                                    <ul>
                                         <c:forEach items="<%=list %>" var="list">
                                        <li>
                                            <div class="fr_images">
                                                <img src="${list.image }" /></div>
                                            <span>
                                                <a href="javascript:doPost('user/otherUser',{'userId':'${list.userId }'},'_blank');" >ta的空间</a>
                                                <font style="font-size: 12px;" title="和风细雨">昵称：${list.nickname }</font>
                                            </span>
                                            <span>
                                                <a onclick="deleteFriend('${list.userId}')" href="javascript:void(0)">解除好友</a>
                                            </span>
                                        </li>
                                        </c:forEach>
                                    </ul>
                                    
                                   <div class="page">
									<span class="page_1" ><a href="javascript:doPost('user/friendmanager',{'pageIndex':<%=tu.getPageNum()-1 %>},'_self')" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
									<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
									<span class="page_1"><a href="javascript:doPost('user/friendmanager',{'pageIndex':<%=tu.getPageNum()+1 %>},'_self')" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
									<input style="width: 30px" class="txt_page" id="txt_page1815393863" value="1" />&nbsp;
									<a class="go_btn" href="javascript:void(0)" onclick="jump()">Go>></a>								
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
               
                <br>
            </div>
        </div>
    </div>
	<script type="text/javascript">
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
	function deleteFriend(userId){
		if(confirm("确认接触该好友关系吗？")){
			$.ajax({
				type:'post',
				url:'user/deleteFriend',
				dataType:'json',
				
				data:{"userId":userId},
				success:function(result){
					if(result.res=='success'){
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
		}else{
			
		}
		
	}
	</script>


</body>
</html>