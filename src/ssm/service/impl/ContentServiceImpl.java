package ssm.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.apache.commons.lang3.StringEscapeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ssm.mapper.IntegrationMapper;
import ssm.mapper.PostCountMapper;
import ssm.mapper.ThemeBackMapper;
import ssm.mapper.ThemeMapper;
import ssm.mapper.UserdetailMapper;
import ssm.mapper.readonly.ThemeBackReadMapper;
import ssm.mapper.readonly.ThemeReadMapper;
import ssm.po.*;
import ssm.po.readonly.IntegrationUsersRead;
import ssm.po.readonly.ThemeBackRead;
import ssm.po.readonly.ThemeRead;
import ssm.service.ContentService;
@Service
public class ContentServiceImpl implements ContentService {

	@Autowired
	ThemeReadMapper themeReadMapper;
	
	@Autowired
	ThemeMapper themeMapper;
	
	@Autowired
	PostCountMapper postCountMapper;
	
	@Autowired
	IntegrationMapper IntegrationMapper;
	@Autowired
	ThemeBackMapper themeBackMapper;
	@Autowired
	ThemeBackReadMapper themeBackReadMapper;
	@Autowired
	UserdetailMapper userdetailMapper;
	
	@Override
	public int insertPost(Theme theme,PostCount postCount) {
		// TODO Auto-generated method stub
		int rows = themeMapper.insertSelective(theme);
		postCount.setPostId(theme.getPostId());

		postCountMapper.insert(postCount);
		return rows;
	}

	@Override
	public ArrayList<ThemeRead> findPostList(Integer area) {
		// TODO Auto-generated method stub
		ArrayList<ThemeRead> themeList = new ArrayList<>();
		themeList = themeReadMapper.selectAllByArea(area);
		return themeList;
	}
	
	@Override
	public ArrayList<ThemeRead> findGoodPostList(Integer area) {
		// TODO Auto-generated method stub
		
//		return themeReadMapper.selectAllByGood();
		return themeReadMapper.selectAllByGoodAndArea(area);
	}

	@Override
	public Integration findIntegration(String userId) {
		// TODO Auto-generated method stub
		return IntegrationMapper.selectByPrimaryKey(userId);
		
	}

	@Override
	public ThemeRead findThemeContent(Integer postId) {
		// TODO Auto-generated method stub
		ThemeRead themeRead = themeReadMapper.selectPostById(postId);
		return themeRead;
	}

	@Override
	public int insertPostBack(ThemeBack themeBack) {
		// TODO Auto-generated method stub
		return themeBackMapper.insertSelective(themeBack);
	}

	@Override
	public ArrayList<ThemeBackRead> findThemeBack(Integer backThemeId) {
		// TODO Auto-generated method stub
		return themeBackReadMapper.selectByBackThemeId(backThemeId);
	}

	@Override
	public int updatePostCount(PostCount postCount) {
		// TODO Auto-generated method stub
		int rows = postCountMapper.updateByPostId(postCount);
		return rows;
	}

	@Override
	public PostCount findPostCount(Integer postId) {
		// TODO Auto-generated method stub
		return postCountMapper.selectByPostId(postId);
	}

	@Override
	public ArrayList<ThemeRead> findPostListBySearch(String sql) {
		// TODO Auto-generated method stub
		return themeReadMapper.selectAllBySearch(sql);
	}
//
	@Override
	public int updateTheme(Theme theme) {
		// TODO Auto-generated method stub
		return themeMapper.updateByPrimaryKeySelective(theme);
	}

	@Override
	public int updateIntegrationGoodAdd(String userId) {
		// TODO Auto-generated method stub
		return IntegrationMapper.updateGoodPostAddOne(userId);
	}

	@Override
	public int updateIntegrationGoodSub(String userId) {
		// TODO Auto-generated method stub
		return IntegrationMapper.updateGoodPostSubOne(userId);
	}

	@Override
	public int deleteTheme(Integer postId) {
		// TODO Auto-generated method stub
		return themeMapper.deleteByPrimaryKey(postId);
	}

	@Override
	public int deleteThemeBack(Integer backId) {
		// TODO Auto-generated method stub
		return themeBackMapper.deleteByPrimaryKey(backId);
	}

	@Override
	public int deleteThemeBackByPostId(Integer backThemeId) {
		// TODO Auto-generated method stub
		return themeBackMapper.deleteByBackThemeId(backThemeId);
	}

	@Override
	public ArrayList<Theme> findRecentBack() {
		// TODO Auto-generated method stub
		return themeMapper.selectPostByRecentBack();
	}

	@Override
	public ArrayList<Theme> findRecentPost(String isNav) {
		// TODO Auto-generated method stub
		return themeMapper.selectThemeByRecentPost(isNav);
	}

	@Override
	public List<Banner> findBannerList(String isEnable) {
		// TODO Auto-generated method stub
		return themeMapper.selectBannerList(isEnable);
	}

	@Override
	public ArrayList<Userdetail> findUserdetailsByPmsArea(String area) {
		// TODO Auto-generated method stub
		return userdetailMapper.selectByPmsArea(area);
	}

	@Override
	public int insertBannerList(List<Theme> rows) {
		List<Banner> banners = new ArrayList<>();
		rows.forEach(x->{
			//内容有图片的保存下来
			int imgIndex = x.getContent().indexOf("<img ");
			if(imgIndex!=-1){
				int index = x.getContent().indexOf("http",imgIndex);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String curDate = sdf.format(new Date());
				if(index!=-1){
					Banner banner = new Banner();

					//获取图片第一个双引号开始下标
//					int startIndex = x.getContent().lastIndexOf("\"", index)-1;
					int startIndex = index;
					//获取图片第二个双引号开始下标
					int endIndex = x.getContent().indexOf("\'", index);
					String picUrl = x.getContent().substring(startIndex, endIndex);
					banner.setPostId(x.getPostId());
					banner.setBigPicUrl(picUrl);
					banner.setSmallPicUrl(picUrl);
					banner.setMainTitle(x.getTitle());
					banner.setSubTitle(null);
					String url = "content/showDetail?postId="+x.getPostId()+"&userId="+x.getUserId()+"&area="+x.getArea();
					banner.setPostUrl(url);
					banner.setArea(x.getArea());
					banner.setIsEnable("Y");
					banner.setCreationDate(curDate);
					banners.add(banner);
				}
			}


		});
		List<Banner> exsit = new ArrayList<>();
		if(banners.size()>0){
			//取消之前的轮播图
			PageHelper.startPage(1, banners.size());
			Page<Banner> tu = (Page<Banner>) this.findBannerList("Y");
			exsit = tu.getResult();
		}

		//保存新轮播
		banners.forEach(x->{
			themeMapper.insertBannerSelective(x);
		});
		//更新旧轮播状态
		exsit.forEach(x->{
			themeMapper.updateBannerEnableById(x.getId());
		});
		return banners.size();
	}


}
