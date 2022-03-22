<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		%>
		
		<base href="<%=basePath%>">
		<script type="text/javascript" src="js/jquery-3.1.1.js"></script>
		<link rel="stylesheet" href="css/top.css" />
		<link rel="stylesheet" href="css/head.css" />
		<link rel="stylesheet" href="css/focus.css" />
		<link rel="stylesheet" type="text/css" href="css/tc_login.css" />
		
		<% 
		//自动登录
		String userName="";
		String passWord="";
		String autoLogin="";
		if(session.getAttribute("data")==null||session.getAttribute("data").equals("")){
			Cookie[] cookie = request.getCookies();
			if(cookie!=null){
				for(int i = 0; i<cookie.length; i++){
					if(cookie[i].getName().equals("userName")) {
						userName = cookie[i].getValue();
					}else if(cookie[i].getName().equals("passWord")){
						passWord = cookie[i].getValue();
					}else if(cookie[i].getName().equals("autoLogin")){
						autoLogin = cookie[i].getValue();
					}
				}
			}
			if(autoLogin.equals("on")&&!userName.equals("")){	
				request.getRequestDispatcher("user/autoLogin?email="+userName+"&password="
						+passWord).include(request, response);
				//有两个servlet同时运行必须使用include
			}
		}
		%>
</head>
<body>

	
	<div class="topall">
			<div id="topalls_div" class="topalls">
				<a href="index.jsp" title="中国潮州首页"><img id="top01" src="<%=basePath%>images/home/topczlt1.gif" alt="中国潮州首页" /></a>
				<a href="index.jsp" class="a_first headcurrent" style="margin-top:5px">论坛首页</a>
				<!-- 
				 <a href="javascript:void(0);" id="weixin_button" class="a_first" style="margin-top:5px">精华帖</a>
				 -->
				<a href="register.jsp" class="nologin1" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; _padding-top: 5px; float: right;">注册</a>
				<a class="login_button nologin1" onclick="login()" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; cursor:pointer; _padding-top: 5px; float: right;">登录</a>
				
				<a href="exit.jsp" class="logined" onclick="loginOut()" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; cursor:pointer; _padding-top: 5px; float: right; display:none">退出</a>
				<a href="user/userinfo" class="logined" id="user" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; _padding-top: 5px; float: right; display:none;">${sessionScope.data.email }</a>
			</div>
	</div>
	<div class="home">
			<div class="login_content">
				<div class="login_contents" id="pc_box" style="">
					
					<div class="blank20">
						<a href="javascript:close();"><img src="<%=basePath%>images/home/close.png" ></a>
					</div>
					<div class="inputs">
						<div class="navtitle">
							<img src="<%=basePath%>images/home/logo.gif" width="25" style="vertical-align: middle">&nbsp;<strong>账号登录</strong>
						</div>
					</div>
					<div class="inputs">
						<div class="writeerror" id="writeerror" style="display: none;">
							帐号或密码错误，你还可以尝试 2 次
						</div>
						<div class="yhm">
							<input id="userCode" type="text" value="<%=userName %>" placeholder="账号或邮箱" style="width: 392px; height: 48px; line-height: 48px; padding-left: 10px; color: #999" >
						</div>
						<div class="mima">
							<input type="password" id="txt_password" value="<%=passWord %>" placeholder="密码" style="width: 392px; height: 48px; line-height: 48px; padding-left: 10px; color: #999" >
							
						</div>
						<div class="zddl">
							<a href="javascript:openZhmm();" title="找回密码" style="float: right;">忘记密码？</a>
							<input id="remepwd" type="checkbox"> 记住密码 <input id="autologin" type="checkbox"> 下次自动登录
						</div>
						<div class="login" id="login_">
							登 录</div>
					</div>
					<div class="inputs">
						还不是中国潮州用户？&nbsp;|&nbsp;
						<a href="register.jsp" target="_blank">免费注册</a>
					</div>
				</div>

				<!-- 申诉账号获取 -->
				<div class="login_contents" id="pc_box1" style="display:none;">
					
					<div class="blank20">
						<a href="javascript:close();"><img src="<%=basePath%>images/home/close.png" ></a>
					</div>
					<div class="inputs">
						<div class="navtitle">
							<img src="<%=basePath%>images/home/logo.gif" width="25" style="vertical-align: middle">&nbsp;<strong>密码申诉</strong>
						</div>
					</div>
					<div class="inputs">
						
						<div class="question">
							<strong style="height:30px;line-height:30px;">请输入要申诉的用户名：</strong>
							<input  type="text" id="checkUserName" value=""  style="width: 392px; height: 30px; line-height: 30px; padding-left: 10px; color: #999" >
						</div>
						
						
						<div class="login" onclick="postCheck()">
							提交</div>
					</div>
				</div>
				<!-- 回答申诉问题 -->
				<div class="login_contents" id="pc_box2" style="display:none;">
					
					<div class="blank20">
						<a href="javascript:close();"><img src="<%=basePath%>images/home/close.png" ></a>
					</div>
					<div class="inputs">
						<div class="navtitle">
							<img src="<%=basePath%>images/home/logo.gif" width="25" style="vertical-align: middle">&nbsp;<strong>密码申诉</strong>
						</div>
					</div>
					<div class="inputs">
						<div style="height:15px;">
							<p style="height:30px;line-height:30px;color:red " id="tip"></p>
							
						</div>
						<div class="question">
							<strong style="height:30px;line-height:30px; " id="quest1">问题1：</strong>
							<input  type="text" id="answer1" value=""  style="width: 392px; height: 30px; line-height: 30px; padding-left: 10px; color: #999" >
						</div>
						<div class="question">
							<strong style="height:30px;line-height:30px;" id="quest2">问题2：</strong>
							<input type="text" id="answer2" value=""  style="width: 392px; height: 30px; line-height: 30px; padding-left: 10px; color: #999" >
							
						</div>
						
						<div class="login" onclick="postQuest()">
							验证</div>
					</div>
				</div>
				
				<!-- 修改密码 -->
				<div class="login_contents" id="pc_box3" style="display:none;">
					
					<div class="blank20">
						<a href="javascript:close();"><img src="<%=basePath%>images/home/close.png" ></a>
					</div>
					<div class="inputs">
						<div class="navtitle">
							<img src="<%=basePath%>images/home/logo.gif" width="25" style="vertical-align: middle">&nbsp;<strong>修改密码</strong>
						</div>
					</div>
					<div class="inputs">
						
						<div class="question">
							<strong style="height:30px;line-height:30px;">新密码：</strong>
							<input  type="password" id="newPass1" value=""  style="width: 392px; height: 30px; line-height: 30px; padding-left: 10px; color: #999" >
						</div>
						<div class="question">
							<strong style="height:30px;line-height:30px;">再次确认密码：</strong>
							<input type="password" id="newPass2" value=""  style="width: 392px; height: 30px; line-height: 30px; padding-left: 10px; color: #999" >
							
						</div>
						
						<div class="login" onclick="postMima()">
							确认修改</div>
					</div>
				</div>
			
		</div>
		</div>
		<style>
		.question{
			width:90%;
			height:80px;
			float:left;
			background-color:#fff;
		}
		</style>
		<script>
		function login() {
			$(".home").show();
		};
		function close(){
			$("#pc_box").css("display","block");
			$("#pc_box1").css("display","none");
			$("#pc_box2").css("display","none");
			$("#pc_box3").css("display","none");
			$(".home").hide();
		};
		<!--登录文本改变-->
		var loginUp = function(){
			$(".nologin1").css("display","none");
			$(".logined").css("display","block");
		};
		<!--退出文本改变-->
		var loginOut = function(){
			$(".nologin1").css("display","block");
			$(".logined").css("display","none");
		};
		
		<!--登录js-->
		$("#login_").click(function(){
			var email = $("#userCode").val();
			var password = $("#txt_password").val();
			var addCookie = 'false';
			var autoLogin = 'false';
			if($("#remepwd").prop("checked")){
				addCookie = 'true';
			}
			if($("#autologin").prop("checked")){
				autoLogin = 'true';
			}
			if(email==""||password==""){
				alert("账号或密码不能为空");
				return false;
			}
			loginAjax(email,password,addCookie,autoLogin);
		});	
		//ajax登录
		function loginAjax(email,password,addCookie,autoLogin){
			$.ajax({
				type:'post',
				url:'user/login',
				dataType:'json',
				
				data:{"email":email,"password":password,"addCookie":addCookie,"autoLogin":autoLogin},
				success:function(result){
					$.each(result, function(index, item) {
						if(item=='true'){
							console.log("成功");
							$("#writeerror").text("登录成功!");
							$("#writeerror").css("background-color","green");
							$("#writeerror").css("color","white");
							$("#writeerror").css("display","block");
							
							setTimeout(function(){
								document.location.reload();},1000);
							//1秒重载当前页面 
							
						}else{
							$("#writeerror").css("display","block");
						}
				});
				},
				error:function(err){
					alert("错误");
				}
			});
		}
		
		
		<!--判断页面是否已登录-->
		$(document).ready(function(){
			function isLogin(){
				var user = "${sessionScope.data.email}";	//js直接写在页面中可以使用el表达式
				console.log(user);
				if(user!=''){
					loginUp();
				}else{
					loginOut();
				}
			};
			isLogin();
		})
		
		//1.忘记密码
		function openZhmm(){
			$("#pc_box").css("display","none");
			$("#pc_box1").css("display","block");
		
		}
		//2.校验申诉用户信息
		function postCheck(){
			var email = $("#checkUserName").val();
			if(email==""){
				alert("用户信息不能为空");
				return false;
			}
			$.ajax({
				type:'post',
				url:'user/checkPassSecurity',
				dataType:'json',
				
				data:{"email":email},
				success:function(result){
					$.each(result, function(index, item) {
						if(index=="status"){
							if(result[index]=="success"){
								
							}else if(result[index]=="fail"){
								alert("账户名不存在");
								return;
							}else if(result[index]=="result is null"){
								alert("该用户未设置密保，不能通过改途径修改密码");
								return;
							}
						}
						if(index=="quest1"){
							$("#quest1").text("问题1："+result[index]);
						}
						if(index=="quest2"){
							$("#quest2").text("问题2："+result[index]);
							$("#tip").text("tip:用户 "+email+" 的申诉");
							
							$("#pc_box1").css("display","none");
							$("#pc_box2").css("display","block");
						}
				});
				},
				error:function(err){
					alert("错误");
				}
			});
		}
		//3.提交密保问题
		function postQuest(){
			var answer1 = $("#answer1").val();
			var answer2 = $("#answer2").val();
			if(answer1==""||answer2==""){
				alert("密保问题不能为空");
				return false;
			}
			$.ajax({
				type:'post',
				url:'user/postPassSecurity',
				dataType:'json',
				
				data:{"answer1":answer1,"answer2":answer2},
				success:function(result){
					$.each(result, function(index, item) {
						if(item=="success"){
							$("#pc_box2").css("display","none");
							$("#pc_box3").css("display","block");
						}else{
							alert("密保问题回答错误，请重新填写");
						}	
				});
				},
				error:function(err){
					alert("错误");
				}
			});
		}
		
		//4.提交修改密码
		function postMima(){
			var newPass1 = $("#newPass1").val();
			var newPass2 = $("#newPass2").val();
			if(newPass1==""||newPass2==""){
				alert("文本框不能为空");
				return false;
			}else if(newPass1!=newPass2){
				alert("两次输入的密码不同，请重新填写");
				return false;
			}
			$.ajax({
				type:'post',
				url:'user/postNewPass',
				dataType:'json',
				
				data:{"password":newPass1},
				success:function(result){
					$.each(result, function(index, item) {
						if(item=="success"){
							alert("密码修改成功，请开始登陆");
							close();
						}else{
							alert("密码更改失败");
						}	
				});
				},
				error:function(err){
					alert("错误");
				}
			});
		}
		
		function search(){
			var keyword = $("#txt_keyword").val();
			if(keyword==""||keyword.trim()==""){
				alert("关键词不能为空");
				return false;
			}
			//函数写在showList_Search
			doPost("content/getlistBysearch",{"keyword":keyword},"_self");
			
		}
		</script>
		
		
</body>
</html>