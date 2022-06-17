<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>潮州交友论坛-注册</title>
<%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
   + path + "/";
%>
	<base href="<%=basePath%>">
<link href="css/register.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery-3.1.1.js"></script>
<script type="text/javascript" src="js/register/md5.js"></script>
</head>
<body class="loginbody">
<div class="dataEye">
	<div class="loginbox registbox">
		<div class="logo-a">
			<a href="login.jsp" title="潮州论坛">
				<img src="<%=basePath%>images/home/topczlt.gif" style="width: 300px;">
			</a>
		</div>
		
		<div class="login-content reg-content">
			<div class="loginbox-title">
				<h3>注册</h3>
			</div>
			
			<div class="login-error">
				<p></p>
			</div>
			<div class="row">
				
				<input type="text" value="" class="input-text-user noPic input-click" name="email" id="email" placeholder="注册邮箱">
			</div>
			<div class="row">
				
				<input type="password" value="" class="input-text-password noPic input-click" name="password" id="password" placeholder="密码">
			</div>
			<div class="row">
				
				<input type="password" value="" class="input-text-password noPic input-click" name="passwordagain" id="passwordAgain" placeholder="再次输入密码">
			</div>
			<div class="row">
				
				<input type="text" value="" class="input-text-user noPic input-click" name="nickname" id="nickname" placeholder="昵称">
			</div>
			<div class="row">
				
				<input type="text" value="" class="input-text-user noPic input-click" name="phone" id="phone" placeholder="电话">
			</div>
			
			<div class="row">
				<label class="" for="tel">区/县：</label>
				<select name="county" id="sel">
				  <option value="潮安区">潮安区</option>
				  <option value="枫溪区">枫溪区</option>
				  <option value="湘桥区">湘桥区</option>
				  <option value="饶平区">饶平县</option>
				</select>			
			</div>
			<div class="row tips">
				<input type="checkbox" id="checkBox">
				<label>
				我已阅读并同意
				<a href="#" target="_blank">隐私政策、服务条款</a>
				</label>
			</div>
			<div class="row btnArea">
				<input class="login-btn"  type="button" value="注册" onclick="submit()">
			</div>
		
		</div>
		<div class="go-regist">
			已有帐号,请<a href="#" class="link">登录</a>
		</div>
	</div>
	
	<div id="footer">
		<div class="dblock">
			<div class="inline-block"><img src="<%=basePath%>images/home/topczlt.gif"></div>
			<div class="inline-block copyright">
				<p><a href="#">关于我们</a> | <a href="http://www.weiaj.com">微博</a> | <a href="#">隐私政策</a> | <a href="#">人员招聘</a></p>
<%--				<p> Copyright © 2018 XTY毕设</p>--%>
				<p> 粤ICP备2022047901</p>
			</div>
		</div>
	</div>
	</div>

	<script type="text/javascript"> 
		
		var fChkMail=function(szMail){ 
			var szReg= /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/g; 
			var bChk=szReg.test(szMail); 
			return bChk; 
		} 
		
		var err_div = $(".login-error");
		var err_text = $(".login-error p");
		
		var emailtype = function(){
			var flag = fChkMail($("#email").val());
			if(!flag){
				err_text.text("*email格式有误") ;
				err_div.css("display","block");	
				return false;
			}else{
				return true;
			}
		};
		$("#email").blur(function(){
			if(!emailtype()){
				return false;
			}else{
				avilemail();
				return true;
			}
		})
		
		function avilemail(){
			var email = $("#email").val();
			if(email.trim()==''){
				err_text.text("邮箱地址不能为空") ;
				err_div.css("display","block");
				return false;
			}else if(!emailtype()){
				alert("邮箱格式错误");
				return false;
			}
			$.ajax({
				type:'post',
				url:'user/avilemail',
				dataType:'json',
				
				data:{'email':$("#email").val()},
				success:function(result){
					if(result.res=="success"){
						err_div.css("display","none");
					}else{
						err_text.text("*该邮箱账号已存在，请重新填写") ;
						err_div.css("display","block");
					}
				}
			});
			return true;
		}
		
		$("#password").blur(function(){
			if($("#password").val().length<6){
				err_text.text("密码长度必须大于6位");
				err_div.css("display","block");
				return;
			}
			else{
				err_div.css("display","none");
			}
		})
		
		$("#passwordAgain").blur(function(){
			if($("#passwordAgain").val()!=$("#password").val()){
				err_text.text("两次输入的密码不相同");
				err_div.css("display","block");
				return;
			}else{
				err_div.css("display","none");
			}
		})
		$("#nickname").blur(function(){
			if($("#nickname").val()==""||$("#nickname").val().trim()==""){
				console.log($("#nickname").val().length);
				err_text.text("昵称不能为空");
				err_div.css("display","block");
				return;
			}else{
				err_div.css("display","none");
			}
		})
		
		function submit(){
			var email = $("#email").val();
			var password= $("#password").val();
			var passwordAgain= $("#passwordAgain").val();
			var nickname = $("#nickname").val();
			var phone = $("#phone").val();
			var county = $("#sel").val();
			var formdata = {"email":email,"password":password,"nickname":nickname,"phone":phone,"county":county}
			
			avilemail();
			
			if(!$("#checkBox").prop("checked")){
				err_text.text("请阅读并同意协议");
				err_div.css("display","block");
				return;
			}
			if(email.trim()==''||password.trim()==''||nickname.trim()==''||county.trim()==''||phone.trim()==''){
				alert("注册失败，请填写完整信息")
				return false;
			}
			if(password!=passwordAgain){
				alert("两次密码不同")
				return false;
			}
			
			if(err_div.css("display")=="block"){
				return;
			}
			

			$.ajax({
				type:'post',
				url:'user/register',
				dataType:'json',
				
				data:formdata,
				success:function(result){
					if(result){
						alert("成功注册，点击返回首页");
						window.location.href="index.jsp";
							
						}else{
							alert("注册失败，请重试");
						}
					}
				});
			
		}
		
		
	</script> 

</body>
</html>