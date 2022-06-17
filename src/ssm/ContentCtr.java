package ssm;



import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sun.xml.internal.fastinfoset.algorithm.BuiltInEncodingAlgorithm.WordListener;

import ssm.mapper.UsersMapper;
import ssm.po.*;
import ssm.po.readonly.ThemeBackRead;
import ssm.po.readonly.ThemeRead;
import ssm.service.ContentService;
import ssm.util.converter.DataUtils;
import ssm.util.converter.DateConverter;
//import net.sf.json.*;

@Controller
@RequestMapping("content")
public class ContentCtr {

	@Autowired
	ContentService contentService;
	@Autowired
	UsersMapper usersMapper;

	/*
	 * 获取帖子列表*/
	@RequestMapping("/getlist")
	public ModelAndView getList(String area, @RequestParam(defaultValue="1")Integer pageIndex)
	{
		PageHelper.startPage(1, 6);
		Page<ThemeRead> tu2 = (Page<ThemeRead>) contentService.findGoodPostList(Integer.parseInt(area));

		PageHelper.startPage(pageIndex, 10);
		Page<ThemeRead> tu = (Page<ThemeRead>) contentService.findPostList(Integer.parseInt(area));

		System.out.println("后台编号"+area);
		if(area==null){
			//页面非法，跳转错误页面
		}else{
			
		}
		ModelAndView mav=new ModelAndView();
		mav.addObject("goodlist", tu2);
		mav.addObject("area", area);
		mav.addObject("postlist",tu);
		
		mav.setViewName("content/showList");
		return mav;
	}

	//版主查询
	@RequestMapping("/getOwner")
	@ResponseBody
	public Map<String, Object> getOwner(String area)
	{
		Map<String, Object> map = new HashMap<>();
		ArrayList<Userdetail> userdetail =  contentService.findUserdetailsByPmsArea(area);
		map.put("owner",userdetail );
		
		return map;
	}
	
	/*
	 * 进入主题帖*/
	@RequestMapping("/showDetail")
	@ResponseBody
	public ModelAndView getDetail(Theme theme,@RequestParam(defaultValue="1")Integer pageIndex,HttpServletRequest request)
	{
		ModelAndView mav=new ModelAndView();
		if(theme.getArea()==null){
			//页面非法，跳转错误页面
		}else{
			mav.addObject("area", theme.getArea().toString());
		}
		
		ThemeRead themeRead= new ThemeRead();
		Integration integration = new Integration();
		themeRead = contentService.findThemeContent(theme.getPostId());	//获取主题帖及用户信息

		if(pageIndex==1){	
			integration = contentService.findIntegration(theme.getUserId());	//获取积分信息
		}
		//分页获取回帖
		PageHelper.startPage(pageIndex, 10);
		Page<ThemeBackRead> tu = (Page<ThemeBackRead>) contentService.findThemeBack(theme.getPostId());
		
		//在阅读/回复表+1
		PostCount postCount = new PostCount();
		postCount.setPostId(theme.getPostId());
		postCount.setReadCount(1);
		contentService.updatePostCount(postCount);
		
		mav.addObject("themeRead",themeRead);
		if(integration!=null&&themeRead!=null&&pageIndex==1){
			mav.addObject("integration", integration);
		}
		if(tu!=null){
			mav.addObject("backList",tu);
		}
		mav.setViewName("content/showDetail");
		return mav;
	}
	
	/*
	 * param:Theme主题帖对象	
	 *发帖*/
	@RequestMapping("/submitPost")
	@ResponseBody
	public boolean submitPost(Theme theme,HttpSession session){

		Users user = new Users();
		if(session==null){
			//获取新闻哥 信息
			user = usersMapper.selectByEmail("xinwen@qq.com");
		}else{
			user = (Users)session.getAttribute("data");
		}
		theme.setContent(DataUtils.unescapeHtml4(theme.getContent()));
		if(theme.getTitle().length()>100||theme.getContent().length()>10000){
			return false;
		}

		theme.setUserId(user.getUserId());	//设置用户id,帖子id不设置则为自动增长
		theme.setGoodPost("N");
		theme.setPostingTime(new DateConverter().toString(new Date()));
		
		PostCount postCount = new PostCount();
		postCount.setReadCount(0);
		postCount.setBackCount(0);
		int rows = contentService.insertPost(theme,postCount);
		if(rows>0){
			return true;
		}else{
			return false;
		}
	}	
	
