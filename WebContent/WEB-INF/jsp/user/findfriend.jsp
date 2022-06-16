<%@page import="java.util.ArrayList"%>
<%@page import="ssm.po.Users"%>
<%@page import="java.util.List"%>
<%@page import="ssm.po.Userdetail"%>
<%@page import="com.github.pagehelper.Page"%>
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
	Users user = (Users)session.getAttribute("data");
	Page<Userdetail> tu = (Page<Userdetail>)request.getAttribute("userdetailPage");
	List<Userdetail> list = new ArrayList<>();
	if(tu!=null){
		 list =	tu.getResult();
	}
	
%>
</head>
<body>
<jsp:include page="frame_left.jsp"></jsp:include>
<div class="home_rig">
                    <div class="home_rig_li home_rig_current" id="tagContents5" name="好友管理">
                        <div id="friend">
                            <ul id="friend_tags">
                                <li class="friend_selectTag">
                                    <a href="javascript:void(0);">查找好友</a>
                                </li>
                                <li>
                                    <a href="user/friendmanager">管理好友</a>
                                </li>
                                <li>
                                    <a href="user/friendaddmes">添加好友消息</a>
                                </li>
                            </ul>
                            <div id="friend_tagContent">
                                <div class="friend_tagContent friend_selectTag" id="friend_tagContent0">
                                    <table width="0" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                                        <tr>
                                            <td align="left" class="tag02">
                                                <input id="input_keyword" type="text" style="float: left; width: 250px;" class="input_txt" value="" />
                                                <div onclick="find_click()" class="home_btn01">
                                                    查找</div>
                                                <span id="lbl_info" style="width: 100%; color: Red; display: none; float: left;">
                                                    *不能为空*</span>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="friend_tagContent friend_selectTag" id="friend_tagContent1">
                                        <c:forEach items="<%=list %>" var="list">
                                        <ul>
                                            <li>
                                                <div class="fr_images">
                                                    <img src="${list.image }"></div>
                                                <span>
                                                    <a href="javascript:doPost('user/otherUser',{'userId':'${list.userId }'},'_blank');" target="_blank">ta的空间</a>
                                                    <font style="font-size: 12px;" title="${list.nickname }">昵称：${list.nickname }</font>
                                                </span>
                                                <span>
                                                    <a  href="javascript:addFriendInfo('<%=user.getUserId() %>','${list.nickname }','${list.userId }')">添加好友</a>
                                                    <font style="font-size: 12px;" title=""></font>
                                                </span>
                                            </li>
                                           </c:forEach> 
                                        </ul>            
                                     <div class="pages" style="padding-top: 4px; float: left;">    
	                                	 <div class="page">
											<span class="page_1" ><a href="javascript:doPost('user/friendaddmes',{'pageIndex':<%=tu.getPageNum()-1 %>},'_self')" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
											<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
											<span class="page_1"><a href="javascript:doPost('user/friendaddmes',{'pageIndex':<%=tu.getPageNum()+1 %>},'_self')" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
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
	function find_click(){
		var txt = $("#input_keyword").val();
		if(txt==''){
			$("#lbl_info").css("display","block");
			return false;
		}else{
			$("#lbl_info").css("display","none");
		}
		doPost("user/findfriend",{'nickname':txt},"_self");
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
	function addFriendInfo(postId,recevNickname,recevId) {

        var json = {'postId':postId,'recevNickname':recevNickname,'recevId':recevId};
        if(recevId==postId){
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
    }
	</script>

</body>
</html>