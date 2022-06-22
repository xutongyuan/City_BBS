package ssm;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import ssm.po.Friend;
import ssm.po.Integration;
import ssm.po.Message;
import ssm.po.News;
import ssm.po.PassSecurity;
import ssm.po.Userdetail;
import ssm.po.Users;
import ssm.po.readonly.IntegrationUsersRead;
import ssm.po.readonly.MessageRead;
import ssm.po.readonly.ThemeBackRead;
import ssm.po.readonly.ThemeRead;
import ssm.po.readonly.Theme_BackRead;
import ssm.po.readonly.UsersInfo;
import ssm.service.LoginService;
import ssm.util.converter.DateConverter;
import ssm.util.converter.Md5Utils;

@Controller
@RequestMapping("user")
public class UserCtr {

	@Autowired
	LoginService loginSer;
	
	
	//验证邮箱是否被使用
	@RequestMapping("/avilemail")
	@ResponseBody
	public Map<String, String> avilemail(String email){
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		Users users = loginSer.findUserByEmail(email);
		if(users==null){
			map.put("res", "success");
		}else {
			map.put("res", "fail");
		}	
		return map;
	}
	
	/*
	 * 注册功能
	 * */
	@RequestMapping("/register")
	@ResponseBody
	public boolean addUser(Users u,Userdetail ud)
	{
		String ran ="cz"+(int)Math.floor(Math.random()*10000);	//用户id
		String md5Str = Md5Utils.md5(u.getPassword());
		System.out.println("md5密码值："+md5Str);
		
		String ramString = "chaozhou";
		String md5Pass =  Md5Utils.md5(md5Str+ramString);
		
		u.setUserId(ran);
		u.setPassword(md5Pass);
//		u.setPmsArea(01);
		u.setRegisterTime(new DateConverter().toString(new Date()));
		u.setRoleId(3);
		u.setPmsArea("1");
		ud.setUserId(ran);
		ud.setImage("images/user/avatar/tx006.jpg");
		ud.setSex("男");
		
		
		Integration integration = new Integration();
		integration.setUserId(ran);
		integration.setOnlineTime(0);
		integration.setPostNum(0);
		integration.setBackNum(0);
		integration.setGoodPostNum(0);
		
		int row = loginSer.saveUser(u, ud,integration);

		if(row>0){
			System.out.println("添加用户成功");
			return true;
		}else {
			return false;
		}
		
	}
	
	
	/*
	 * 登录
	 * */
	@RequestMapping("/login")
	@ResponseBody
	public Map<String, String> toLogin(Users u,String addCookie, String autoLogin,
			HttpServletRequest request,HttpServletResponse response){
		
		String md5Str = Md5Utils.md5(u.getPassword());
		String ramString = "chaozhou";
		String md5Pass =  Md5Utils.md5(md5Str+ramString);
		u.setPassword(md5Pass);
		Users user = loginSer.findUser(u);
		System.out.println(addCookie+autoLogin);
		Map<String, String> map = new HashMap<>();
		if(user==null){
			map.put("err", "false");
			return map;
		}else{
			map.put("err", "true");
			request.getSession().setAttribute("data", user);
			if(addCookie.equals("true")){
				Cookie cUserName = new Cookie("userName", user.getEmail());
				cUserName.setMaxAge(7*24*60*60);
				cUserName.setPath("/");
				response.addCookie(cUserName);
		
				
				Cookie cPassWord = new Cookie("passWord", user.getPassword());
				cPassWord.setMaxAge(7*24*60*60);
				cPassWord.setPath("/");
				response.addCookie(cPassWord);
				
				Cookie cAutoLogin = null;
				if(autoLogin.equals("true")){
					cAutoLogin = new Cookie("autoLogin", "on");
				}else{
					cAutoLogin = new Cookie("autoLogin", "off");
				}
				cAutoLogin.setMaxAge(7*24*60*60);
				cAutoLogin.setPath("/");
				response.addCookie(cAutoLogin);

			}
			return map;
		}
	}
	
