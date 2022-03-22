// 浏览器版本判断
var Client = {
	Engine: {
		'name': 'unknown',
		'version': ''
	},
	Features: {}
};
Client.Features.xhr = !!(window.XMLHttpRequest);
Client.Features.xpath = !!(document.evaluate);
if(window.opera) Client.Engine.name = 'opera';
else if(window.ActiveXObject) Client.Engine = {
	'name': 'ie',
	'version': (Client.Features.xhr) ? 7 : 6
};
else if(!navigator.taintEnabled) Client.Engine = {
	'name': 'webkit',
	'version': (Client.Features.xpath) ? 420 : 419
};
else if(document.getBoxObjectFor != null) Client.Engine.name = 'gecko';
Client.Engine[Client.Engine.name] = Client.Engine[Client.Engine.name + Client.Engine.version] = true;

//滚动图片构造函数
//UI&UE Dept. mengjia
//090625
function ScrollPic(i, o, I, l, O) {
	var c = this;
	c.scrollContId = i;
	c.arrLeftId = o;
	c.arrRightId = I;
	c.dotListId = l;
	c.listType = O;
	c.dotClassName = "dotItem";
	c.dotOnClassName = "dotItemOn";
	c.dotObjArr = [];
	c.listEvent = "onclick";
	c.circularly = true;
	c.pageWidth = 0;
	c.frameWidth = 0;
	c.speed = 10;
	c.space = 10;
	c.upright = false;
	c.pageIndex = 0;
	c.autoPlay = true;
	c.autoPlayTime = 5;
	c._autoTimeObj;
	c._scrollTimeObj;
	c._state = "ready";
	c.stripDiv = document.createElement("DIV");
	c.listDiv01 = document.createElement("DIV");
	c.listDiv02 = document.createElement("DIV")
};
ScrollPic.prototype.version = "1.20";
ScrollPic.prototype.author = "mengjia";
ScrollPic.prototype.initialize = function() {
	var O = this,
		l = O;
	if(!O.scrollContId) {
		throw new Error("必须指定scrollContId.");
		return
	};
	O.scrollContDiv = sina.$(O.scrollContId);
	if(!O.scrollContDiv) {
		throw new Error("scrollContId不是正确的对象.(scrollContId = \"" + O.scrollContId + "\")");
		return
	};
	O.scrollContDiv.style[O.upright ? 'height' : 'width'] = O.frameWidth + "px";
	O.scrollContDiv.style.overflow = "hidden";
	O.listDiv01.innerHTML = O.scrollContDiv.innerHTML;
	O.scrollContDiv.innerHTML = "";
	O.scrollContDiv.appendChild(O.stripDiv);
	O.stripDiv.appendChild(O.listDiv01);
	if(O.circularly) {
		O.stripDiv.appendChild(O.listDiv02);
		O.listDiv02.innerHTML = O.listDiv01.innerHTML
	};
	O.stripDiv.style.overflow = "hidden";
	O.stripDiv.style.zoom = "1";
	O.stripDiv.style[O.upright ? 'height' : 'width'] = "32766px";
	if(!O.upright) {
		O.listDiv01.style.cssFloat = "left";
		O.listDiv01.style.styleFloat = "left";
		O.listDiv01.style.overflow = "hidden"
	};
	O.listDiv01.style.zoom = "1";
	if(O.circularly && !O.upright) {
		O.listDiv02.style.cssFloat = "left";
		O.listDiv02.style.styleFloat = "left";
		O.listDiv02.style.overflow = "hidden"
	};
	O.listDiv02.style.zoom = "1";
	sina.addEvent(O.scrollContDiv, "mouseover", function() {
		l.stop()
	});
	sina.addEvent(O.scrollContDiv, "mouseout", function() {
		l.play()
	});
	if(O.arrLeftId) {
		O.arrLeftObj = sina.$(O.arrLeftId);
		if(O.arrLeftObj) {
			sina.addEvent(O.arrLeftObj, "mousedown", function() {
				l.rightMouseDown()
			});
			sina.addEvent(O.arrLeftObj, "mouseup", function() {
				l.rightEnd()
			});
			sina.addEvent(O.arrLeftObj, "mouseout", function() {
				l.rightEnd()
			})
		}
	};
	if(O.arrRightId) {
		O.arrRightObj = sina.$(O.arrRightId);
		if(O.arrRightObj) {
			sina.addEvent(O.arrRightObj, "mousedown", function() {
				l.leftMouseDown()
			});
			sina.addEvent(O.arrRightObj, "mouseup", function() {
				l.leftEnd()
			});
			sina.addEvent(O.arrRightObj, "mouseout", function() {
				l.leftEnd()
			})
		}
	};
	if(O.dotListId) {
		O.dotListObj = sina.$(O.dotListId);
		O.dotListObj.innerHTML = "";
		if(O.dotListObj) {
			var I = Math.round(O.listDiv01[O.upright ? 'offsetHeight' : 'offsetWidth'] / O.frameWidth + 0.4),
				o, i;
			for(o = 0; o < I; o++) {
				i = document.createElement("span");
				O.dotListObj.appendChild(i);
				O.dotObjArr.push(i);
				if(o == O.pageIndex) {
					i.className = O.dotOnClassName
				} else {
					i.className = O.dotClassName
				};
				if(O.listType == 'number') {
					i.innerHTML = o + 1
				};
				i.title = "第" + (o + 1) + "页";
				i.num = o;
				i[O.listEvent] = function() {
					l.pageTo(this.num)
				}
			}
		}
	};
	O.scrollContDiv[O.upright ? 'scrollTop' : 'scrollLeft'] = 0;
	if(O.autoPlay) {
		O.play()
	}
};
ScrollPic.prototype.leftMouseDown = function() {
	if(this._state != "ready") {
		return
	};
	var thisTemp = this;
	this._state = "floating";
	this._scrollTimeObj = setInterval(function() {
		thisTemp.moveLeft()
	}, this.speed)
};
ScrollPic.prototype.rightMouseDown = function() {
	if(this._state != "ready") {
		return
	};
	var thisTemp = this;
	this._state = "floating";
	this._scrollTimeObj = setInterval(function() {
		thisTemp.moveRight()
	}, this.speed)
};
ScrollPic.prototype.moveLeft = function() {
	var i = this;
	if(i.circularly) {
		if(i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] + i.space >= i.listDiv01[(i.upright ? 'scrollHeight' : 'scrollWidth')]) {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] = i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] + i.space - i.listDiv01[(i.upright ? 'scrollHeight' : 'scrollWidth')]
		} else {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] += i.space
		}
	} else {
		if(i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] + i.space >= i.listDiv01[(i.upright ? 'scrollHeight' : 'scrollWidth')] - i.frameWidth) {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] = i.listDiv01[(i.upright ? 'scrollHeight' : 'scrollWidth')] - i.frameWidth;
			i.leftEnd()
		} else {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] += i.space
		}
	};
	i.accountPageIndex()
};
ScrollPic.prototype.moveRight = function() {
	var i = this;
	if(i.circularly) {
		if(i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] - i.space <= 0) {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] = i.listDiv01[(i.upright ? 'scrollHeight' : 'scrollWidth')] + i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] - i.space
		} else {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] -= i.space
		}
	} else {
		if(i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] - i.space <= 0) {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] = 0;
			i.rightEnd()
		} else {
			i.scrollContDiv[(i.upright ? 'scrollTop' : 'scrollLeft')] -= i.space
		}
	};
	i.accountPageIndex()
};
ScrollPic.prototype.leftEnd = function() {
	var I = this;
	if(I._state != "floating") {
		return
	};
	I._state = "stoping";
	clearInterval(I._scrollTimeObj);
	var i = I.pageWidth - I.scrollContDiv[(I.upright ? 'scrollTop' : 'scrollLeft')] % I.pageWidth;
	I.move(i)
};
ScrollPic.prototype.rightEnd = function() {
	var I = this;
	if(I._state != "floating") {
		return
	};
	I._state = "stoping";
	clearInterval(I._scrollTimeObj);
	var i = -I.scrollContDiv[(I.upright ? 'scrollTop' : 'scrollLeft')] % I.pageWidth;
	I.move(i)
};
ScrollPic.prototype.move = function(num, quick) {
	var thisTemp = this,
		thisMove = num / 5;
	if(!quick) {
		if(thisMove > this.space) {
			thisMove = this.space
		};
		if(thisMove < -this.space) {
			thisMove = -this.space
		}
	};
	if(Math.abs(thisMove) < 1 && thisMove != 0) {
		thisMove = thisMove >= 0 ? 1 : -1
	} else {
		thisMove = Math.round(thisMove)
	};
	var temp = this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] + thisMove;
	if(thisMove > 0) {
		if(this.circularly) {
			if(this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] + thisMove >= this.listDiv01[(this.upright ? 'scrollHeight' : 'scrollWidth')]) {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] = this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] + thisMove - this.listDiv01[(this.upright ? 'scrollHeight' : 'scrollWidth')]
			} else {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] += thisMove
			}
		} else {
			if(this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] + thisMove >= this.listDiv01[(this.upright ? 'scrollHeight' : 'scrollWidth')] - this.frameWidth) {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] = this.listDiv01[(this.upright ? 'scrollHeight' : 'scrollWidth')] - this.frameWidth;
				this._state = "ready";
				return
			} else {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] += thisMove
			}
		}
	} else {
		if(this.circularly) {
			if(this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] + thisMove < 0) {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] = this.listDiv01[(this.upright ? 'scrollHeight' : 'scrollWidth')] + this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] + thisMove
			} else {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] += thisMove
			}
		} else {
			if(this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] - thisMove < 0) {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] = 0;
				this._state = "ready";
				return
			} else {
				this.scrollContDiv[(this.upright ? 'scrollTop' : 'scrollLeft')] += thisMove
			}
		}
	};
	num -= thisMove;
	if(Math.abs(num) == 0) {
		this._state = "ready";
		if(this.autoPlay) {
			this.play()
		};
		this.accountPageIndex();
		return
	} else {
		this.accountPageIndex();
		this._scrollTimeObj = setTimeout(function() {
			thisTemp.move(num, quick)
		}, this.speed)
	}
};
ScrollPic.prototype.pre = function() {
	var i = this;
	if(i._state != "ready") {
		return
	};
	i._state = "stoping";
	i.move(-i.pageWidth, true)
};
ScrollPic.prototype.next = function(i) {
	var I = this;
	if(I._state != "ready") {
		return
	};
	I._state = "stoping";
	if(I.circularly) {
		I.move(I.pageWidth, true)
	} else {
		if(I.scrollContDiv[(I.upright ? 'scrollTop' : 'scrollLeft')] >= I.listDiv01[(I.upright ? 'scrollHeight' : 'scrollWidth')] - I.frameWidth) {
			I._state = "ready";
			if(i) {
				I.pageTo(0)
			}
		} else {
			I.move(I.pageWidth, true)
		}
	}
};
ScrollPic.prototype.play = function() {
	var thisTemp = this;
	if(!this.autoPlay) {
		return
	};
	clearInterval(this._autoTimeObj);
	this._autoTimeObj = setInterval(function() {
		thisTemp.next(true)
	}, this.autoPlayTime * 1000)
};
ScrollPic.prototype.stop = function() {
	clearInterval(this._autoTimeObj)
};
ScrollPic.prototype.pageTo = function(i) {
	var l = this;
	if(l.pageIndex == i) {
		return
	};
	clearTimeout(l._scrollTimeObj);
	l._state = "stoping";
	var I = i * l.frameWidth - l.scrollContDiv[(l.upright ? 'scrollTop' : 'scrollLeft')];
	l.move(I, true)
};
ScrollPic.prototype.accountPageIndex = function() {
	var I = this,
		i = Math.round(I.scrollContDiv[(I.upright ? 'scrollTop' : 'scrollLeft')] / I.frameWidth);
	if(i == I.pageIndex) {
		return
	};
	I.pageIndex = i;
	if(I.pageIndex > Math.round(I.listDiv01[I.upright ? 'offsetHeight' : 'offsetWidth'] / I.frameWidth + 0.4) - 1) {
		I.pageIndex = 0
	};
	var l;
	for(l = 0; l < I.dotObjArr.length; l++) {
		if(l == I.pageIndex) {
			I.dotObjArr[l].className = I.dotOnClassName
		} else {
			I.dotObjArr[l].className = I.dotClassName
		}
	}
};

