 var divOff = true;//true;��ر� false:��չ��
 function showTipDiv(obj){   
	 jQuery("#ttnav").children("div").hide();
	 jQuery("#topnavnewtt").children().each(function(i){
		 var objId = this.id; 
		 if( objId.indexOf("navDiv") > -1 ){
			if( obj == (objId+i) ){ 
				jQuery("#"+objId).removeClass("btn_b");
				jQuery("#"+objId).addClass("btn_c");
				//jQuery("#"+obj).show(); 
				//divOff = false;
				//���ùر�ʱ��
  				///setInterval("checkDivStatsu('"+obj+"')",5000); 
			}else{  
				 changeDivClass(objId,"btn_b"); 
			} 
		 }
	 });  
	 jQuery("#searchDiv").show();
 } 
 function checkDivStatsu(obj){
	if( divOff ){
		closeDiv(obj);
	}
 }
 function closeDiv(obj){ 
	jQuery("#"+obj).hide();
 } 
 function openLeftMenu(itemid){ 
	var objItem =jQuery("#"+itemid);
	if( objItem == null || objItem == undefined )
		return;  
	objItem.show();  
	setAttrSrc(itemid);
}
 /**
 ***:flag:�Ƿ�չ���˵� :0:�� 1:չ��
 **/
function setAttrSrc(obj){
    var objTemp = jQuery("#img" + obj);
    var temp = document.getElementById(obj).style.display;
	if( temp != null && temp.indexOf("block") > -1 || temp == ""){//չ��
		objTemp.attr("src","images/ico_ttmn_2.gif")
	}else if(temp != null && temp.indexOf("none") > -1){ 
		objTemp.attr("src","images/ico_ttmn_1.gif")
	} 
 }
 function showMenu(obj){  
	//2009-12-29:jQuery(".ttMenu").children().each(function(i){
     jQuery(".left_menu_con_center").children().each(function (i) {
         var objId = this.id;
         if (objId.indexOf("item") > -1) {
             if (obj == objId) {
                 jQuery("#" + obj).toggle();
                 setAttrSrc(objId);
             } else {
                 jQuery("#" + objId).hide();
                 setAttrSrc(objId);
             }
         }
     });  
 } 
function divStatus(status){
	divOff = status;
} 
//�л���ʽ
function changeDivClass(objId,newclass){  
	 var oldClass = jQuery("#"+objId).attr("class");
	 jQuery("#"+objId).removeClass(oldClass);
	 jQuery("#"+objId).addClass(newclass); 
}  //�����˵��任
function changeMenu(divid,currentid){ 
	jQuery("#"+divid).children().each(function(){
		var id = this.id; 
		if( id == null || id == undefined )
			return; 
		if( id == currentid){   
//���������ʽȥ��
			var cclass= jQuery("#"+id).attr("class");
			if( cclass == null || cclass == undefined )
				return; 
			changeClass(divid,"btn_c","btn_b");
			jQuery("#"+id).removeClass(cclass); 
			jQuery("#"+id).addClass("btn_c"); 
			return;
		} 
		var cclass= jQuery("#"+id).attr("class"); 
		if( cclass == null || cclass == undefined )
			return; 
		jQuery("#"+id).hover(function(){ 
			jQuery("#"+id).removeClass(cclass); 
			jQuery("#"+id).addClass("btn_a"); 
		},function(){  
			jQuery("#"+id).removeClass("btn_a");
			jQuery("#"+id).addClass("btn_b");  
		}) 
	})
 }
function changeClass(divid,cclass,newclass){
	//���������ʽȥ��
	jQuery("#"+divid).children().each(function(){ 
		var curclass = jQuery("#"+this.id).attr("class");
		if( curclass == null || curclass == undefined )
			return;  
		if( curclass == cclass ){  
			jQuery("#"+this.id).removeClass(cclass); 
			jQuery("#"+this.id).addClass(newclass); 
		}
	})
}
function search(){
	var sokeyStr= jQuery("#sokey").val()
	if( typeof(jQuery("#sokey")) == 'undefined'){
		return;
	}
	sokeyStr = jQuery.trim(sokeyStr);
	if(sokeyStr.length == 0){ 
		return;
	}
	location.href='/search/search.jsp?key='+sokeyStr;
} 
jQuery(document).ready(function(){
	jQuery("#ksearch").click(function(){
		var searchtext = jQuery("#k").val();
		if( typeof(jQuery("#k")) == 'undefined' ){
			return;
		}
		if( searchtext == null || searchtext == "" ){
			alert("���������������֡�");
		}else{
			jQuery.get("/search/catasearch.jsp", {cataname:searchtext},function(data){
				if( jQuery.trim(data) != null && data.indexOf(".html") > -1){ 
					location.href=data;
				}else{
					alert("�Ҳ����������");
				} 
			}); 
		}
	});
	jQuery("#k").focus(function(){
		var searchtext = jQuery("#k").val();
		if( typeof(jQuery("#k")) == 'undefined' ){
			return;
		}
		if( jQuery.trim(searchtext) =='�������' ){
			jQuery("#k").val("");
		}
	});
})

//返回页面顶部
$(document).ready(function () {
            $("#backtop").mouseover(function () {
                $("#backtop").attr("src", "images/showlist/backtop_02.png");
            });
            $("#backtop").mouseout(function () {
                $("#backtop").attr("src", "images/showlist/backtop_01.png");
            });
            
            $("#backbottom").mouseover(function () {
                $("#backbottom").attr("src", "images/showlist/backbottom_02.png");
            });
            $("#backbottom").mouseout(function () {
                $("#backbottom").attr("src", "images/showlist/backbottom_01.png");
            });
            $("#backtop").click(function () {
                $('html,body').animate({ scrollTop: 0 }, 500);
            });
            $("#backbottom").click(function () {
                $('html,body').animate({ scrollTop: document.body.clientHeight }, 500);
            });
            setInterval("scroll_top()", 500);	//每隔0.5秒判断是否页面滚动
        });

        function scroll_top() {
            if ($(document).scrollTop() <= 100) {
                $(".back_top_bottom").hide();
            } else {
                $(".back_top_bottom").show();
            }
        }