<%@page import="ssm.po.readonly.UsersInfo"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
		String path = request.getContextPath();
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% 
                 UsersInfo usersInfo = (UsersInfo)request.getSession().getAttribute("usersInfo");%>		
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link href="css/user/home.css" type="text/css" rel="stylesheet" />
    <link href="css/user/tag.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-3.1.1.js"></script>
    <script src="js/ajaxfileupload.js" type="text/javascript"></script>

</head>
<title>潮州交友论坛-个人中心</title>
<body>
    
    <div class="all">
        <input id="userId" type="hidden" value="42175" />
        <!--top 固定位置 str-->
        <script type="text/javascript">
            $(document).ready(function () {
            	 
               	var sex = "${usersInfo.sex }";
               	var county= "${usersInfo.county }";
               	if(sex=="男"){
               		$("#male").attr("checked","checked");
               	}else{
               		$("#female").attr("checked","checked");
               	}
               	if(county=="潮安区"){
               	  $("option:nth-of-type(1)").attr("selected","");
               	}else if(county == "枫溪区"){
               	 $("option:nth-of-type(2)").attr("selected","");
               	}else if(county == "湘桥区"){
               	 $("option:nth-of-type(3)").attr("selected","");
               	}else {
               	 $("option:nth-of-type(4)").attr("selected","");
               	}
              
              
               	
                $("#touxiang_tagContent0 .img_text").each(function () {
                    $(this).click(function () {
                        $("#tx_change").attr("src", $(this).attr("src"));
                        $(".xttx_img").removeClass("xttx_current");
                        var parents = $(this).parent();
                        parents.addClass("xttx_current");
                    });
                });

                $("#touxiang_tagContent2 .img_text").each(function () {
                    $(this).click(function () {
                        $("#Img2").attr("src", $(this).attr("src"));
                        $(".xttx_img").removeClass("xttx_current");
                        var parents = $(this).parent();
                        parents.addClass("xttx_current");
                    });
                });

                $("#touxiang_tagContent3 .img_text").each(function () {
                    $(this).click(function () {
                        $("#tx_change").attr("src", $(this).attr("src"));
                        $(".xttx_img").removeClass("xttx_current");
                        var parents = $(this).parent();
                        parents.addClass("xttx_current");
                    });
                });

            });

            function touxiang_selectTag(touxiang_showContent, touxiang_selfObj) {
                // 操作标签
                var touxiang_tag = document.getElementById("touxiang_tags").getElementsByTagName("li");
                var touxiang_taglength = touxiang_tag.length;
                for (i = 0; i < touxiang_taglength; i++) {
                    touxiang_tag[i].className = "";
                }
                touxiang_selfObj.parentNode.className = "touxiang_selectTag";
                // 操作内容
                for (i = 0; j = document.getElementById("touxiang_tagContent" + i); i++) {
                    j.style.display = "none";
                }
                document.getElementById(touxiang_showContent).style.display = "block";

                if (touxiang_showContent == "touxiang_tagContent1" || touxiang_showContent == "touxiang_tagContent2") {
                    $("#def_div").hide();
                    $("#upload_div").show();
                } else {
                    $("#def_div").show();
                    $("#upload_div").hide();
                }
            }

           
            	
          //保存用户头像	
        function UpdateUserFace() {
          var imgsrc = $("#tx_change").attr("src");
          var params = {"imgSrc":imgsrc};
          ajaxModel("user/modifyAvator",params); 
        }
    
            //功能选择
     	$(document).ready(function(){
     		 $("#home_lef div").click(function(){
            	var text = $(this).children("a").text();
				switch(text){
					case "修改头像": 
						console.log("修改资料"); 
						$(".home_rig:nth-of-type(1)").css("display","block");
						$(".home_rig:nth-of-type(1)").nextAll().css("display","none");
						$(".home_rig:nth-of-type(1)").prevAll().css("display","none");
						break;
					case "个人资料":
						$(".home_rig:nth-of-type(2)").css("display","block");
						$(".home_rig:nth-of-type(2)").nextAll().css("display","none");
						$(".home_rig:nth-of-type(2)").prevAll().css("display","none");
						; break;
					case "修改密码":
						$(".home_rig:nth-of-type(3)").css("display","block");
						$(".home_rig:nth-of-type(3)").nextAll().css("display","none");
						$(".home_rig:nth-of-type(3)").prevAll().css("display","none");
						break;
					case "密码保护":
						$(".home_rig:nth-of-type(4)").css("display","block");
						$(".home_rig:nth-of-type(4)").nextAll().css("display","none");
						$(".home_rig:nth-of-type(4)").prevAll().css("display","none");
						break;
					case "积分":
						$(".home_rig:nth-of-type(5)").css("display","block");
						$(".home_rig:nth-of-type(5)").nextAll().css("display","none");
						$(".home_rig:nth-of-type(5)").prevAll().css("display","none");
						break;
				}
            })
            
            loginUp();
     	});
     	
            //通用ajax调用接口
          function ajaxModel(action,json){
        	  $.ajax({
    				type:'post',
    				url:action,
    				dataType:'json',
    				
    				data:json,
    				success:function(result){
    					$.each(result,function(index,item){
   						alert(item);
   						if(item=="修改成功,请重新登录"){
       						window.location.href="exit2.jsp";
       					}else{
       						document.location.reload();	
       					}
    					})	
    				},
    				error:function(err){
    					alert("错误");
    				}
    			});  
          }
           //修改个人信息
     	  function postInfo(){
     		var userId = "${usersInfo.userId }";
          	var nickname = $("#userNickName").val();
          	var sex = $("input[type='radio']:checked").val();
          	var phone = $("#userWorkLocation").val();
          	var signature = $("textarea").val();
          	var county = $("#sel").val();
          	
          	var params = {"userId":userId,"nickname":nickname,"sex":sex,"phone":phone,"signature":signature,"county":county};
          	ajaxModel("user/modifyUserinfo",params);
          	}
           
           //修改密码
           function postPWD(){
        	   var email = "${data.email }";
        	   var password = $("#oldPWD").val();
        	   var newPassword = $("#newPWD1").val();
        	   var newPassword2 = $("#newPWD2").val();
        	   if(password.length<=0||password==""){
        		   alert("原始密码不能为空");
        		   return false;
        	   }
        	   if(newPassword!=newPassword2){
        		   alert("两次输入的新密码不一致，请重新输入");
        		   return false;
        	   }
        	   if(newPassword.length<6){
        		   alert("密码长度大于六位数");
        		   return false;
        	   }
        	   var params = {"email":email,"password":password,"newPassword":newPassword};
        	   ajaxModel("user/modifyPassword",params);
        	
        	   return true;
           }
           
           	//密保页面校验
           	function post() {
              if (check()) {
            	  var params = { userId: $("#userId").val(), question1: $("#question1").val(), answer1: $("#answer1").val(),
                          question2: $("#question2").val(), answer2: $("#answer2").val()};
            	  ajaxModel("user/passSecurity",params); 
                }
            }
           	function check() {
                var question1 = document.getElementById("question1").value;
                var question2 = document.getElementById("question2").value;
                var answer1 = document.getElementById("answer1").value;
                var answer2 = document.getElementById("answer2").value;
                if (question1 == "") {
                    alert("请选择问题1");
                    return false;
                } else if (answer1 == "") {
                    alert("请填写答案1");
                    return false;
                } else if (question2 == "") {
                    alert("请选择问题2");
                    return false;
                } else if (answer2 == "") {
                    alert("请填写答案2");
                    return false;
                } else if (question1 == question2) {
                    alert("请选择不同的问题");
                    return false;
                } else {
                    return true;
                }
            }
			//密保问题显示
			$(document).ready(function (){
				var question1 = "${passSecurity.question1 }";
				var question2 = "${passSecurity.question2 }";
				$("#question1 option").each(function(){
					if(question1==$(this).val()){
						$(this).attr("selected","selected");
					}
				})
				$("#question2 option").each(function(){
					if(question2==$(this).val()){
						$(this).attr("selected","selected");
					}
				})
			})
        </script>
        <!--top 固定位置 end-->
        <div class="tops">
            