//焦点图构造函数 071221 mengjia
function FocusPic(BigPicID, SmallPicsID, TitleID, MemoID, width, height) {
	this.Data = [];
	this.ImgLoad = [];
	this.TimeOut = 5000;
	var isIE = navigator.appVersion.indexOf("MSIE") != -1 ? true : false;
	this.width = width;
	this.height = height;
	this.adNum = 0;
	var TimeOutObj;
	if(!FocusPic.childs) {
		FocusPic.childs = []
	};
	this.showTime = null;
	this.showSum = 10;
	this.ID = FocusPic.childs.push(this) - 1;
	this.listCode = '<span><a href="[$url]" target="_blank"><img src="[$pic]" onmouseover="FocusPic.childs[[$thisId]].select([$num])" alt="[$title]" /></a></span>';
	this.Add = function(BigPic, SmallPic, Title, Url, Memo) {
		var ls;
		this.Data.push([BigPic, SmallPic, Title, Url, Memo]);
		ls = this.ImgLoad.length;
		this.ImgLoad.push(new Image);
		this.ImgLoad[ls].src = BigPic
	};
	this.TimeOutBegin = function() {
		clearInterval(TimeOutObj);
		TimeOutObj = setInterval("FocusPic.childs[" + this.ID + "].next()", this.TimeOut)
	};
	this.TimeOutEnd = function() {
		clearInterval(TimeOutObj)
	};
	this.select = function(num) {
		if(num > this.Data.length - 1) {
			return
		};
		if(num == this.adNum) {
			return
		};
		this.TimeOutBegin();
		if(BigPicID) {
			if(this.$(BigPicID)) {
				var aObj = this.$(BigPicID).getElementsByTagName("a")[0];
				aObj.href = this.Data[num][2];
				if(this.aImgY) {
					this.aImgY.style.display = 'none';
					this.aImg.style.zIndex = 0
				};
				this.aImgY = this.$('F' + this.ID + 'BF' + this.adNum);
				this.aImg = this.$('F' + this.ID + 'BF' + num);
				clearTimeout(this.showTime);
				this.showSum = 10;
				this.showTime = setTimeout("FocusPic.childs[" + this.ID + "].show()", 50)
			}
		};
		if(TitleID) {
			if(this.$(TitleID)) {
				this.$(TitleID).innerHTML = "<a href=\"" + this.Data[num][2] + "\" target=\"_blank\">" + this.Data[num][3] + "</a>"
			}
		};
		if(MemoID) {
			if(this.$(MemoID)) {
				this.$(MemoID).innerHTML = this.Data[num][4]
			}
		};
		if(SmallPicsID) {
			if(this.$(SmallPicsID)) {
				var sImg = this.$(SmallPicsID).getElementsByTagName("span"),
					i;
				for(i = 0; i < sImg.length; i++) {
					if(i == num || num == (i - this.Data.length)) {
						sImg[i].className = "selected"
					} else {
						sImg[i].className = ""
					}
				}
			}
		};
		if(this.onselect) {
			this.onselect()
		};
		this.adNum = num
	};
	var absPosition = function(obj, parentObj) {
		var left = obj.offsetLeft,
			top = obj.offsetTop,
			tempObj = obj;
		while(tempObj.id != document.body & tempObj.id != document.documentElement & tempObj != parentObj) {
			tempObj = tempObj.offsetParent;
			left += tempObj.offsetLeft;
			top += tempObj.offsetTop
		};
		return {
			left: left,
			top: top
		}
	};
	this.show = function() {
		this.showSum--;
		if(this.aImgY) {
			this.aImgY.style.display = 'block'
		};
		this.aImg.style.display = 'block';
		if(isIE) {
			this.aImg.style.filter = "alpha(opacity=0)";
			this.aImg.style.filter = "alpha(opacity=" + (10 - this.showSum) * 10 + ")"
		} else {
			this.aImg.style.opacity = 0;
			this.aImg.style.opacity = (10 - this.showSum) * 0.1
		};
		if(this.showSum <= 0) {
			if(this.aImgY) {
				this.aImgY.style.display = 'none'
			};
			this.aImg.style.zIndex = 0;
			this.aImgY = null
		} else {
			this.aImg.style.zIndex = 2;
			this.showTime = setTimeout("FocusPic.childs[" + this.ID + "].show()", 50)
		}
	};
	this.next = function() {
		var temp = this.adNum;
		temp++;
		if(temp >= this.Data.length) {
			temp = 0
		};
		this.select(temp)
	};
	this.pre = function() {
		var temp = this.adNum;
		temp--;
		if(temp < 0) {
			temp = this.Data.length - 1
		};
		this.select(temp)
	};
	this.MInStopEvent = function(ObjID) {
		if(ObjID) {
			if(this.$(ObjID)) {
				if(this.$(ObjID).attachEvent) {
					this.$(ObjID).attachEvent("onmouseover", Function("FocusPic.childs[" + this.ID + "].TimeOutEnd()"));
					this.$(ObjID).attachEvent("onmouseout", Function("FocusPic.childs[" + this.ID + "].TimeOutBegin()"))
				} else {
					this.$(ObjID).addEventListener("mouseover", Function("FocusPic.childs[" + this.ID + "].TimeOutEnd()"), false);
					this.$(ObjID).addEventListener("mouseout", Function("FocusPic.childs[" + this.ID + "].TimeOutBegin()"), false)
				}
			}
		}
	};
	this.begin = function() {
		this.MInStopEvent(TitleID);
		this.MInStopEvent(SmallPicsID);
		this.MInStopEvent(BigPicID);
		this.adNum = -1;
		var i, temp = "";
		if(BigPicID) {
			if(this.$(BigPicID)) {
				var aObj = this.$(BigPicID).getElementsByTagName("a")[0];
				aObj.style.zoom = 1;
				this.$(BigPicID).style.position = "relative";
				this.$(BigPicID).style.zoom = 1;
				this.$(BigPicID).style.overflow = "hidden";
				for(i = 0; i < this.Data.length; i++) {
					temp += '<img src="' + this.Data[i][0] + '" id="F' + this.ID + 'BF' + i + '" style="display:' + (i == 0 ? 'block' : 'none') + '" galleryimg="no"' + (this.width ? ' width="' + this.width + '"' : '') + (this.height ? ' height="' + this.height + '"' : '') + ' alt="' + this.Data[i][3] + '" />'
				};
				aObj.innerHTML = temp;
				var imgObjs = aObj.getElementsByTagName("img"),
					XY = absPosition(imgObjs[0], this.$(BigPicID));
				for(i = 0; i < imgObjs.length; i++) {
					imgObjs[i].style.position = "absolute";
					imgObjs[i].style.top = XY.top + "px";
					imgObjs[i].style.left = XY.left + "px"
				}
			}
		};
		if(SmallPicsID) {
			if(this.$(SmallPicsID)) {
				tempHTML = "";
				for(i = 0; i < this.Data.length; i++) {
					temp = this.listCode;
					temp = temp.replace(/\[\$url\]/ig, this.Data[i][2]);
					temp = temp.replace(/\[\$pic\]/ig, this.Data[i][1]);
					temp = temp.replace(/\[\$thisId\]/ig, this.ID);
					temp = temp.replace(/\[\$num\]/ig, i);
					temp = temp.replace(/\[\$num\+1\]/ig, i + 1);
					temp = temp.replace(/\[\$title\]/ig, this.Data[i][3]);
					tempHTML += temp
				};
				this.$(SmallPicsID).innerHTML = tempHTML
			}
		};
		this.TimeOutBegin();
		this.select(0)
	};
	this.$ = function(objName) {
		if(document.getElementById) {
			return eval('document.getElementById("' + objName + '")')
		} else {
			return eval('document.all.' + objName)
		}
	}
};


