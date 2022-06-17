package ssm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import ssm.po.*;
import ssm.po.readonly.IntegrationUsersRead;
import ssm.po.readonly.ThemeBackRead;
import ssm.po.readonly.ThemeRead;

public interface ContentService {

	int insertPost(Theme theme,PostCount postCount);
	
	ArrayList<ThemeRead> findPostList(Integer area);
	
	ArrayList<ThemeRead> findGoodPostList(Integer area);
	
	Integration findIntegration(String userId);
	
	ThemeRead findThemeContent(Integer postId);
	
	int insertPostBack(ThemeBack themeBack);
	
	ArrayList<ThemeBackRead> findThemeBack(Integer backThemeId);
	
	int updatePostCount(PostCount postCount);

	PostCount findPostCount(Integer postId);
	
	ArrayList<ThemeRead> findPostListBySearch(String sql);
	
	int updateTheme(Theme theme);
	
	int updateIntegrationGoodAdd(String userId);
	int updateIntegrationGoodSub(String userId);
	
	int deleteTheme(Integer postId);
	
	int deleteThemeBack(Integer backId);
	int deleteThemeBackByPostId(Integer backThemeId);
	
	ArrayList<Theme> findRecentBack();
	
	ArrayList<Theme> findRecentPost(String isNav);

	List<Banner> findBannerList(String isEnable);
	
	ArrayList<Userdetail> findUserdetailsByPmsArea(String area);

	int insertBannerList(List<Theme> rows);
}