	@RequestMapping("/autoLogin")
	public void autoLogin(Users u,HttpServletRequest request,HttpServletResponse response){
		
		Users user = loginSer.findUser(u);

		if(user==null){

		}else{
			request.getSession().setAttribute("data", user);
				
		}
		
	}
	//跳转个人信息
	@RequestMapping("/userinfo")
	public ModelAndView getUserinfo(Users u,HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		Users user = (Users) request.getSession().getAttribute("data");
		
		if(user!=null){
			UsersInfo usersInfo = new UsersInfo();
			usersInfo.setUserId(user.getUserId());
			UsersInfo usersInfo2 = loginSer.findUsersInfo(usersInfo);
			request.getSession().setAttribute("usersInfo", usersInfo2);
			
			Integration integration = loginSer.findIntegration(user.getUserId());
			request.getSession().setAttribute("integration", integration);
			
			PassSecurity passSecurity = loginSer.findPassSecurity(user.getUserId());
			mav.addObject("passSecurity", passSecurity);
			
		}
		mav.setViewName("user/userinfo");
		return mav;
	}
	
	//修改个人信息
	@RequestMapping("/modifyUserinfo")
	@ResponseBody
	public Map<String, String> modifyUserinfo(Userdetail userdetail,HttpServletRequest request){
		Map<String ,String> map = new HashMap<>();
		if(userdetail.getSignature().length()>100){
			map.put("result", "个性签名字数不能超过100！");
			return map;
		}else if(userdetail.getNickname().length()>30){
			map.put("result", "昵称不能超过30！");
			return map;
		}
		int rows = loginSer.updateUserDetail(userdetail);
		if(rows>0){
			map.put("result", "更新成功！");
			return map;
			}
		else {
			map.put("result", "更新失败，请重新操作");
			return map;
		}
	}
	
	//修改密码
	@RequestMapping("/modifyPassword")
	@ResponseBody
	public Map<String, String> modifyPassword(Users user,String newPassword,HttpServletRequest request){
		Map<String ,String> map = new HashMap<>();
		Users u = (Users) request.getSession().getAttribute("data");
		user.setUserId(u.getUserId());
		//md5加盐验证
		String md5Str = Md5Utils.md5(user.getPassword());
		String ramString = "chaozhou";
		String md5Pass =  Md5Utils.md5(md5Str+ramString);
		user.setPassword(md5Pass);
		
		Users user2 = loginSer.findUser(user);
		if(user2!=null){
			String md5Str2 = Md5Utils.md5(newPassword);
			String ramString2 = "chaozhou";
			String md5Pass2 =  Md5Utils.md5(md5Str2+ramString2);
			user.setPassword(md5Pass2);
			
			int rows = loginSer.updateUser(user);
			if(rows>0){
				map.put("result", "修改成功,请重新登录");
			}else{
				map.put("result", "修改失败");
			}
		}else{
			map.put("result", "原始密码输入错误");
		}
		return map;
		}
		
		//新增或修改密保
	@RequestMapping("/passSecurity")
	@ResponseBody
	public Map<String, String> passSecurity(PassSecurity passSecurity,HttpServletRequest request){
		Users user = (Users) request.getSession().getAttribute("data");
		Map<String ,String> map = new HashMap<>();
		PassSecurity passSecurity2 = loginSer.findPassSecurity(user.getUserId());
		if(passSecurity2==null){	//新增
			passSecurity.setUserId(user.getUserId());
			int rows = loginSer.insertPassSecurity(passSecurity);
			if(rows>0){
				map.put("result", "添加密保成功");
			}else{
				map.put("result", "添加密保失败");
			}
		}else{		//更新
			passSecurity.setId(passSecurity2.getId());
			passSecurity.setUserId(passSecurity2.getUserId());
			int rows = loginSer.updatePassSecurity(passSecurity);
			if(rows>0){
				map.put("result", "修改密保成功");
			}else{
				map.put("result", "修改密保失败");
			}
		}
		return map;
	}
	//忘记密码验证
	@RequestMapping("/checkPassSecurity")
	@ResponseBody
	public Map<String, Object> checkPassSecurity(String email,HttpServletRequest request){
		Map<String ,Object> map = new HashMap<>();
		Users user = loginSer.findUserId(email);
		if(user==null){
			map.put("status", "fail");
		}else{
			PassSecurity pasSecurity = loginSer.findPassSecurityQuest(user.getUserId());
			if(pasSecurity!=null){
				map.put("status", "success");
				map.put("quest1", pasSecurity.getQuestion1());
				map.put("quest2", pasSecurity.getQuestion2());
				request.getSession().setAttribute("checkUserId", user.getUserId());//申诉的用户id
			}else{
				map.put("status", "result is null");
			}
		}
		return map;
	}
	