/*
舌签构造函数
SubShowClass(ID[, eventType][, defaultID][, openClassName][, closeClassName])
version 1.30
	
	* */

function SubShowClass(ID, eventType, defaultID, openClassName, closeClassName) {
	this.parentObj = SubShowClass.$(ID);
	if(this.parentObj == null && ID != "none") {
		throw new Error("SubShowClass(ID)参数错误:ID 对像不存在!(value:" + ID + ")")
	};
	if(!SubShowClass.childs) {
		SubShowClass.childs = []
	};
	this.ID = SubShowClass.childs.length;
	SubShowClass.childs.push(this);
	this.lock = false;
	this.label = [];
	this.defaultID = defaultID == null ? 0 : defaultID;
	this.selectedIndex = this.defaultID;
	this.openClassName = openClassName == null ? "selected" : openClassName;
	this.closeClassName = closeClassName == null ? "" : closeClassName;
	this.mouseIn = false;
	var mouseInFunc = Function("SubShowClass.childs[" + this.ID + "].mouseIn = true"),
		mouseOutFunc = Function("SubShowClass.childs[" + this.ID + "].mouseIn = false");
	if(ID != "none") {
		if(this.parentObj.attachEvent) {
			this.parentObj.attachEvent("onmouseover", mouseInFunc)
		} else {
			this.parentObj.addEventListener("mouseover", mouseInFunc, false)
		}
	};
	if(ID != "none") {
		if(this.parentObj.attachEvent) {
			this.parentObj.attachEvent("onmouseout", mouseOutFunc)
		} else {
			this.parentObj.addEventListener("mouseout", mouseOutFunc, false)
		}
	};
	if(typeof(eventType) != "string") {
		eventType = "onmousedown"
	};
	eventType = eventType.toLowerCase();
	switch(eventType) {
		case "onmouseover":
			this.eventType = "mouseover";
			break;
		case "onmouseout":
			this.eventType = "mouseout";
			break;
		case "onclick":
			this.eventType = "click";
			break;
		case "onmouseup":
			this.eventType = "mouseup";
			break;
		default:
			this.eventType = "mousedown"
	};
	this.autoPlay = false;
	this.autoPlayTimeObj = null;
	this.spaceTime = 5000
};
SubShowClass.prototype.version = "1.30";
SubShowClass.prototype.author = "mengjia";
SubShowClass.prototype.addLabel = function(labelID, contID, parentBg, springEvent, blurEvent) {
	if(SubShowClass.$(labelID) == null && labelID != "none") {
		throw new Error("addLabel(labelID)参数错误:labelID 对像不存在!(value:" + labelID + ")")
	};
	var TempID = this.label.length;
	if(parentBg == "") {
		parentBg = null
	};
	this.label.push([labelID, contID, parentBg, springEvent, blurEvent]);
	var tempFunc = Function('SubShowClass.childs[' + this.ID + '].select(' + TempID + ')');
	if(labelID != "none") {
		if(SubShowClass.$(labelID).attachEvent) {
			SubShowClass.$(labelID).attachEvent("on" + this.eventType, tempFunc)
		} else {
			SubShowClass.$(labelID).addEventListener(this.eventType, tempFunc, false)
		}
	};
	if(TempID == this.defaultID) {
		if(labelID != "none") {
			SubShowClass.$(labelID).className = this.openClassName
		};
		if(SubShowClass.$(contID)) {
			SubShowClass.$(contID).style.display = ""
		};
		if(this.ID != "none") {
			if(parentBg != null) {
				this.parentObj.style.background = parentBg
			}
		};
		if(springEvent != null) {
			eval(springEvent)
		}
	} else {
		if(labelID != "none") {
			SubShowClass.$(labelID).className = this.closeClassName
		};
		if(SubShowClass.$(contID)) {
			SubShowClass.$(contID).style.display = "none"
		}
	};
	var mouseInFunc = Function("SubShowClass.childs[" + this.ID + "].mouseIn = true"),
		mouseOutFunc = Function("SubShowClass.childs[" + this.ID + "].mouseIn = false");
	if(SubShowClass.$(contID)) {
		if(SubShowClass.$(contID).attachEvent) {
			SubShowClass.$(contID).attachEvent("onmouseover", mouseInFunc)
		} else {
			SubShowClass.$(contID).addEventListener("mouseover", mouseInFunc, false)
		};
		if(SubShowClass.$(contID).attachEvent) {
			SubShowClass.$(contID).attachEvent("onmouseout", mouseOutFunc)
		} else {
			SubShowClass.$(contID).addEventListener("mouseout", mouseOutFunc, false)
		}
	}
};
SubShowClass.prototype.select = function(num, force) {
	if(typeof(num) != "number") {
		throw new Error("select(num)参数错误:num 不是 number 类型!(value:" + num + ")")
	};
	if(force != true && this.selectedIndex == num) {
		return
	};
	var i;
	for(i = 0; i < this.label.length; i++) {
		if(i == num) {
			if(this.label[i][0] != "none") {
				SubShowClass.$(this.label[i][0]).className = this.openClassName
			};
			if(SubShowClass.$(this.label[i][1])) {
				SubShowClass.$(this.label[i][1]).style.display = ""
			};
			if(this.ID != "none") {
				if(this.label[i][2] != null) {
					this.parentObj.style.background = this.label[i][2]
				}
			};
			if(this.label[i][3] != null) {
				eval(this.label[i][3])
			}
		} else if(this.selectedIndex == i || force == true) {
			if(this.label[i][0] != "none") {
				SubShowClass.$(this.label[i][0]).className = this.closeClassName
			};
			if(SubShowClass.$(this.label[i][1])) {
				SubShowClass.$(this.label[i][1]).style.display = "none"
			};
			if(this.label[i][4] != null) {
				eval(this.label[i][4])
			}
		}
	};
	this.selectedIndex = num
};
SubShowClass.prototype.random = function() {
	var O = this;
	if(arguments.length != O.label.length) {
		throw new Error("random()参数错误:参数数量与标签数量不符!(length:" + arguments.length + ")")
	};
	var l = 0,
		o;
	for(o = 0; o < arguments.length; o++) {
		l += arguments[o]
	};
	var I = Math.random(),
		i = 0;
	for(o = 0; o < arguments.length; o++) {
		i += arguments[o] / l;
		if(I < i) {
			O.select(o);
			break
		}
	}
};
SubShowClass.prototype.order = function() {
	var O = this;
	if(arguments.length != O.label.length) {
		throw new Error("order()参数错误:参数数量与标签数量不符!(length:" + arguments.length + ")")
	};
	if(!(/^\d+$/).test(SubShowClass.sum)) {
		return
	};
	var i = 0,
		o;
	for(o = 0; o < arguments.length; o++) {
		i += arguments[o]
	};
	var I = SubShowClass.sum % i;
	if(I == 0) {
		I = i
	};
	var l = 0;
	for(o = 0; o < arguments.length; o++) {
		l += arguments[o];
		if(l >= I) {
			O.select(o);
			break
		}
	}
};
SubShowClass.prototype.play = function(spTime) {
	if(typeof(spTime) == "number") {
		this.spaceTime = spTime
	};
	clearInterval(this.autoPlayTimeObj);
	this.autoPlayTimeObj = setInterval("SubShowClass.childs[" + this.ID + "].autoPlayFunc()", this.spaceTime);
	this.autoPlay = true
};
SubShowClass.prototype.autoPlayFunc = function() {
	var i = this;
	if(i.autoPlay == false || i.mouseIn == true) {
		return
	};
	i.nextLabel()
};
SubShowClass.prototype.nextLabel = function() {
	var index = this.selectedIndex;
	index++;
	if(index >= this.label.length) {
		index = 0
	};
	this.select(index);
	if(this.autoPlay == true) {
		clearInterval(this.autoPlayTimeObj);
		this.autoPlayTimeObj = setInterval("SubShowClass.childs[" + this.ID + "].autoPlayFunc()", this.spaceTime)
	}
};
SubShowClass.prototype.previousLabel = function() {
	var index = this.selectedIndex;
	index--;
	if(index < 0) {
		index = this.label.length - 1
	};
	this.select(index);
	if(this.autoPlay == true) {
		clearInterval(this.autoPlayTimeObj);
		this.autoPlayTimeObj = setInterval("SubShowClass.childs[" + this.ID + "].autoPlayFunc()", this.spaceTime)
	}
};
SubShowClass.prototype.stop = function() {
	var i = this;
	clearInterval(i.autoPlayTimeObj);
	i.autoPlay = false
};
SubShowClass.$ = function(objName) {
	if(document.getElementById) {
		return eval('document.getElementById("' + objName + '")')
	} else {
		return eval('document.all.' + objName)
	}
};
SubShowClass.readCookie = function(O) {
	var o = "",
		l = O + "=";
	if(document.cookie.length > 0) {
		var i = document.cookie.indexOf(l);
		if(i != -1) {
			i += l.length;
			var I = document.cookie.indexOf(";", i);
			if(I == -1) I = document.cookie.length;
			o = unescape(document.cookie.substring(i, I))
		}
	};
	return o
};
SubShowClass.writeCookie = function(i, l, o, c) {
	var O = "",
		I = "";
	if(o != null) {
		O = new Date((new Date).getTime() + o * 3600000);
		O = "; expires=" + O.toGMTString()
	};
	if(c != null) {
		I = ";domain=" + c
	};
	document.cookie = i + "=" + escape(l) + O + I
};
SubShowClass.sum = SubShowClass.readCookie("SSCSum");
if((/^\d+$/).test(SubShowClass.sum)) {
	SubShowClass.sum++
} else {
	SubShowClass.sum = 1
};
SubShowClass.writeCookie("SSCSum", SubShowClass.sum, 12);