<link href="css/top.css" type="text/css" rel="stylesheet" />
<script src="js/tanchu.js" type="text/javascript"></script>
<script language="javascript">

	function loginUp(){
		$(".nologin1").css("display","none");
		$(".logined").css("display","block");
	};
	
    function ulshows() {
        $("#ulshow").css('display', 'block');
    }
    function ulhide() {
        $("#ulshow").css('display', 'none');
    }
    function getthread() {
        $("#thread").css('display', 'none');
        $("#friend").css('display', 'block');
        $("#forum").css('display', 'block');
        $("#ulshow").css('display', 'none');
        $("#s_search span").html("帖子");
    }
    function getfriend() {
        $("#thread").css('display', 'block');
        $("#friend").css('display', 'none');
        $("#forum").css('display', 'block');
        $("#ulshow").css('display', 'none');
        $("#s_search span").html("潮友");
    }
    function getforum() {
        $("#thread").css('display', 'block');
        $("#friend").css('display', 'block');
        $("#forum").css('display', 'none');
        $("#ulshow").css('display', 'none');
        $("#s_search span").html("版块");
    }
    $(document).ready(function () {

        var login_popupStatus = 0;
        function login_loadPopup() {
            if (login_popupStatus == 0) {
                $("#login_backgroundPopup").css({
                    "opacity": "0.7"
                });
                $("#login_backgroundPopup").fadeIn("fast");
                $("#login_popupContact").fadeIn("fast");
                login_popupStatus = 1;
            }
        }

        function login_disablePopup() {
            if (login_popupStatus == 1) {
                $("#login_backgroundPopup").fadeOut("slow");
                $("#login_popupContact").fadeOut("slow");
                login_popupStatus = 0;
            }
        }

        function login_centerPopup() {
            var windowWidth = document.documentElement.clientWidth;
            var windowHeight = document.documentElement.clientHeight;
            var popupHeight = $("#login_popupContact").height();
            var popupWidth = $("#login_popupContact").width();
            $("#login_popupContact").css({
                "position": "absolute",
                "top": windowHeight / 2 - popupHeight / 2,
                "left": windowWidth / 2 - popupWidth / 2
            });
            $("#login_backgroundPopup").css({
                "height": windowHeight
            });
        }

        $(".login_button").click(function () {
            login_centerPopup();
            login_loadPopup();
        });

        $("#login_popupContactClose").click(function () {
            login_disablePopup();
        });
    });




    var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");

    var browser = navigator.userAgent.toLowerCase();

    var isMobile = false;
    
