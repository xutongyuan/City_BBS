<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
 String path = request.getContextPath();
 String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
   + path + "/";
%>
<base href="<%=basePath %>">
<script type="text/javascript"
	src="js/jquery-3.1.1.js"></script>
<script type="text/javascript"
	src="ueditor/ueditor.config.js"></script>
<script type="text/javascript"
	src="ueditor/ueditor.all.js"></script>
<script type="text/javascript"
	src="ueditor/ueditor.parse.js"></script>

<%String curArea = (String)request.getParameter("area");%>	<!-- 获取当前版块编号 -->
</head>
<body>
<div class="fastpost">
     <a name="posttopic"></a>
     <div class="title">
      &nbsp;&nbsp;&nbsp;快速发帖</div>
     <div class="textarea">
   
  <div style="margin-bottom:10px">
	     <label for="ti" style="width:300px; height:25px;margin-right:10px;font-size:20px">标题:
	     </label>
	     <input type="text" id="ti" class="titleText" style="width:300px; height:25px"> 
     </div>
	<!--style给定宽度可以影响编辑器的最终宽度-->
	<textarea id="myEditor" style="width: 984px; height: 280px;">
		<p>在这里输入你的帖子内容...</p>
	</textarea>
	
	</div> 
	
	<div class="postbtn" style="margin-top:0px;z-index:3">  
       <img style="cursor:pointer;float:right;margin-right:20px;margin-top:50px" onclick="postdata();" src="images/showlist/pn_post.png">
    </div>
</div>
	<script>
		
	UE.getEditor('myEditor', {
		//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
		toolbars: [
[
    'undo', //撤销
    'redo', //重做
    'bold', //加粗
    'indent', //首行缩进
    'snapscreen', //截图
    'italic', //斜体
    'underline', //下划线
    'strikethrough', //删除线
    'subscript', //下标
    'fontborder', //字符边框
    'superscript', //上标
    'formatmatch', //格式刷
    'source', //源代码

    'pasteplain', //纯文本粘贴模式
    'selectall', //全选
    'horizontal', //分隔线
    'removeformat', //清除格式
    'time', //时间
    'date', //日期
    'unlink', //取消链接

    'inserttitle', //插入标题
    'cleardoc', //清空文档
    'fontfamily', //字体
    'fontsize', //字号
    'paragraph', //段落格式
    'simpleupload', //单图上传
    'insertimage', //多图上传
    'link', //超链接
    'emotion', //表情
    'spechars', //特殊字符
    'searchreplace', //查询替换
    
    'justifyleft', //居左对齐
    'justifyright', //居右对齐
    'justifycenter', //居中对齐
    'justifyjustify', //两端对齐
    'forecolor', //字体颜色
    'backcolor', //背景色     
    'imagecenter', //居中
    'lineheight', //行间距
    'edittip ', //编辑提示
    'customstyle', //自定义标题
    'autotypeset', //自动排版
    'touppercase', //字母大写
    'tolowercase', //字母小写
    'background', //背景

   
]
],
		//focus时自动清空初始化时的内容
		autoClearinitialContent : true,
		//关闭字数统计
		wordCount : true,
		//关闭elementPath
		elementPathEnabled : false,
		//默认的编辑区域高度
		initialFrameHeight : 280,
		//最大字符数
		maximumWords:1000
	//更多其他参数，请参考ueditor.config.js中的配置项
	});
	/* UE.Editor.prototype.getActionUrl = function(action) {
	 //这里很重要，很重要，很重要，要和配置中的imageActionName值一样
	 if (action == 'fileUploadServlet') {
	 //这里调用后端我们写的图片上传接口
	 return 'http://localhost:8081/Test/fileUploadServlet';
	 }else{
	 return this._bkGetActionUrl.call(this, action);
	 }
	 } */
	
		
	 var postdata = function(){
			var ob = UE.getEditor("myEditor");
			//对编辑器的操作最好在编辑器ready之后再做
			
			    //设置编辑器的内容
			   // ob.setContent('hello');
			   
			    var html = ob.getContent();
			    //获取纯文本内容，返回: hello
			    var txt = ob.getContentTxt();
				var title = $(".titleText").val();	//获取帖子title
				var area = <%=curArea%>;

				if(title==""||title.trim()==""){
					alert("标题不能为空");
					return false;
				}else if(html==""||html.trim()==""){
					alert("帖子内容不能为空");
					return false;
				}
			  $.ajax({
				type:'post',
				url:'content/submitPost',
				dataType:'json',
				
				data:{"title":title,"content":html,"area":area},
				success:function(result){
					if(result){
						// alert("发布成功");
						document.location.reload();		
						}else{
							alert("发帖失败，字数超过限制");
						}
					}
				});
			    
		
		}
		
	</script>
	
	<style>
	.textarea{
		width:1024px;
		height:340px;
		padding:20px 20px;
			
		}
	.fastpost{
		height:500px;
		margin-bottom:20px;
	}
	</style>
</body>
</html>