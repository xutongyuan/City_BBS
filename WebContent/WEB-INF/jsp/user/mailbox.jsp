<%@page import="ssm.po.readonly.MessageRead"%>
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
	Page<MessageRead> tu = (Page<MessageRead>)request.getAttribute("MessageReads");
	List<MessageRead> list =	tu.getResult();
	
%>
<base href="<%=basePath%>">
<link href="css/tanchu.css" rel="stylesheet" type="text/css" />
 <script type="text/javascript" src="js/tanchu.js"></script>
    <script type="text/javascript">
       
        
        function showInfo(id) {
            tanchu_iframe("mailboxTC.jsp?messId=" + id, "好友留言", 730, 350);
        }
        function closeTC() {
            $("#tanchu_all").remove();
        }
    </script>

</head>
<body>
<jsp:include page="frame_left.jsp"></jsp:include>
 <div class="home_rig">
                    <div class="home_rig_li home_rig_current" id="tagContents7" name="站内信">
                        <div id="message">
                            <ul id="message_tags">
                                <li>
                                    <a href="user/postmessage">发送站内信</a>
                                </li>
                                <li>
                                    <a href="user/inbox">收件箱</a>
                                </li>
                                <li class="message_selectTag">
                                    <a href="javascript:void(0);">发件箱</a>
                                </li>
                                
                            </ul>
                            <div id="message_tagContent">
                                <div class="message_tagContent message_selectTag" id="message_tagContent2">
                                    <table>
                                        <tr align="center" valign="middle" class="tr_first-child">
                                            <td>
                                                状态
                                            </td>
                                            <td>
                                                收信人
                                            </td>
                                            <td style="width: 400px;">
                                                标题
                                            </td>
                                            <td>
                                                发送时间
                                            </td>
                                            <td>
                                                操作
                                            </td>
                                        </tr>
                                         <c:forEach items="<%=list %>" var="list">
                                        <tr align="center" valign="middle" style="font-weight: bold;">
                                            <td>
                                              <c:if test="${list.looked=='Y' }">
					                            	已阅
					                            </c:if>
					                            <c:if test="${list.looked=='N' }">
					                            	未读
					                            </c:if>
                                            </td>
                                            <td>
	                                              ${list.recevNickname }
                                            </td>
                                            <td style="width: 400px;">
                                                ${list.messTitle }
                                            </td>
                                            <td>
                                                ${list.time }
                                            </td>
                                            <td>
                                                <a href="javascript:void(0)" onclick="showInfo('${list.messId}')">查看</a>
                                                <font style="margin-left: 5px; margin-right: 5px; font-size: 12px;">/</font>
                                                <a href="javascript:void(0)" onclick="deleteInfo('${list.messId}')">删除</a>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </table>
                                    <div class="pages" style="padding-top: 4px; float: left;">
                                        <div class="page">
											<span class="page_1" ><a href="javascript:doPost('user/mailbox',{'pageIndex':<%=tu.getPageNum()-1 %>},'_self')" style="color:black;" id="pre2">&nbsp;&nbsp;上一页&nbsp;</a></span>
											<span class="page_1">&nbsp;&nbsp;当前页：<%=tu.getPageNum() %>/总页数：<%=tu.getPages() %>&nbsp;</span>
											<span class="page_1"><a href="javascript:doPost('user/mailbox',{'pageIndex':<%=tu.getPageNum()+1 %>},'_self')" style="color:black;" id="next2">&nbsp;&nbsp;下一页&nbsp;</a></span>
											<input style="width: 30px" class="txt_page" id="txt_page1815393863" value="1" />&nbsp;
											<a class="go_btn" href="javascript:void(0)" onclick="jump()">Go>></a>
										</div>   
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
 <script type="text/javascript">
 function deleteInfo(id) {
     if (confirm("你确定要删除该记录吗？")) {
     	$.ajax({
				type:'post',
				url:'user/removeinbox',
				dataType:'json',
				
				data:{'messId':id},
				success:function(result){
					console.log(result);
					if(result.res="success"){
						alert(result.mes);
						window.location.reload();
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