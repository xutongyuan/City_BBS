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
	List<Userdetail> friend = (List<Userdetail>)session.getAttribute("friendSession");
%>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>收件人</title>
    <link href="css/user/home.css" type="text/css" rel="stylesheet" />
    <style type="text/css">
        .sjr_span
        {
            width: 490px;
            height: auto;
            float: left;
            padding: 5px;
        }
        .sjr_span a.sjr_a
        {
            width: 100px;
            height: 28px;
            line-height: 28px;
            float: left;
            border: 1px dotted #d7d7d7;
            background: #fff;
            text-align: center;
            margin: 5px;
            padding: 0 5px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .sjr_span a.sjr_a:hover
        {
            background: #4b89dc;
            border: 1px dotted #4b89dc;
            color: #fff;
        }
    </style>
    <script type="text/javascript">
        function selectInfo(id, name) {
            window.parent.selectInfo(id, name);
        }
    </script>
    
</head>
<body style="background: #fff;">
    <div class="sjr_span">
         <c:forEach items="<%=friend %>" var="list">
        <a href="javascript:void(0)" onclick="selectInfo('${list.userId }','${list.nickname }')" class="sjr_a">${list.nickname }</a>
        
       
        </c:forEach>
    </div>


</body>
</html>