	//提交密码验证
	@RequestMapping("/postPassSecurity")
	@ResponseBody
	public Map<String, Object> postPassSecurity(PassSecurity passSecurity,HttpServletRequest request){
		Map<String ,Object> map = new HashMap<>();
		String checkUserId =  (String) request.getSession().getAttribute("checkUserId");
		passSecurity.setUserId(checkUserId);
		PassSecurity passSecurity2 = loginSer.findPassSecurityRecord(passSecurity);
		if(passSecurity2==null){
			map.put("status", "fail");
		}else{
			map.put("status", "success");
		}
		return map;
	}
	//申诉密码修改
		@RequestMapping("/postNewPass")
		@ResponseBody
		public Map<String, Object> postNewPass(Users user,HttpServletRequest request){
			Map<String ,Object> map = new HashMap<>();
			String checkUserId =  (String) request.getSession().getAttribute("checkUserId");
			
			String md5Str = Md5Utils.md5(user.getPassword());
			String ramString = "chaozhou";
			String md5Pass =  Md5Utils.md5(md5Str+ramString);
			user.setPassword(md5Pass);
			
			user.setUserId(checkUserId);
			int rows = loginSer.updateUser(user);
			if(rows<=0){
				map.put("status", "fail");
			}else{
				map.put("status", "success");
			}
			return map;
		}
	//修改头像
	@RequestMapping("/modifyAvator")
	@ResponseBody
	public Map<String, String> modifyAvator(String imgSrc,HttpServletRequest request){
		Users user = (Users) request.getSession().getAttribute("data");
		Map<String ,String> map = new HashMap<>();
		Userdetail userdetail = new Userdetail();
		userdetail.setUserId(user.getUserId());
		userdetail.setImage(imgSrc);;
		int rows = loginSer.updateUserDetail(userdetail);
		if(rows>0){
			map.put("result", "修改头像成功");
		}else{
			map.put("result", "修改头像失败，请联系管理员或重试");
		}
		return map;
	}
	
	//查看其它人信息
	@RequestMapping("/otherUser")
	public ModelAndView otherUser(String userId,@RequestParam(defaultValue="1")Integer pageIndex){
		ModelAndView mav = new ModelAndView();
	

		IntegrationUsersRead iUsersRead  = loginSer.findIntegrationUsersRead(userId);
		if(iUsersRead!=null){
			mav.addObject("iudata", iUsersRead);
		}
		//他的发帖
		PageHelper.startPage(pageIndex, 5);
		Page<ThemeRead> tu = (Page<ThemeRead>)loginSer.findThemeReadByuserId(userId);
		for (ThemeRead dto:tu
			 ) {
			dto.setTitle(dto.getTitle().length()>25?dto.getTitle().substring(0,25):dto.getTitle());
			String content = dto.getContent().replaceAll("<.*?>", "");
			dto.setContent(content.length()>200?content.substring(0, 200)+"......":content);
		}
		if(tu!=null){
			mav.addObject("themelist", tu);
		}
		//他的回复
		ArrayList<Theme_BackRead> theme_BackRead = loginSer.findTheme_BackRead(userId);
		for (Theme_BackRead dto:theme_BackRead
		) {
			dto.setTitle(dto.getTitle().length()>25?dto.getTitle().substring(0,25):dto.getTitle());
			String content = dto.getContent().replaceAll("<.*?>", "");
			dto.setContent(content.length()>200?content.substring(0, 200)+"......":content);
		}
		mav.addObject("backlist", theme_BackRead);
		//他的精华帖
		ArrayList<ThemeRead> themeRead = loginSer.findThemeReadByuserIdAndGood(userId);
		for (ThemeRead dto:themeRead
		) {
			dto.setTitle(dto.getTitle().length()>25?dto.getTitle().substring(0,25):dto.getTitle());
			String content = dto.getContent().replaceAll("<.*?>", "");
			dto.setContent(content.length()>200?content.substring(0, 200)+"......":content);
		}
		mav.addObject("jinglist", themeRead);
		mav.setViewName("user/otheruser");
		return mav;
	}
	