	/*
	 * param:回复贴 对象	
	 *回帖*/
	@RequestMapping("/replyPost")
	@ResponseBody
	public boolean replyPost(ThemeBack themeBack,HttpSession session){
		themeBack.setContent(DataUtils.unescapeHtml4(themeBack.getContent()));
		if(themeBack.getContent().length()>3000){
			return false;
		}
		Users user = (Users)session.getAttribute("data");
		themeBack.setUserId(user.getUserId());
		themeBack.setReplyTime(new DateConverter().toString(new Date()));
		int rows = contentService.insertPostBack(themeBack);
		if(rows>0){
			return true;
		}else{
			return false;
		}
	}
	
	//模糊搜索
	@RequestMapping("/getlistBysearch")
	public ModelAndView getListBySearch(String keyword, @RequestParam(defaultValue="1")Integer pageIndex)
	{
		ModelAndView mav=new ModelAndView();
		PageHelper.startPage(pageIndex, 8);
		String string = keyword.trim();
		String sql= string.replace(" ", "%");
		sql = "%"+sql+"%";
		Page<ThemeRead> tu = (Page<ThemeRead>) contentService.findPostListBySearch(sql);
		
	
		mav.addObject("area", "30");
		mav.addObject("postlist",tu);
		ArrayList<ThemeRead> tlArrayList = new ArrayList<>();
		tlArrayList = (ArrayList<ThemeRead>) tu.getResult();
		System.out.println("总条数"+tu.getTotal());
		
		for (ThemeRead themeRead : tlArrayList) {
			System.out.println(themeRead);
		}
		mav.setViewName("content/showList_Search");
		return mav;
	}

	//设置/取消精华帖
	@RequestMapping("/setGoodPost")
	@ResponseBody
	public Map<String, Object> setGoodPost(Theme theme,String userId){
		Map<String, Object>  map= new HashMap<>();
		
		int rows = contentService.updateTheme(theme);
		if(theme.getGoodPost().equals("Y")){
			contentService.updateIntegrationGoodAdd(userId);
		}else{
			contentService.updateIntegrationGoodSub(userId);
		}
		if(rows>0){
			map.put("result", "success");
		}else{
			map.put("result", "fail");
		}
		return map;
	}
	
	//删除帖子
	@RequestMapping("/removePost")
	@ResponseBody
	public Map<String, Object> removePost(Theme theme,String userId){
		Map<String, Object>  map= new HashMap<>();
		
		int rows = contentService.deleteTheme(theme.getPostId());
		if(theme.getGoodPost().equals("Y")){
			contentService.updateIntegrationGoodSub(userId);
		}
		int row2 = contentService.deleteThemeBackByPostId(theme.getPostId());
		if(rows>0&&row2>0){
			map.put("result", "success");
		}else{
			map.put("result", "fail");
		}
		return map;
	}
	//删除回帖
	@RequestMapping("/removeBack")
	@ResponseBody
	public Map<String, Object> removeBack(Integer backId){
		Map<String, Object>  map= new HashMap<>();
		
		int rows = contentService.deleteThemeBack(backId);
		
		if(rows>0){
			map.put("result", "success");
		}else{
			map.put("result", "fail");
		}
		return map;
	}
	//首页最近回复贴/发帖
	@RequestMapping("/getRecentBack")
	@ResponseBody
	public Map<String, Object> getRecentBack()
	{
		Map<String, Object> map = new HashMap<>();
		PageHelper.startPage(1, 10);
		Page<Theme> tu = (Page<Theme>) contentService.findRecentBack();
		ArrayList<Theme> recentBack = (ArrayList<Theme>) tu.getResult();
		map.put("recentBack",recentBack );
		
		//最近发帖
		PageHelper.startPage(1, 10);
		Page<Theme> tu1 = (Page<Theme>) contentService.findRecentPost(null);
		ArrayList<Theme> recentPost = (ArrayList<Theme>) tu1.getResult();
		map.put("recentPost",recentPost );
		return map;
	}

	@RequestMapping("/getNavPost")
	@ResponseBody
	public Map<String, Theme> getNavPost()
	{
		//最近发帖
		Map<String, Theme> map = new HashMap<>();
		PageHelper.startPage(1, 3);
		Page<Theme> tu1 = (Page<Theme>) contentService.findRecentPost("Y");
		List<Theme> navPost = (ArrayList<Theme>) tu1.getResult();
		if(navPost!=null&&navPost.size()>=3){
			map.put("navPost1",navPost.get(0) );
			map.put("navPost2",navPost.get(1) );
			map.put("navPost3",navPost.get(2) );
		}
		return map;
	}


	/**
	 *查询轮播图
	 * */
	@RequestMapping("/getBannerList")
	@ResponseBody
	public List<Banner> getBannerList()
	{
		PageHelper.startPage(1, 4);
		Page<Banner> tu1 = (Page<Banner>) contentService.findBannerList("Y");
		List<Banner> list = (ArrayList<Banner>) tu1.getResult();
		return list;
	}
	
	
	
}
