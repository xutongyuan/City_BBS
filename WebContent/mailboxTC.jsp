<%@page import="java.util.List"%>
<%@page import="ssm.po.Userdetail"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<base href="<%=basePath%>">
<script type="text/javascript" src="js/jquery-3.1.1.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>弹出-网友留言</title>
    <link href="css/user/home.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .login_contents1
        {
            width: 698px;
            height: 468px;
            float: left;
            background: #fff;
            padding: 15px;
            border: 1px solid #fff;
        }
    </style>
    
</head>
<body>
    <div class="login_content1">
        <div class="login_contents1">
            <div class="wy_tip">
          	      留言标题：
            </div>
            <div class="wy_name">
                <img src="images/tanchu/home09.gif" />网友昵称：</div>
            <div class="wy_date">
                <img src="images/tanchu/home02.gif" />留言时间：<font></font></div>
            <div class="wy_content">
                <div class="wy_con_name">
                    <img src="images/tanchu/home13.gif" />留言内容：</div>
                <div class="wy_con_con">
                </div>
            </div>
        </div>
    </div>
<%String str =  request.getParameter("messId"); %>
<script type="text/javascript">

	var str = "<%=str%>";
	console.log(str);
	$.ajax({
		type:'post',
		url:'user/mailboxTC',
		dataType:'json',
		
		data:{'messId':str},
		success:function(result){
			console.log(result);
			$(".wy_tip").append(result.messTitle);
			$(".wy_name").append(result.recevNickname);
			$(".wy_date").append(result.time);
			$(".wy_con_con").append(result.messContent);
			
		},
		error:function(err){
			alert("错误");
		}
	});

</script>


</body>
</html>