	//查找好友
	@RequestMapping("/findfriend")
	public ModelAndView findfriend(@RequestParam(defaultValue="")String nickname,@RequestParam(defaultValue="1")Integer pageIndex){
		ModelAndView mavaAndView = new ModelAndView();
		String 	nicknameSql = "";
		if(nickname.equals("")){
			nicknameSql = "_a_ef_wge";
		}else{
			nicknameSql = "%"+nickname+"%";
		}
		
		
		PageHelper.startPage(pageIndex, 10);
		Page<Userdetail> userdetailPage =  (Page<Userdetail>) loginSer.findUserdetails(nicknameSql);
		mavaAndView.addObject("userdetailPage", userdetailPage);
		mavaAndView.setViewName("user/findfriend");
		return mavaAndView;
	}
	
	
	//好友管理
	@RequestMapping("/friendmanager")
	public ModelAndView friendmanager(@RequestParam(defaultValue="1")Integer pageIndex,HttpServletRequest request){
		ModelAndView mavaAndView = new ModelAndView();
		Users user = (Users)request.getSession().getAttribute("data");
		Page<Friend> friendPage = new Page<>();
		if(user!=null){
			PageHelper.startPage(pageIndex, 10);
			friendPage = (Page<Friend>) loginSer.findFriends(user.getUserId());
		}
		ArrayList<Friend> friends = (ArrayList<Friend>) friendPage.getResult();
		ArrayList<String> sqlpara = new ArrayList<>();
		Page<Userdetail> userdetailPage = new Page<>();
		Map<String, Object> map = new HashMap<>();
		if(friends.size()>0){
			for(int i=0;i<friends.size();i++){
				sqlpara.add(friends.get(i).getUserbId());
			}
			map.put("sqlList", sqlpara);
			
			PageHelper.startPage(pageIndex, 10);
			userdetailPage =  (Page<Userdetail>) loginSer.findUserdetails(map);
			
		}else {
			userdetailPage.setPages(1);
		}
		mavaAndView.addObject("userdetailPage", userdetailPage);
		mavaAndView.setViewName("user/friendmanager");
		return mavaAndView;
	}
	//加好友消息
	@RequestMapping("/friendaddmes")
	public ModelAndView friendaddmes(@RequestParam(defaultValue="1")Integer pageIndex,HttpServletRequest request){
		ModelAndView mavaAndView = new ModelAndView();
		Users user = (Users) request.getSession().getAttribute("data");
		
		News news = new News();
		news.setPostId(user.getUserId());
		news.setRecevId(user.getUserId());
		news.setType("F");
		
		PageHelper.startPage(pageIndex, 5);
		Page<News> postListPage  = (Page<News>)loginSer.findNewsByPostIdandType(news);

		PageInfo<News> pInfo2 = new PageInfo<>();
		PageHelper.startPage(pageIndex, 5);
		Page<News> recevListPage  = (Page<News>)loginSer.findNewsByRecevIdandType(news);
		
		if(postListPage.getPages()<recevListPage.getPages()){
			postListPage.setPages(recevListPage.getPages());
		}
		mavaAndView.addObject("postListPage", postListPage);
		mavaAndView.addObject("recevListPage", recevListPage);
		mavaAndView.setViewName("user/friendaddmes");
		return mavaAndView;
	}
	//添加好友
	@RequestMapping("/addfriend")
	@ResponseBody
	public Map<String, String> addfriend(News news){
		Map<String, String> map = new HashMap<>();
		ArrayList<News> newslist = loginSer.findNewsByPostIdandRecevId(news);
		if(newslist.size()>0){
			map.put("res", "success");
			map.put("mes", "已经提交过好友申请，请耐心等候");
			return map;
		}
		Friend friend = new Friend();
		friend.setUseraId(news.getPostId());
		friend.setUserbId(news.getRecevId());
		Friend friend2 = loginSer.findFriendByUserAB(friend);
		if(friend2!=null){
			map.put("res", "fail");
			map.put("mes", "你们已经是好友了，不能重复添加！");
			return map;
		}
		
		
		Userdetail udetail = loginSer.findUserdetail(news.getPostId());
		if(udetail!=null){
			news.setPostNickname(udetail.getNickname());
		}
		news.setLooked("N");
		news.setType("F");
		news.setTime(new DateConverter().toString(new Date()));
		int rows = loginSer.insertNews(news);
		if(rows>0){
			map.put("res","success");
			map.put("mes", "成功发送好友请求，请耐心等待");
		}else{
			map.put("res","fail");
		}
		return map;
	}	
	
