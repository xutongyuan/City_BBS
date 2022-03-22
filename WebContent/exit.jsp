<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


</head>
<body>
<%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
   + path + "/";
%>
	<%
	String path1 = (String)request.getParameter("path");
	session.invalidate();
	
	//清楚cookie
	Cookie cUserName = new Cookie("userName", "");
	cUserName.setMaxAge(0);
	cUserName.setPath("/");
	response.addCookie(cUserName);

	
	Cookie cPassWord = new Cookie("passWord", "");
	cPassWord.setMaxAge(0);
	cPassWord.setPath("/");
	response.addCookie(cPassWord);
	
	Cookie cAutoLogin = new Cookie("autoLogin","off");
	cAutoLogin.setMaxAge(0);
	cAutoLogin.setPath("/");
	response.addCookie(cAutoLogin);
	
	%> 
	<script type="text/javascript">
	
	function back(){
		if(document.referrer!="http://localhost:8080/City_BBS/content/showDetail"){
			window.location.href = document.referrer;
			
		}else{
			window.location.href = "index.jsp";
		}
		
	}
	back();
	</script>
	
</body>
</html>