</script>

<div class="topall">
			<div id="topalls_div" class="topalls">
				<a href="index.jsp" title="中国潮州首页"><img id="top01" src="<%=basePath%>images/home/topczlt1.gif" alt="中国潮州首页" /></a>
				<a href="index.jsp" class="a_first headcurrent" style="margin-top:5px">论坛首页</a>
				<!--  
				 <a href="javascript:void(0);" id="weixin_button" class="a_first" style="margin-top:5px">精华帖</a>
				-->
				
				
				<a href="exit2.jsp" class="logined" onclick="loginOut()" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; cursor:pointer; _padding-top: 5px; float: right; display:none">退出</a>
				<a href="javascript:void(0)" class="logined" id="user" style="font-size: 12px; margin-top: 5px; _margin-top: 0px; _padding-top: 5px; float: right; display:none;">${sessionScope.data.email }</a>
			</div>
		</div>

        </div>
        <div class="contents">
            <div class="con_top">
                
<link href="css/user/home.css" type="text/css" rel="stylesheet" />
<div class="con_imgs">
    <img src="${usersInfo.image }" />
    
</div>
<div class="con_text">
    <div class="con_box02">
        <span>
            <p>
                <strong>昵称</strong>：${usersInfo.nickname }</p>
            <p>
                <strong>等级</strong>：${integration.monicker }</p>
            <p>
                <strong>帖子</strong>：${integration.postNum }</p>
            <p style="margin-right: 0;">
                <strong>回复</strong>：${integration.backNum }</p>
        </span>
        <span>
            <p>
                <strong>积分</strong>：<font style="color: #F60">${integration.score }</font></p>
            <p>
                
            </p>
        </span>
    </div>
    <div class="jiangzhang">
        
    </div>