	//取消好友申请
	@RequestMapping("/cancelNews")
	@ResponseBody
	public Map<String, String> cancelNews(String id){
		Map<String, String> map = new HashMap<>();
		int rows = loginSer.deleteNews(Integer.parseInt(id));
		if(rows>0){
			map.put("res", "success");
			map.put("mes", "操作成功");
		}else{
			map.put("res", "fail");
			map.put("mes", "操作失败");
		}
		return map;
	}
	//同意好友申请
	@RequestMapping("/agreeNews")
	@ResponseBody
	public Map<String, String> agreeNews(String id){
		Map<String, String> map = new HashMap<>();
		News news = new News();
		news.setId(Integer.parseInt(id));
		news.setStatus("Y");
		int rows = loginSer.updateNewsAndInsertFriend(news);
		
		if(rows>0){
			map.put("res", "success");
			map.put("mes", "成功添加好友");
		}else{
			map.put("res", "fail");
			map.put("mes", "添加好友失败");
		}
		return map;
	}
	
	//拒绝好友申请
	@RequestMapping("/rejectNews")
	@ResponseBody
	public Map<String, String> rejectNews(String id){
		Map<String, String> map = new HashMap<>();
		News news = new News();
		news.setId(Integer.parseInt(id));
		news.setStatus("N");
		int rows = loginSer.updateNews(news);
		
		if(rows>0){
			map.put("res", "success");
			map.put("mes", "已拒绝该好友申请");
		}else{
			map.put("res", "fail");
			map.put("mes", "拒绝好友申请失败");
		}
		return map;
	}
	
	//删除好友
	@RequestMapping("/deleteFriend")
	@ResponseBody
	public Map<String, String> deleteFriend(String userId,HttpSession session){
		Map<String, String> map = new HashMap<>();
		Users user = (Users) session.getAttribute("data");
		String useraId = user.getUserId();
		String userbId = userId;
		
		int rows = loginSer.deleteFriend(useraId, userbId);
		
		if(rows>0){
			map.put("res", "success");
			map.put("mes", "删除好友成功");
		}else{
			map.put("res", "fail");
			map.put("mes", "好友删除失败");
		}
		return map;
	}
	/*
	 * 站内信版块
	 * */
	
