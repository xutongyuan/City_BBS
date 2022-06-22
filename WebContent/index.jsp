<%@page import="java.util.List"%>

<%@ page import="ssm.ContentCtr" %>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@ page import="org.springframework.web.context.WebApplicationContext" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page import="ssm.po.Theme" %>
<%@ page import="java.util.Map" %>
<%@ page import="ssm.po.Banner" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%--	360--%>
<meta name="360-site-verification" content="074cf97e5f2454238f568ec444850051" />
<%--	百度--%>
<meta name="baidu-site-verification" content="code-Te1QEPstcc" />
<%--	搜狗--%>
<meta name="sogou_site_verification" content="FPvYEHF5sr" />
<%--	神马--%>
<meta name="shenma-site-verification" content="a3cadaa21583e1f68fb07f38177e8252_1655730789"/>
<%--	头条--%>
<meta name="bytedance-verification-code" content="ba33cCTaV4bwInx0XV6k" />
<title>潮州交友论坛-潮州最火的交友论坛|潮州民生|潮州生活|异性交友</title>
<%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path + "/";

 //Page<Theme> tu = (Page<Theme>)session.getAttribute("recentBack");
	//List<Theme> list =	tu.getResult();
%>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=basePath%>/js/jquery-3.1.1.js" ></script>
		<link rel="stylesheet" href="<%=basePath%>/css/top.css" />
		<link rel="stylesheet" href="<%=basePath%>/css/head.css" />
		<link rel="stylesheet" href="<%=basePath%>/css/focus.css" />
		<script type="text/javascript" src="<%=basePath%>/js/focusPic.js" ></script>


</head>
<body>

<jsp:include page="nav.jsp" flush="true"></jsp:include>


<%
	WebApplicationContext context= WebApplicationContextUtils.getWebApplicationContext(application);
	ContentCtr contentCtr = (ContentCtr)context.getBean("contentCtr");

	//查询轮播图内容
	List<Banner> bannerList = contentCtr.getBannerList();

	//查询最新新闻贴
	Map<String, Theme> navPost = contentCtr.getNavPost();
	Theme navPost1 = null;
	Theme navPost2 =null;
	Theme navPost3 =null;
	String navPostT1 ="";
	String navPostT2 ="";
	String navPostT3 ="";
	String navPostC1 ="";
	String navPostC2 ="";
	String navPostC3 ="";
	if(navPost.size()>=3){
		navPost1 = navPost.get("navPost1");
		navPost2 = navPost.get("navPost2");
		navPost3 = navPost.get("navPost3");
		navPostT1 = navPost1.getTitle().length()>17?navPost1.getTitle().substring(0, 17):navPost1.getTitle();
		navPostT2 = navPost2.getTitle().length()>17?navPost2.getTitle().substring(0, 17):navPost2.getTitle();
		navPostT3 = navPost3.getTitle().length()>17?navPost3.getTitle().substring(0, 17):navPost3.getTitle();
		navPostC1 = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+navPost1.getContent().replaceAll("<.*?>","").substring(0, 60);
		navPostC2 = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+navPost2.getContent().replaceAll("<.*?>","").substring(0, 60);
		navPostC3 = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+navPost3.getContent().replaceAll("<.*?>","").substring(0, 60);
	}