</div>

            </div>
            <div class="home_content">
                
<div class="home_lef" id="home_lef">
    <a class="home_lef_first">设置</a>
    <div  class='home_lef_current'>
        <a href="javascript:void(0)"><img src="images/user/home01.gif" />修改头像</a>
    </div>
    <div >
        <a href="javascript:void(0)"><img src="images/user/home02.gif" />个人资料</a>
    </div>
    <div >
        <a href="javascript:void(0)"><img src="images/user/home03.gif" />修改密码</a>
    </div>
    <div >
        <a href="javascript:void(0)"><img src="images/user/home04.gif" />密码保护</a>
    </div>
    <div >
        <a href="javascript:void(0)"><img src="images/user/home05.gif" />积分</a>
    </div>
     <div >
        <a href="user/findfriend"><img src="images/user/home06.gif" />好友管理</a>
    </div>
    <div >
        <a href="user/postmessage"><img src="images/user/home08.gif" />给ta发信息</a>
    </div>
    
</div>
		<div class="func">
                <div class="home_rig" >
                    <div class="home_rig_li home_rig_current" id="tagContents0">
                        <span>
                            <font style="font-size: 15px;">
                                <strong>当前我的头像</strong></font>
                        </span>
                        <span>
                            <font style="font-size: 12px;">如果您还没有设置自己的头像，系统会显示为默认头像，您需要自己选择或上传一张新照片来作为自己的个人头像</font>
                        </span>
                        <span>
                            <span class="face_2_box">
                                <img id="userFace2" src="${usersInfo.image }" width="120" height="120" />
                                
                            </span>
                        </span>
                        <span>
                            <font style="font-size: 15px;">
                                <strong>设置我的新头像</strong></font>
                        </span>
                        <span>
                            <font style="font-size: 12px;">请选择一个新照片进行上传编辑。</font>
                        </span>
                        <span>
                            <font style="font-size: 12px;">头像保存后，您可能需要刷新一下本页面(按F5键)，才能查看最新的头像效果</font>
                        </span>
                        <span>
                            <div class="tx_box01">
                                <div class="tx_box02">
                                    <div id="touxiang">
                                        <ul id="touxiang_tags">
                                            <li class="touxiang_selectTag">
                                                <a onclick="touxiang_selectTag('touxiang_tagContent0',this)" href="javascript:void(0)">系统头像</a>
                                            </li>
                                           
                                           
                                        </ul>
                                        <div id="touxiang_tagContent">
                                            <div class="touxiang_tagContent touxiang_selectTag" id="touxiang_tagContent0">
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txjiajiren.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txwomen.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txmen.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txgirl.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txboy.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txcuobian.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/txya.gif" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx002.jpg" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx003.jpg" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx004.jpg" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx005.jpg" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx006.jpg" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx007.jpg" class="img_text" /></a>
                                                <a class="xttx_img" href="javascript:void(0)"><img src="images/user/avatar/tx008.jpg" class="img_text" /></a>
                                           
                                            </div>
                                            
                                           
                                        </div>
                                    </div>
                                </div>
                                <div id="def_div" class="tx_box03">
                                    <span>
                                        <font style="font-size: 13px; font-weight: bold;">预览</font></span>
                                    <div class="tx_box03_imgs">
                                        <img src="${usersInfo.image }" id="tx_change" />
                                    </div>
                                    <span style="float: left; margin-top: 10px;">
                                        100 x 100</span>
                                    <div class="tx_btn" style="margin-left: 40px;">
                                        <a href="javascript:void(0)" onclick="UpdateUserFace();">保存</a></div>
                                </div>
                                <div id="upload_div" class="tx_box03" style="display: none;">
                                    <span>
                                        <font style="font-size: 13px; font-weight: bold;">预览</font></span>
                                    <div class="tx_box03_imgs">
                                        <img src="" id="Img2" />
                                    </div>
                                    <span style="float: left; margin-top: 10px;">
                                        100 x 100</span>
                                    <div class="tx_btn" style="margin-left: 40px;">
                                    </div>
                                </div>
                            </div>
                        </span>
                    </div>
                </div>
                <!--个人信息-->   
                
                <div class="home_rig" style="display: none;">
                    <div class="home_rig_li home_rig_current" id="tagContents1" name="个人资料">
                        <div id="con">
                            <ul id="tags">
                                <li class="selectTag">
                                    <a onclick="selectTag('tagContent0',this)" href="javascript:void(0)">基本资料</a>
                                </li>
                                
                            </ul>
                            <div id="tagContent">
                                <div class="tagContent selectTag" id="tagContent0">
                                    <table width="0" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td align="left" class="tag01">
                                              邮&nbsp;&nbsp;箱
                                            </td>
                                            <td align="left" class="tag02">
                                                 ${usersInfo.email }
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                                用户昵称
                                            </td>
                                            <td align="left" class="tag02">
                                                <input id="userNickName" type="text" value=" ${usersInfo.nickname }" class="input_txt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                              性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别
                                            </td>
                                            <td align="left" class="tag02">
                                                <input type="radio" id="male" name="sex" value="男" style="float:none;"/>
                                                 <label for="male">男</label>
                                                <input type="radio" id="female" name="sex" value="女" style="float:none;"/>
                                                <label for="female">女</label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                               电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话
                                            </td>
                                            <td align="left" class="tag02">
                                                <input id="userWorkLocation" type="text" value=" ${usersInfo.phone }" class="input_txt" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                                个性签名
                                            </td>
                                            <td align="left" class="tag02">
                                               <textarea rows="10" cols="33" id="textarea">
													${usersInfo.signature }
												</textarea>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td align="left" class="tag01">
                                         区/县：
                                            </td>
                                      <td align="left" class="tag02">   
										<select name="county" id="sel">
										  <option value="潮安区">潮安区</option>
										  <option value="枫溪区">枫溪区</option>
										  <option value="湘桥区">湘桥区</option>
										  <option value="饶平区">饶平县</option>
										</select>	
									</td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                              注册时间
                                            </td>
                                            <td align="left" class="tag02">
                                                ${usersInfo.registerTime }
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                            上次登录时间
                                            </td>
                                            <td align="left" class="tag02">
                                                ${usersInfo.loginTime }
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2" style="color: Red;">
                                                说明：修改个人资料之后需要等待管理员审核，所以将会被强制退出登录，并等待审核通过后才能使用。
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3">
                                                <div onclick="postInfo()" class="home_btn">
                                                    保存</div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                </div>
                               </div>
                              </div>
                              </div>
                            <!--
                            	修改密码
                            -->
                            <div class="home_rig" style="display: none;">
                    <div class="home_rig_li home_rig_current" id="tagContents2" name="修改密码">
                        <span style="border-bottom: 1px dashed #dedede;">
                            您必须填写原密码才能修改下面的资料</span>
                        <span>
                            <table width="0" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                                <tr>
                                    <td align="left" class="tag01">
                                        旧&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;码
                                    </td>
                                    <td align="left" class="tag02">
                                        <input id="oldPWD" type="password" style="width: 300px;" class="input_txt" />
                                        <font style="color: #F00; margin-left: 5px;">*</font>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" class="tag01">
                                        新&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;码
                                    </td>
                                    <td align="left" class="tag02">
                                        <input id="newPWD1" type="password" style="width: 300px;" class="input_txt" />
                                        <font id="f1" style="margin-left: 5px;"></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" class="tag01">
                                        确认新密码
                                    </td>
                                    <td align="left" class="tag02">
                                        <input id="newPWD2"  type="password" style="width: 300px;" class="input_txt" />
                                        <font id="f2" style="color: #F00; margin-left: 5px;"></font>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div onclick="postPWD()" class="home_btn01">
                                            保存</div>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </span>
                    </div>
					</div>
					
					<!--密码保护-->
					<div class="home_rig" style="display: none;">
                    <div class="home_rig_li home_rig_current" id="tagContents3" name="密码保护">
                        <div id="mima">
                            <div id="mima_tagContent">
                                <span style="border-bottom: 1px dashed #dedede;">选择密保问题，并填写问题答案</span>
                                <span>
                                    <table width="0" border="0" cellpadding="0" cellspacing="0" style="margin-top: 10px;">
                                        <tr>
                                            <td align="left" class="tag01">
                                                安全问题1
                                            </td>
                                            <td align="left" class="tag02">
                                                <select id="question1" style="padding: 0; width: 310px; _width: 308px; margin-top: 5px;" class="input_txt">
                                                    <option value="">请设置密保问题</option>
                                                    <option value="母亲的名字">母亲的名字</option>
                                                    <option value="父亲的名字">父亲的名字</option>
                                                    <option value="母亲的生日">母亲的生日</option>
                                                    <option value="父亲的生日">父亲的生日</option>
                                                    <option value="最喜欢的偶像">最喜欢的偶像</option>
                                                    <option value="最喜欢的餐厅">最喜欢的餐厅</option>
                                                    <option value="最喜欢的老师">最喜欢的老师</option>
                                                    <option value="最喜欢的电影">最喜欢的电影</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                                问题答案1
                                            </td>
                                            <td align="left" class="tag02">
                                                <input id="answer1" type="text" style="width: 300px;" class="input_txt" value="${passSecurity.answer1 }" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                                安全问题2
                                            </td>
                                            <td align="left" class="tag02">
                                                <select id="question2" style="padding: 0; width: 310px; _width: 308px; margin-top: 5px;" class="input_txt">
                                                    <option value="">请设置密保问题</option>
                                                    <option value="母亲的名字">母亲的名字</option>
                                                    <option value="父亲的名字">父亲的名字</option>
                                                    <option value="母亲的生日">母亲的生日</option>
                                                    <option value="父亲的生日">父亲的生日</option>
                                                    <option value="最喜欢的偶像">最喜欢的偶像</option>
                                                    <option value="最喜欢的餐厅">最喜欢的餐厅</option>
                                                    <option value="最喜欢的老师">最喜欢的老师</option>
                                                    <option value="最喜欢的电影">最喜欢的电影</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="tag01">
                                                问题答案2
                                            </td>
                                            <td align="left" class="tag02">
                                                <input id="answer2" type="text" style="width: 300px;" class="input_txt" value="${passSecurity.answer2 }" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div onclick="post()" class="home_btn01">
                                                    确定修改</div>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

				<!--积分-->
				<!--操作标签 jQ-->
		 
		        <script type="text/javascript">
		       
		            function jifen_selectTag(jifen_showContent, jifen_selfObj) {
		                // 操作标签
		                var jifen_tag = document.getElementById("jifen_tags").getElementsByTagName("li");
		                var jifen_taglength = jifen_tag.length;
		                for (i = 0; i < jifen_taglength; i++) {
		                    jifen_tag[i].className = "";
		                }
		                jifen_selfObj.parentNode.className = "jifen_selectTag";
		                // 操作内容
		                for (i = 0; j = document.getElementById("jifen_tagContent" + i); i++) {
		                    j.style.display = "none";
		                }
		                document.getElementById(jifen_showContent).style.display = "block";
		            }
		
		          
		        </script>
                 <div class="home_rig" style="display: none;">
                    <div class="home_rig_li home_rig_current" id="tagContents4" name="积分">
                        <div id="jifen">
                            <ul id="jifen_tags">
                                <li class="jifen_selectTag">
                                    <a onclick="jifen_selectTag('jifen_tagContent0',this)" href="javascript:void(0)">我的积分</a>
                                </li>
                                <li>
                                    <a onclick="jifen_selectTag('jifen_tagContent1',this)" href="javascript:void(0)">积分规则</a>
                                </li>
                                <li>
                                    <a onclick="jifen_selectTag('jifen_tagContent2',this)" href="javascript:void(0)">等级说明</a>
                                </li>
                            </ul>
                            <div id="jifen_tagContent">
                                <div class="jifen_tagContent jifen_selectTag" id="jifen_tagContent0">
                                    <span style="font-size: 13px; margin-top: 10px;">
                                        <strong>积分收益统计</strong></span>
                                    <span style="margin-top: 10px; margin-bottom: 10px;">
                                        
                                        <table id="table1" border="0" cellpadding="0" cellspacing="1">
                                            <tr class="tr_first-child">
                                                <td class="jftd01">
                                                    操作名称
                                                </td>
                                                <td class="jftd02">
                                                    积分变更
                                                </td>
                                                <td class="jftd04">
                                                  小&nbsp;&nbsp;计
                                                </td>
                                            </tr>
                                            
                                            <tr>
                                                <td class="jftd01">
                                                   发布主题帖数：${integration.postNum }
                                                </td>
                                                
                                                <td class="jftd02">
                                                    *30
                                                </td>
                                                
                                                <td class="jftd04">
                                               ${integration.postNum*30 }
                                                </td>
                                            </tr>
                                                                            <tr>
                                                <td class="jftd01">
                                                  回帖数：${integration.backNum }
                                                </td>
                                                
                                                <td class="jftd02">
                                                    *10
                                                </td>
                                                
                                                <td class="jftd04">
                                                  ${integration.backNum*10 }
                                                </td>
                                            </tr>
                                            
                                                                            <tr>
                                                <td class="jftd01">
                                                   精华帖数：${integration.goodPostNum }
                                                </td>
                                                
                                                <td class="jftd02">
                                                    *200
                                                </td>
                                                
                                                <td class="jftd04">
                                                  ${integration.goodPostNum*200 }
                                                </td>
                                            </tr>
                                            
                                            
                                                                            <tr>
                                                <td class="jftd01">
                                                   在线时长：${integration.onlineTime }
                                                </td>
                                                
                                                <td class="jftd02">
                                                    *0.1
                                                </td>
                                                
                                                <td class="jftd04">
                                                  ${integration.onlineTime*0.1 }
                                                </td>
                                            </tr>
                                        </table>
                                    </span>
                                </div>
                                <div class="jifen_tagContent" id="jifen_tagContent1">
                                    <span style="border-bottom: 1px dashed #dedede;">进行一下操作，会得到相应的积分奖励。(说明：在一个周期内，您最多得到的奖励次数有限制)</span>
                                    <table>
                                        <tr class="tr_first-child">
                                            <td>
                                                操作名称
                                            </td>
                                            <td>
                                                每次获得积分
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                               精华帖
                                            </td>
                                            
                                            <td>
                                                +200
                                            </td>
                                            
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                添加回复
                                            </td>
                                            
                                            <td>
                                                +20
                                            </td>
                                            
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                添加帖子
                                            </td>
                                            
                                            <td>
                                                +50
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                            <td>
                                               在线时长（每10分钟）
                                            </td>
                                            
                                            <td>
                                                +1
                                            </td>
                                            
                                        </tr>
                                        
                                    </table>
                                </div>
                                <div class="jifen_tagContent" id="jifen_tagContent2">
                                    <table>
                                        <tr class="tr_first-child">
                                            <td>
                                                等级
                                            </td>
                                            <td>
                                                积分范围
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                               江湖小虾
                                            </td>
                                            <td>
                                                0
                                                ~ 199
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                江湖小哥
                                            </td>
                                            <td>
                                                200
                                                ~ 499
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                江湖少侠
                                            </td>
                                            <td>
                                                500
                                                ~ 999
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                               武林高手
                                            </td>
                                            <td>
                                                1000
                                                ~ 1599
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                                一代宗师
                                            </td>
                                            <td>
                                                1600
                                                ~ 2499
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>
                                               武林至尊
                                            </td>
                                            <td>
                                                2500
                                                ~ 3999
                                            </td>
                                        </tr>
                                        
                                        
                                        
                                        <tr>
                                            <td>
                                                世外高人
                                            </td>
                                            <td>
                                                4000
                                                ~ 999999
                                            </td>
                                        </tr>
                                        
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
		</div>
		 

			<!---->
            </div>
            <div class="blank8">
            </div>

            <div class="user_bottom">
<%--    		  版权by:五邑大学 160810班 许桐源 &nbsp;仅用于毕业设计--%>
    粤ICP备2022047901
                <br>
            </div>
        </div>
        <!--操作标签 jQ-->
    </div>
    

</body>
</html>