	//发送站内信
	@RequestMapping("/postmessage")
	public ModelAndView postMessage(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();

		Users user = (Users)request.getSession().getAttribute("data");
		ArrayList<Friend> friends = new ArrayList<>();
		if(user!=null){
			 friends = loginSer.findFriends(user.getUserId());
		}
		if(friends.size()==0){
			
		}else {
			ArrayList<String> sqlpara = new ArrayList<>();
			Map<String, Object> map = new HashMap<>();
			for(int i=0;i<friends.size();i++){
				sqlpara.add(friends.get(i).getUserbId());
			}
			map.put("sqlList", sqlpara);
			ArrayList<Userdetail> friendDetail =  (ArrayList<Userdetail>) loginSer.findUserdetails(map);

			request.getSession().setAttribute("friendSession", friendDetail);
		}
		
		mav.setViewName("user/postmessage");
		return mav;
		
	}
	
	@RequestMapping("/submitMess")
	@ResponseBody
	public Map<String, String> submitMess(Message mes,HttpServletRequest request){
		Users users = (Users)request.getSession().getAttribute("data");
		Map<String, String> map = new HashMap<>();
		if(users==null){
			return null;
		}
		mes.setLooked("N");
		mes.setPostmessId(users.getUserId());
		mes.setTime(new DateConverter().toString(new Date()));
		int rows = loginSer.insertMessage(mes);
		if(rows>0){
			map.put("res", "success");
			map.put("mes", "成功发送消息");
		}else {
			map.put("res", "fail");
			map.put("mes", "成功消息失败");
		}
		
		return map;
	}
	
	//收信箱
	@RequestMapping("/inbox")
	public ModelAndView inbox(@RequestParam(defaultValue="1")Integer pageIndex,HttpSession session){
		ModelAndView mav = new ModelAndView();
		Users user = (Users)session.getAttribute("data");
		PageHelper.startPage(pageIndex, 10);
		Page<MessageRead> MessageReads = (Page<MessageRead>) loginSer.findMessages(user.getUserId());
		mav.addObject("MessageReads", MessageReads);
		mav.setViewName("user/inbox");
		return mav;
		
	}
	
	@RequestMapping("/inboxTC")
	@ResponseBody
	public MessageRead inboxTC(Integer messId,@RequestParam(defaultValue="1")Integer pageIndex,HttpSession session){
		ModelAndView mav = new ModelAndView();

		MessageRead MessageRead = (MessageRead)loginSer.findMessageReadA(messId);
		Message mes = new Message();
		mes.setMessId(messId);
		mes.setLooked("Y");
		int rows = loginSer.updateLookedOfMessage(mes);
		return MessageRead;
	}
	//删除收信箱/删除发信箱
	@RequestMapping("/removeinbox")
	@ResponseBody
	public Map<String, String> removeinbox(Integer messId){
		ModelAndView mav = new ModelAndView();
		Map<String, String> map = new HashMap<>();
		int rows = loginSer.deleteMessage(messId);
		if(rows>0){
			map.put("res", "success");
			map.put("mes", "删除成功");
		}else {
			map.put("res", "fail");
			map.put("mes", "删除失败");
		}	
		return map;
	}
	
	//发信箱
	@RequestMapping("/mailbox")
	public ModelAndView mailbox(@RequestParam(defaultValue="1")Integer pageIndex,HttpSession session){
		ModelAndView mav = new ModelAndView();
		Users user = (Users)session.getAttribute("data");
		PageHelper.startPage(pageIndex, 10);
		Page<MessageRead> MessageReads = (Page<MessageRead>) loginSer.findMessageReads(user.getUserId());
		mav.addObject("MessageReads", MessageReads);
		return mav;
		
	}
	@RequestMapping("/mailboxTC")
	@ResponseBody
	public MessageRead mailboxTC(Integer messId,@RequestParam(defaultValue="1")Integer pageIndex,HttpSession session){
		ModelAndView mav = new ModelAndView();

		MessageRead MessageRead = (MessageRead)loginSer.findMessageReadB(messId);
		return MessageRead;
	}
}