%>

	<div id="focus_row" class="m_row col2">

		<!-- 焦点图 begin -->

		<div class="FocusImg">
			<div class="BigPic" id="BigPic_01">
				<a href="" target="_blank"><img src=""
					style="FILTER: revealTrans(duration = 1, transition = 23);"
					galleryimg="no" alt="" /></a>
			</div>
			<div class="TitleBg"></div>
			<div class="TitleBox" id="TitleBox_01"></div>
			<div class="MemoBox" id="MemoBox_01"></div>
			<div class="SmallPics" id="SmallPics_01">
				<!-- 小图列表 -->
			</div>
		</div>
		<script language="javascript" type="text/javascript">

			var FocusPic_02 = new FocusPic("BigPic_01", "SmallPics_01",
					"TitleBox_01", "MemoBox_01");
		<%
			if(bannerList!=null&&bannerList.size()>=4){
				//轮播图4个以上动态展示，否则使用静态页面
		%>
			<c:forEach items="<%=bannerList%>" var="item">
		FocusPic_02.Add(
				"${item.bigPicUrl}",
				"${item.bigPicUrl}",
				"${item.postUrl}",
				"${item.mainTitle}","${item.subTitle}");
			</c:forEach>
		<%
			}else{

		%>

		FocusPic_02.Add(
				'<%=basePath%>images/focusPic/U3093P59T310D2F4828DT20150512163244.jpg',
				'<%=basePath%>images/focusPic/U3093P59T310D2F4829DT20150512163244.jpg',
				"javascript:doPost('content/showDetail',{'postId':17,'userId':'cz8263','area':20 },'_blank');",
				"阅兵哪家强：各国阅兵旧照", "世界这么大阅兵谁更炫");
		FocusPic_02.Add(
				'<%=basePath%>images/focusPic/U1335P59T310D3F4828DT20160314172438.jpg',
				'<%=basePath%>images/focusPic/U1335P59T310D3F4829DT20160314172438.jpg',
				"javascript:doPost('content/showDetail',{'postId':15,'userId':'cz8263','area':20 },'_blank');",
				"蒙古军队维和蓝盔女兵亮相 个个丰满健硕！", "这肯定都是真的！");
		FocusPic_02.Add(
				'<%=basePath%>images/focusPic/U11828P59T310D4F4828DT20160106115944.jpg',
				'<%=basePath%>images/focusPic/U11828P59T310D4F4829DT20160106115944.jpg',
				"javascript:doPost('content/showDetail',{'postId':18,'userId':'cz8263','area':20 },'_blank');",
				"复古气质美人摄影拍出浓郁油画感", "");
		FocusPic_02.Add(
				'<%=basePath%>images/focusPic/U2679P59T310D5F4828DT20160106115507.jpg',
				'<%=basePath%>images/focusPic/U2679P59T310D5F4829DT20160106115507.jpg',
				"javascript:doPost('content/showDetail',{'postId':19,'userId':'cz8263','area':20 },'_blank');", "CES开幕：同一个展会同一种残酷", "");
		<%
			}
		%>

			FocusPic_02.listCode = '<span onmouseover="FocusPic.childs[[$thisId]].select([$num])"><img src="[$pic]" alt="[$title]" /><b></b></span>';
			FocusPic_02.begin();
			//--><!]]>
		</script>
		<!-- 焦点图 end -->

		<div class="m">

			<div class="Ybox">
				<div class="box_h">
					<h2 class="hidden_txt">锐头条</h2>
					<div class="today"><p id="today">2018年2月8日 星期四</p></div>
				</div>

				<!-- wapbbstop browser begin 勿删 -->
				<div class="box_c clearfix">
					<%
						//	有新闻则展示，避免首次部署报错
						if(navPost.size()>=3){ %>
					<!-- publish_helper name='头条1' p_id='59' t_id='310' d_id='17' -->
					<div class="top_news">
						<h2>
							<a class="cRed"
							   href="content/showDetail?postId=<%=navPost1.getPostId()%>&userId=<%=navPost1.getUserId()%>&area=<%=navPost1.getArea()%>">
								<%=navPostT1%></a>
						</h2>
						<p>
							<a href="content/showDetail?postId=<%=navPost1.getPostId()%>&userId=<%=navPost1.getUserId()%>&area=<%=navPost1.getArea()%>">
								<%=navPostC1%>……</a>
						</p>
					</div>

					<!-- publish_helper name='头条2' p_id='59' t_id='310' d_id='18' -->
					<div class="top_news top_news_star">
						<h2>
							<a class="cRed"
							   href="content/showDetail?postId=<%=navPost2.getPostId()%>&userId=<%=navPost2.getUserId()%>&area=<%=navPost2.getArea()%>">
								<%=navPostT2%></a>
						</h2>
						<p>
							<a href="content/showDetail?postId=<%=navPost2.getPostId()%>&userId=<%=navPost2.getUserId()%>&area=<%=navPost2.getArea()%>">
								<%=navPostC2%>……</a>
						</p>
					</div>

					<!-- publish_helper name='头条3' p_id='59' t_id='310' d_id='19' -->
					<div class="top_news">
						<h2>
							<a class="cRed"
							   href="content/showDetail?postId=<%=navPost3.getPostId()%>&userId=<%=navPost3.getUserId()%>&area=<%=navPost3.getArea()%>">
								<%=navPostT3%></a>
						</h2>
						<p>
							<a href="content/showDetail?postId=<%=navPost3.getPostId()%>&userId=<%=navPost3.getUserId()%>&area=<%=navPost3.getArea()%>">
								<%=navPostC3%>……</a>
						</p>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
	<!-- wapbbstop browser end 勿删 -->

	<!-- wapbbs1 browser begin 勿删 -->

	<div class="m_row col3">
		<div class="m ttx">
			<div class="box_h">
				<h2>论坛最新回复</h2>
			</div>

			<ul class="txt_li" id="txt_li1">
			
			</ul>
			
			
		</div>

		<div class="m ttx">
			<div class="box_h">
				<h2>最新帖子</h2>
			</div>

			<ul class="txt_li" id="txt_li2">
			
			</ul>
		</div>
   </div>
   <div class="footer">
    <div class="COMM">
        <div class="foot_img" id="div_123"><span id="_ideConac"><a href="/"><img id="imgConac" vspace="0" hspace="0" border="0" src="images/home/topczlt1.gif" ></a></span></div>
        <div id="copyr">
<%--       		    版权by:五邑大学 160810班 许桐源 &nbsp;仅用于毕业设计--%>
	粤ICP备2022047901
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

		// js获取日期时间
		function getDateTime(){
			var dateObj = new Date(); //表示当前系统时间的Date对象
			var year = dateObj.getFullYear(); //当前系统时间的完整年份值
			var month = dateObj.getMonth()+1; //当前系统时间的月份值
			var date = dateObj.getDate(); //当前系统时间的月份中的日
			var day = dateObj.getDay(); //当前系统时间中的星期值
			var weeks = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
			var week = weeks[day]; //根据星期值，从数组中获取对应的星期字符串
			var hour = dateObj.getHours(); //当前系统时间的小时值
			var minute = dateObj.getMinutes(); //当前系统时间的分钟值
			var second = dateObj.getSeconds(); //当前系统时间的秒钟值
			var timeValue = "" +((hour >= 12) ? (hour >= 18) ? "晚上" : "下午" : "上午" ); //当前时间属于上午、晚上还是下午

			// return dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+" "+dateFilter(hour)+":"+dateFilter(minute)+":"+dateFilter(second) + "　" + week;
			return dateFilter(year)+"年"+dateFilter(month)+"月"+dateFilter(date)+"日 "+"　" + week;
		}

		// 年月日不满10位的前面补0
		function dateFilter(date){
			if(date < 10){return "0"+date;}
			return date;
		}

		
		$(document).ready(function(){
			let dateTime = getDateTime();
			document.getElementById("today").innerText = dateTime;
			$.ajax({
				type:'post',
				url:'content/getRecentBack',
				dataType:'json',
				
				data:{},
				success:function(result){
					$.each(result.recentBack,function(index,item){
						var postId = result.recentBack[index].postId;
						var userId = result.recentBack[index].userId;
						var area = result.recentBack[index].area;
						var title = result.recentBack[index].title.substring(0,15);
						var postingTime = result.recentBack[index].postingTime;
						// var html = '<li><a href='+'"'+"javascript:doPost('content/showDetail',{'postId':"+postId+",'userId':'"+userId+"','area':"+area+" },'_blank');"+'">'+title+'</a> <span class="des">'+postingTime+'</span></li>';
						// var html = '<li><a href='+'"'+"javascript:window.open('content/showDetail?postId="+postId+"&userId="+userId+"&area="+area+"' ,'_blank');"+'">'+title+'</a> <span class="des">'+postingTime+'</span></li>';
						var html = '<li><a href='+'"'+"content/showDetail?postId="+postId+"&userId="+userId+"&area="+area+'">'+title+'</a> <span class="des">'+postingTime+'</span></li>';
						$("#txt_li1").append(html);
					});
					$.each(result.recentPost,function(index,item){
						var postId = result.recentPost[index].postId;
						var userId = result.recentPost[index].userId;
						var area = result.recentPost[index].area;
						var title = result.recentPost[index].title.substring(0,15);
						var postingTime = result.recentPost[index].postingTime;
						// var html = '<li><a href='+'"'+"javascript:doPost('content/showDetail',{'postId':"+postId+",'userId':'"+userId+"','area':"+area+" },'_blank');"+'">'+title+'</a> <span class="des">'+postingTime+'</span></li>';
						// var html = '<li><a href='+'"'+"javascript:window.open('content/showDetail?postId="+postId+"&userId="+userId+"&area="+area+"' ,'_blank');"+'">'+title+'</a> <span class="des">'+postingTime+'</span></li>';
						var html = '<li><a href='+'"'+"content/showDetail?postId="+postId+"&userId="+userId+"&area="+area+'">'+title+'</a> <span class="des">'+postingTime+'</span></li>';
						$("#txt_li2").append(html);
					})
				},
				error:function(err){
					alert("错误");
				}
			});
		})
		</script>
</body>
</html>