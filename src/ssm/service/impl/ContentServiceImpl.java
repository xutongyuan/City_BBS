package ssm.service.impl;

import java.util.ArrayList;


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
import ssm.po.Integration;
import ssm.po.PostCount;
import ssm.po.Theme;
import ssm.po.ThemeBack;
import ssm.po.Userdetail;
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
	public ArrayList<Userdetail> findUserdetailsByPmsArea(String area) {
		// TODO Auto-generated method stub
		return userdetailMapper.selectByPmsArea(area);
	}

	


}
