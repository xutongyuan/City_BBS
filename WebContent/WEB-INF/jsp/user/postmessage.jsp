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
<base href="<%=basePath%>">
<link href="css/tanchu.css" rel="stylesheet" type="text/css" />
</head>
<body>
<jsp:include page="frame_left.jsp"></jsp:include>

                <div class="home_rig">
                    <div class="home_rig_li home_rig_current" id="tagContents7" name="站内信">
                        <div id="message">
                            <ul id="message_tags">
                                <li class="message_selectTag">
                                    <a href="javascipt:void(0);">发送站内信</a>
                                </li>
                                <li>
                                    <a href="user/inbox">收件箱</a>
                                </li>
                                <li>
                                    <a href="user/mailbox">发件箱</a>
                                </li>
                              
                            </ul>
                            <div id="message_tagContent">
                                <div class="message_tagContent message_selectTag" id="message_tagContent0">
                                    <input type="hidden" id="hidden_id" value="00000000-0000-0000-0000-000000000000" />
                                    <input type="hidden" id="hidden_pid" value="00000000-0000-0000-0000-000000000000" />
                                    <span>
                                        <div class="msg01">
                                            收信人：
                                        </div>
                                        <input type="text" id="txt_sjrName" name="收件人" class="input_txt" readonly="readonly" style="width: 200px; margin-right: 10px;" value="" />
                                        <input type="hidden" id="hidden_sjrid" value="" />
                                        <a href="javascript:void(0)" style="color: #4b89dc; text-decoration: underline;" onclick="tanchu_iframe('selectuser.jsp','选择收信人',500,400)">选择</a>
                                    </span>
                                    <span>
                                        <div class="msg01">
                                            标题：
                                        </div>
                                        <input type="text" id="txt_title" name="标题" class="input_txt" style="width: 400px;" value="" />
                                    </span>
                                    <span>
                                        <div class="msg01">
                                            内容：
                                        </div>
                                        <textarea id="txt_content" style="width: 550px; height: 250px; font-size: 14px; padding: 5px; border: 1px solid #d7d7d7;"></textarea>
                                    </span>
                                  
                                    <span style="margin-top: 20px;">
                                        
                                        <div class="msg_btn" style="float:right;margin-right:200px">
                                            <a href="javascript:void(0)" onclick="saveInfo('1')" style="background: #8cc051;">发送</a>
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

<script type="text/javascript">
function selectInfo(id, name) {
    $("#hidden_sjrid").val(id);
    $("#txt_sjrName").val(name);
    $("#tanchu_all").remove();
}

function saveInfo(){
	var id = $("#hidden_sjrid").val();
	var title = $("#txt_title").val();
	var content = $("#txt_content").val();
	var json = {'recevmessId':id,'messTitle':title,'messContent':content};
	if(id.trim()==''){
		alert("请选择好友");
		return false;
	}else if(title.trim()==''||content.trim()==''){
		alert("标题或文本不能为空");
		return false;
	}
	$.ajax({
		type:'post',
		url:'user/submitMess',
		dataType:'json',
		
		data:json,
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
</script>
</body>
</html>