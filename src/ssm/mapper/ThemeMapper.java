package ssm.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import ssm.po.Banner;
import ssm.po.Theme;

public interface ThemeMapper {
    int deleteByPrimaryKey(Integer postId);

    int insertSelective(Theme record);
    int insertBannerSelective(Banner record);

    Theme selectByPrimaryKey(Integer postId);

    int updateByPrimaryKeySelective(Theme record);

    int updateBannerEnableById(Integer id);

    ArrayList<Theme> selectPostByRecentBack();
    
    ArrayList<Theme> selectThemeByRecentPost(@Param(value = "isNav")String isNav);

    List<Banner> selectBannerList(@Param(value = "isEnable")String isEnable);

  
}